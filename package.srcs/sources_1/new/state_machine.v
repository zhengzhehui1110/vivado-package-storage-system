`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 08:49:30
// Design Name: 
// Module Name: state_machine
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


module state_machine(
input clk,
input [15:0]is_empty,  //�ж�ÿ�������Ƿ��
input save_in,  //�����
input take_out,  //ȡ����
input confirm,  //ȷ�ϼ�
input iswait,  //��־�Ƿ������ʱ1s
output reg [1:0]state
    );
    reg [1:0]current_state = 2'd0;
    reg [1:0]next_state = 2'd0;
    always@(*) begin
        state <= current_state;
    end
    
    always@(posedge clk) begin
    current_state <= next_state;
    end
    
    always@(*) begin
    case(current_state)
        0:begin 
        if(save_in == 1 && is_empty != 16'd0) next_state <= 2'd1;
        else if (take_out == 1 && is_empty < 16'hffff) next_state <= 2'd2;
        else next_state <= 0;
        end
        1:next_state <= (confirm == 1) ? 2'd0:2'd1;   //����ȷ�ϣ��������ص���ӭ����
        2:next_state <= (confirm == 1 && iswait == 1) ? 2'd0:2'd2;
        default:next_state <= current_state;
    endcase
    end
  
endmodule
