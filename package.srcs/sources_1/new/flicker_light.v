`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/17 13:46:51
// Design Name: 
// Module Name: flicker_light
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


module flicker_light(
input clk,
output reg flicker
    );
    integer count;
    reg clk2 = 1'b1;
    
    always @(posedge clk) begin
    if(count == 20000000) begin count <= 0; clk2 <= ~clk2; end
    else count <= count + 1;
    end
    
    always@(*) begin
    flicker <= clk2;
    end
    
endmodule
