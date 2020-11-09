`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 23:31:49
// Design Name: 
// Module Name: delay1s
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


module delay1s(
input clk,
input isinput,
input [1:0]state,
output reg iswait
    );
    integer count = 0;
    always@(posedge clk) begin
    if(state == 2 && isinput == 1) begin  //完成输入后马上开始计数
        if(count == 99999999) begin count <= 0; iswait <= 1; end
        else count <= count +1;
        end
    else if(state == 2 && isinput == 0) count <= 0;  //没有完成输入的时候不开始延时计数
    else if(state != 2) iswait <= 0; //退出取包界面，还原
    end
    
endmodule
