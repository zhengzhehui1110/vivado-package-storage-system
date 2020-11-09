`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 14:51:24
// Design Name: 
// Module Name: en_tube
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


module en_tube(
input clk1,
output reg [7:0]dig_len,
output reg [3:0]scan
    );
    reg [3:0] scan_cnt = 0;  //数码管扫描位
    
    always@(*) begin
    scan <= scan_cnt;
    end
    
    always@(posedge clk1) begin  //八位数字轮流点亮
        scan_cnt <= scan_cnt + 1;
        if(scan_cnt == 3'd7) scan_cnt <= 0;
   end
   
   always@(*) begin  //八位数字轮流点亮
        case(scan_cnt)
            3'd0:dig_len <= 8'b00000001 ;
            3'd1:dig_len <= 8'b00000010 ;
            3'd2:dig_len <= 8'b00000100 ;
            3'd3:dig_len <= 8'b00001000 ;
            3'd4:dig_len <= 8'b00010000 ;
            3'd5:dig_len <= 8'b00100000 ;
            3'd6:dig_len <= 8'b01000000 ;
            3'd7:dig_len <= 8'b10000000 ;
            default:dig_len <= 8'b00000000 ;
       endcase
   end
  
endmodule
