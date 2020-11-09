`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 15:07:44
// Design Name: 
// Module Name: trans_dig
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


module trans_dig(
input [3:0]num,
output reg [7:0]dig_num
    );
    
    always@(*) begin
  case(num)  //将hex0的值转化为七段数码管显示码
    0:dig_num <= 8'b10111111;  //0
    1:dig_num <= 8'b10000110;  //1
    2:dig_num <= 8'b11011011;  //2
    3:dig_num <= 8'b11001111;  //3
    4:dig_num <= 8'b11100110; // 4
    5:dig_num <= 8'b11101101; // 5
    6:dig_num <= 8'b11111101; // 6
    7:dig_num <= 8'b10000111; // 7
    8:dig_num <= 8'b11111111; // 8
    9:dig_num <= 8'b11100111; // 9
    10:dig_num <= 8'b11110111; // A
    11:dig_num <= 8'b11111100; // b
    12:dig_num <= 8'b11011000; // c
    13:dig_num <= 8'b11011110; // d
    14:dig_num <= 8'b11111001; // E
    15:dig_num <= 8'b11110001; // F
    default:dig_num <= 8'b00000000;//不显示
    endcase
  end
endmodule
