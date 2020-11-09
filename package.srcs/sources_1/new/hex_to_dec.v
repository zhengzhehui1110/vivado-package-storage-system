`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 15:26:36
// Design Name: 
// Module Name: hex_to_dec
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


module hex_to_dec(
input [5:0]hex_num,
output reg [3:0]dec_num1, //十进制的个位
output reg [3:0]dec_num2 //十进制的十位
    );
    
    always@(*) begin
    if(hex_num < 6'd10) begin
        dec_num2 <= 4'd0;
        dec_num1 <= hex_num[3:0] ;
    end
    else begin
        dec_num2 <= 4'd1;
        dec_num1 <= hex_num[3:0] - 4'd10;
    end
    end
endmodule
