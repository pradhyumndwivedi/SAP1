`timescale 1ns / 1ps

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
