`timescale 1ns / 1ps

module PC(output [3:0] W, input Cp, input Ep, input Clk_, input Clr_);
    reg [3:0] count=0;
    assign W = (Ep == 1) ? count : 4'hz;
    always @ (negedge Clk_) if(Cp == 1) count <= count + 1;
endmodule

module MAR(input [3:0] MAR_in, input LM_, CLK, output [7:0] Mem_out, input CE_);
    reg [7:0]mem [15:0];
    reg [3:0]MAR;
    initial
        begin
            mem[0] = 8'h09; mem[1] = 8'h1a; mem[2] = 8'h1b; mem[3] = 8'h2c;
            mem[4] = 8'he0; mem[5] = 8'hfx; mem[6] = 8'hxx; mem[7] = 8'hxx;
            mem[8] = 8'hxx; mem[9] = 8'h10; mem[10] = 8'h14; mem[11] = 8'h18;
            mem[12] = 8'h20; mem[13] = 8'hxx; mem[14] = 8'hxx; mem[15] = 8'hxx;
        end
    always @(posedge CLK) if(LM_==0) MAR=MAR_in;
    assign Mem_out = (CE_ == 0) ? mem[MAR] : 8'hzz;
endmodule

module IR(W, Wlow, Li_, Ei_, Clk, Clr, OpCode);
    input [7:0] W;
    input Li_,Ei_,Clk,Clr;
    output [3:0] OpCode, Wlow;
    reg [7:0] OP=0;
    assign
        Wlow = ~Ei_ ? OP[3:0] : 4'hz,
        OpCode = OP[7:4];
    always @(posedge Clk) if(Li_ == 0) OP = W;
endmodule

module ACC(input La_, Ea, Clk, [7:0] Win, output [7:0] Wout, [7:0] Wadda);
    reg [7:0] A;
    assign Wout = A, Wadda = A;
    always @ (negedge Clk) if(Ea == 0 & La_ == 0) A = Win;
endmodule

module REGB(input Lb_, Clk, output [7:0] Waddb, input [7:0] W);
    reg [7:0] B;
    assign Waddb = B;
    always @ (negedge Clk) if(Lb_ == 0) B = W;
endmodule

module ALU(input Su, Eu, output [7:0] W, input [7:0] Wadda, Waddb);
    wire [7:0] out; wire C;
    assign {C, out} = Su ? Wadda - Waddb : Wadda + Waddb;
    assign W = Eu ? out : 8'hzz;
endmodule

module OPREG(input Lo_, Clk, [7:0] W, output [7:0] DispOut);
    reg [7:0] OP;
    assign DispOut = OP;
    always @ (posedge Clk) if(Lo_ == 0) OP = W;
endmodule

module CLKCTR(input Clk, Clr, CountClr, output T1, T3);
    reg [2:0] cnt=0;
    assign T3 = cnt == 3, T1 = cnt == 6;
    always @ (negedge Clk)
        begin
            if(cnt < 6) cnt = cnt + 1;
            else cnt = 1;
        end
endmodule

module ADDROM(output [3:0] OpCodeStart, input [3:0] OpCode);
    reg [3:0]ADDROM [15:0];
    assign OpCodeStart = ADDROM[OpCode];
    initial
        begin
            ADDROM[0] = 4'h3; ADDROM[1] = 4'h6; ADDROM[2] = 4'h9; ADDROM[3] = 4'hf;
            ADDROM[4] = 4'hz; ADDROM[5] = 4'hz; ADDROM[6] = 4'hz; ADDROM[7] = 4'hz;
            ADDROM[8] = 4'hz; ADDROM[9] = 4'hz; ADDROM[10] = 4'hz; ADDROM[11] = 4'hz;
            ADDROM[12] = 4'hz; ADDROM[13] = 4'hz; ADDROM[14] = 4'hc; ADDROM[15] = 4'hz;
        end
endmodule

module CONTROM(output [11:0] ContWord, input [3:0] OpCodeAdd);
    reg [11:0]CONTROM [15:0];
    assign ContWord = CONTROM[OpCodeAdd];
    initial
        begin
            CONTROM[0] = 12'h5e3; CONTROM[1] = 12'hbe3; CONTROM[2] = 12'h263; CONTROM[3] = 12'h1a3;
            CONTROM[4] = 12'h2c3; CONTROM[5] = 12'h3e3; CONTROM[6] = 12'h1a3; CONTROM[7] = 12'h2e1;
            CONTROM[8] = 12'h3c7; CONTROM[9] = 12'h1a3; CONTROM[10] = 12'h2e1; CONTROM[11] = 12'h3cf;
            CONTROM[12] = 12'h3f2; CONTROM[13] = 12'h3e3; CONTROM[14] = 12'h3e3; CONTROM[15] = 12'h3e3;
        end
endmodule

module PRESCNTR (output [3:0] OpCodeAdd, input [3:0] OpCodeStart, input load, Clr, CountClr, Clk);
    reg [3:0] COUNT=0;
    assign OpCodeAdd = COUNT;
    always @ (negedge Clk) 
        begin
            if (CountClr==0 & load==0) COUNT = COUNT + 1;
            else if (CountClr==0 & load==1) COUNT = OpCodeStart;
            else if (CountClr==1 & load==0) COUNT = 0;
            else if (CountClr==1 & load==1) COUNT = COUNT;
        end
endmodule

module DATAPATH(input Clk, Clk_, Clr, Clr_, [11:0] ContWord, output [3:0] OpCode, [7:0] DispOut);
    wire Cp, Ep, Lm_, CE_, Li_, Ei_, La_, Ea, Su, Eu, Lb_, Lo_;
    wire [7:0] W, Wadda, Waddb, Ain, Aout;
    wire [3:0] Wlow, Whigh; 
    assign
        {Cp, Ep, Lm_, CE_, Li_, Ei_, La_, Ea, Su, Eu, Lb_, Lo_} = ContWord,
        {Whigh, Wlow} = W,
        W = Ea ? Aout : 8'hzz,
        Ain = ~La_ ? W : 8'hzz;
    PC pc(Wlow,Cp,Ep,Clk_,Clr_);
    MAR mar(Wlow,Lm_,Clk,W,CE_);
    IR ir(W,Wlow,Li_,Ei_,Clk,Clr,OpCode);
    ACC a(La_,Ea,Clk,Ain,Aout,Wadda);
    REGB b(Lb_,Clk,Waddb,W);
    ALU alu(Su,Eu,W,Wadda,Waddb);
    OPREG op(Lo_,Clk_,W,DispOut);
endmodule

module SAP_1(input Clk, Clr, output HLT, [7:0] DispOut, [11:0] ContWord);
    wire Clr_, Clk_, T1, T3, CountClr, load;
    wire [3:0] OpCode, OpCodeStart, OpCodeAdd;
    assign 
        Clr_ = ~Clr,
        Clk_ = ~Clk,
        load = T3,
        HLT = (OpCode == 4'hf),
        CountClr =  T1 || Clr;
    CLKCTR cc(Clk, Clr, CountClr, T1, T3); 
    ADDROM ar(OpCodeStart, OpCode);
    PRESCNTR c(OpCodeAdd, OpCodeStart, load, Clr, CountClr, Clk);
    CONTROM cr(ContWord, OpCodeAdd);
    DATAPATH dp(Clk, Clk_, Clr, Clr_, ContWord, OpCode, DispOut);
endmodule





