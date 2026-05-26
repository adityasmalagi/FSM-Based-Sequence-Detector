`timescale 1ns / 1ps

module fsm_1010_tb();

reg clk,rst,din;
wire detected;

fsm_1010_nol dut(clk,rst,din,detected);

initial
    begin
     {clk,rst,din} = 0;
     end
 
 always #5 clk = ~clk;
 
initial
    begin
       rst = 1'b1;
       #10;
       rst = 1'b0;
       #10;
       din = 1'b1;
       #10;
       din = 1'b0;
       #10;
       din = 1'b1;
       #10;
       din = 1'b0;
    
    end
endmodule
