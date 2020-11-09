`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 20:28:19
// Design Name: 
// Module Name: produce_boxnum
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


module produce_boxnum(
input clk,
output reg [5:0]boxnum
    );
    reg [5:0] num = 5'd0;
    
    always@(posedge clk)  begin
        if(num == 15) num <= 5'd0;
        else num <= num + 1;
    end
    
    always@(*) begin
        boxnum <= num;
    end    
endmodule
