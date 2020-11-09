`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 17:24:53
// Design Name: 
// Module Name: produce_password
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


module produce_password(
input clk,
input [7:0]random_num,
output reg [15:0]password
    );
    reg [7:0]count = 8'd11;  //生成第二个随机数
    integer div_count = 0;
    reg div_clk = 0;
    
    always@(posedge clk) begin
        password[15:8] = random_num;
        password[7:0] = count;
    end
    
    always@(posedge clk) begin
        if(div_count == 11) begin
            div_count <= 0;
            div_clk <= ~div_clk;
            end
        else div_count <= div_count + 1;
    end
    
    always@(posedge div_clk) begin
        if(count == 8'hff) count = 8'd11;
        else count = count + 1;
    end
endmodule
