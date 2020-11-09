`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 09:58:53
// Design Name: 
// Module Name: en_led
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


module en_led(
input state,
input [15:0]is_empty,
input [5:0]putin_num,  //´æÏäµÄ±àºÅ
input [5:0]takeout_num,  //È¡ÏäµÄ±àºÅ
output reg [15:0]led
    );
    always@(*) begin
    if(state == 0) led = is_empty;
    else if(state == 1) begin
        led = 16'h0000;
        led[putin_num] = 1;
        end
    else if(state == 2) begin
        led = 16'h0000;
        led[takeout_num] = 1;
        end
    end
    
endmodule
