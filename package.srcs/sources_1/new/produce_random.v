`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 11:25:02
// Design Name: 
// Module Name: produce_random
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


module produce_random(
input clk,
output reg [7:0]random_num
    );
    reg [7:0] count = 8'd11;
    
    always@(*) begin
    random_num = count;
    end
    
    always@(posedge clk)
    if(count == 8'hff) count <= 8'd11;
    else count <= count + 1;
    
endmodule
