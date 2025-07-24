`timescale 1ns / 1ps

//module TESTPC;
//    reg Ep_, Cp_, Clr__, Clk__;
//    wire [3:0] W_;
//    PC pc1 (W_,Cp_,Ep_,Clk__,Clr__);
    
//    initial 
//        begin 
//            Clk__ = 1'b1; 
//            #2 Clr__ = 1'b0;
//            #5 Clr__ = 1'b1;
//        end
    
//    always #5 Clk__ = ~(Clk__);
    
//    initial 
//        begin 
//            #2;
//            #5 Ep_ = 1'b0; Cp_ = 1'b0;
//            #5 Ep_ = 1'b0; Cp_ = 1'b1;
//            #5 Ep_ = 1'b1; Cp_ = 1'b1;
//            #5 Ep_ = 1'b1; Cp_ = 1'b1;
//            #5 Ep_ = 1'b1; Cp_ = 1'b1; Clr__ = 1'b0; 
//            #5 Ep_ = 1'b1; Cp_ = 1'b1; Clr__ = 1'b1; 
//            #5 Ep_ = 1'b1; Cp_ = 1'b0;
//            #5 Ep_ = 1'b1; Cp_ = 1'b0;
//            #5 Ep_ = 1'b1; Cp_ = 1'b0;
//            #5 Ep_ = 1'b1; Cp_ = 1'b1;
//        end
    
//    initial #100 $finish;                   
        
//endmodule

//module TESTDP;
//    reg Clr, Clk;
//    reg [11:0] ContWord;
//    wire Clk_, Clr_;
//    wire [3:0] OpCode;
//    wire [7:0] DispOut, W, Ain, Aout, Wadda, Waddb;
//    assign Clk_ = ~Clk, Clr_ = ~Clr;
//    DATAPATH dp(Clk, Clk_, Clr, Clr_, ContWord, OpCode, DispOut, W, Ain, Aout, Wadda, Waddb);
    
//    initial 
//        begin
//            #1 Clr = 1'b1;
//            #1 Clr = 1'b0;
//        end
        
//    initial
//        begin
//            #2;
//            #10 ContWord = 12'h5e3; // lda
//            #10 ContWord = 12'hbe3;
//            #10 ContWord = 12'h263;
//            #10 ContWord = 12'h1a3;
//            #10 ContWord = 12'h2c3;
//            #10 ContWord = 12'h3e3;
            
//            #10 ContWord = 12'h5e3; // add
//            #10 ContWord = 12'hbe3;
//            #10 ContWord = 12'h263;
//            #10 ContWord = 12'h1a3;
//            #10 ContWord = 12'h2e1;
//            #10 ContWord = 12'h3c7;
            
//            #10 ContWord = 12'h5e3; // add
//            #10 ContWord = 12'hbe3;
//            #10 ContWord = 12'h263;
//            #10 ContWord = 12'h1a3;
//            #10 ContWord = 12'h2e1;
//            #10 ContWord = 12'h3c7;
            
//            #10 ContWord = 12'h5e3; // sub
//            #10 ContWord = 12'hbe3;
//            #10 ContWord = 12'h263;
//            #10 ContWord = 12'h1a3;
//            #10 ContWord = 12'h2e1;
//            #10 ContWord = 12'h3cf;
            
//            #10 ContWord = 12'h5e3; // out
//            #10 ContWord = 12'hbe3;
//            #10 ContWord = 12'h263;
//            #10 ContWord = 12'h3f2;
//            #10 ContWord = 12'h3e3;
//            #10 ContWord = 12'h3e3;
//        end
    
//    always 
//        begin
//            Clk = #6 1;
//            Clk = #4 0;
//        end  
        
//    initial  Clk = 1'b0;
    
//    initial #500 $finish;                   
        
//endmodule


module TESTSAP_1;
    reg Clr, Clk;
    wire [7:0] LEDOUT; wire HLT; wire [11:0] CONTWORD;
    SAP_1 SAPI(Clk, Clr, HLT, LEDOUT, CONTWORD);
    
    initial 
        begin   
            Clk = 1;
            Clr = 1'b1;
            #7;
            Clr = 1'b0;
            #5;
        end
    always 
        begin
            Clk = #5 ~Clk;
        end 
    
    initial #400 $finish;                   
        
endmodule
