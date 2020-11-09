`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 09:29:49
// Design Name: 
// Module Name: div_clk1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module div_clk1(
input clk,
output reg clk1
    );
    integer divcount1 = 0;
    reg clk11 = 1'b0;
    
    always@(*) begin
    clk1 <= clk11;
    end
    
    always @ (posedge clk)    begin//产生1kHz的时钟        
    if(divcount1==17'd49999)   
    begin
        divcount1 <= 17'd0;
        clk11<=~clk11;
   end        
   else divcount1<= divcount1+1;    
   end
endmodule