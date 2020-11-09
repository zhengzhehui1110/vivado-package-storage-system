`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 08:36:52
// Design Name: 
// Module Name: main
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
//���������S4��   ȡ��������S1��   ȷ�ϰ�����S0��   ���밴����S3��

module main(
input clk,
input save_in,  //�����
input take_out,  //ȡ����
input confirm,  //ȷ�ϼ�
input enter,   //�����
input [15:0]enter_password,  //16λ���뿪��
output reg [15:0]led,  //16��led
output wire [7:0]dig_len,   //�����ʹ��
output reg [7:0]segs0,  //������4λ�������Ҫ��ʾ��������ʾ��
output reg [7:0]segs1  //������4λ�������Ҫ��ʾ��������ʾ��
    );
    
    reg [15:0]is_empty = 16'hffff;  //������
    reg [5:0]empty_num = 5'd16;   //���������
    wire [1:0]state ;  //״̬������̬
    wire clk1 ;  //1kHzʱ��
    wire flicker ;  //led����˸
    reg [5:0] putin_num = 0;  //ȡ������ʱ����� 0~15
    reg [5:0] takeout_num = 0;  //ȡ��ʱ����� 0~15
    reg [15:0] password [15:0];   //16��16λ����Ĵ����� 
    reg istake = 0;   //ȡ����־λ���ɹ�Ϊ1�����ɹ�Ϊ0
    reg isinput = 0;   //�����־λ��ȡ��״̬���������Ϊ1������Ϊ0
    wire iswait ;   //�ȴ���־λ��ȡ��״̬�������ʱΪ1������Ϊ0
    reg iscertain = 0;
    integer i;  //forѭ����������
    integer j;  //forѭ����������
    integer k;  //forѭ����������
    integer l;  //forѭ����������
    
    wire [7:0] random_num;  //����d11~hff�������
    wire [15:0]random_hex4;   //����4λ16���������
    wire [5:0]random_boxnum;  //����1λ16���ƴ����
    reg [15:0]random_password = 16'h0000;  //ȡ����4λ16�����������
    
    //�������ʾ�������
    //reg [7:0]en;   //�����������Щλ������ʾ
    reg [5:0]putin_num_print;    //0~15�����תΪ1~16
    wire [3:0]scan;   //�����ɨ��λ
    wire [7:0]dig_emptynum1 ;  //��������λ���������ʾ��
    wire [7:0]dig_emptynum2 ;  //������ʮλ���������ʾ��
    wire [3:0]dec_emptynum1; //�������ĸ�λ
    wire [3:0]dec_emptynum2; //��������ʮλ
    wire [7:0]dig_putinnum1;  //�����Ÿ�λ���������ʾ��
    wire [7:0]dig_putinnum2;  //������ʮλ���������ʾ��
    wire [3:0]dec_putinnum1;  //�����Ÿ�λ
    wire [3:0]dec_putinnum2;  //������ʮλ
    wire [7:0]dig_en_password1;  //���뿪���������룬��1��ʾ��
    wire [7:0]dig_en_password2;  //���뿪���������룬��2��ʾ��
    wire [7:0]dig_en_password3;  //���뿪���������룬��3��ʾ��
    wire [7:0]dig_en_password4;  //���뿪���������룬��4��ʾ��
    wire [7:0]dig_random_password1;  //������ɵ����룬��1��ʾ��
    wire [7:0]dig_random_password2;  //������ɵ����룬��2��ʾ��
    wire [7:0]dig_random_password3;  //������ɵ����룬��3��ʾ��
    wire [7:0]dig_random_password4;  //������ɵ����룬��4��ʾ��
    
    state_machine f0(clk, is_empty, save_in, take_out, confirm, iswait, state);  //״̬����0����ӭ���棬1�������2��ȡ��
    div_clk1 f1(clk, clk1);  //1kHzʱ�ӷ�Ƶ
    produce_random f3(clk, random_num);   //����d11~hff�������
    produce_password f15(clk, random_num, random_hex4);   //����4λ16���������
    produce_boxnum f16(clk, random_boxnum);   //����0~d15�Ĵ������
    
    always@(putin_num) begin
        putin_num_print <= putin_num + 1;
    end
    
    en_tube f4(clk1, dig_len, scan);   //��λ�����ɨ��ʹ��
    hex_to_dec f5(empty_num, dec_emptynum1, dec_emptynum2);   //��1λ16������תΪ��λʮ���ƣ�������
    trans_dig f6(dec_emptynum1, dig_emptynum1);  //����������λתΪ�������ʾ��
    trans_dig f7(dec_emptynum2, dig_emptynum2);  //��������ʮλתΪ�������ʾ��
    hex_to_dec f8(putin_num_print , dec_putinnum1, dec_putinnum2);   //��1λ16������תΪ��λʮ���ƣ�������
    trans_dig f9(dec_putinnum1, dig_putinnum1);  //�������Ÿ�λתΪ�������ʾ��
    trans_dig f10(dec_putinnum2, dig_putinnum2);  //��������ʮλתΪ�������ʾ��
    trans_dig f11(enter_password[3:0], dig_en_password1);   //���뿪�������������1λתΪ�������ʾ��
    trans_dig f12(enter_password[7:4], dig_en_password2);   //���뿪�������������2λתΪ�������ʾ��
    trans_dig f13(enter_password[11:8], dig_en_password3);   //���뿪�������������3λתΪ�������ʾ��
    trans_dig f14(enter_password[15:12], dig_en_password4);   //���뿪�������������4λתΪ�������ʾ��
    trans_dig f17(random_password[3:0], dig_random_password1);   //������ɵ�������1λתΪ�������ʾ��
    trans_dig f18(random_password[7:4], dig_random_password2);   //������ɵ�������2λתΪ�������ʾ��
    trans_dig f19(random_password[11:8], dig_random_password3);   //������ɵ�������3λתΪ�������ʾ��
    trans_dig f20(random_password[15:12], dig_random_password4);   //������ɵ�������4λתΪ�������ʾ��
    
    always@(posedge clk) begin //��״̬0��1��˲��ȡ���������������
    if(iscertain == 0 && state == 1 ) begin
    random_password = random_hex4;
    if(is_empty[random_boxnum] == 1) putin_num = random_boxnum;
    else begin
        for(j = 0; j < 16 && is_empty[j] == 0; j = j + 1) begin end
        putin_num = j[5:0];
        end
    iscertain = 1;    
    end
    else if(state != 1) iscertain <= 0;
    end
    
    always@(posedge clk) begin   //�Ĵ�����Ŀ���
    if(state == 1 && iscertain == 1) password[putin_num] = random_password; //ȡ���������������Ĵ�����
    else if(state == 2 && istake == 1) password[takeout_num] = 16'h0000;//ȡ��ʱ��Ӧ����������
    else begin password[putin_num] <= password[putin_num]; password[takeout_num] = password[takeout_num]; end //����ʱ�򱣳ֲ���
    end
    
    always@(posedge clk) begin  //����״̬�ĸı�
    if(state == 1 && iscertain == 1) begin //����ڴ��
        //empty_num = empty_num - 1;  //������-1
        is_empty[putin_num] <= 1'b0;  //��Ӧ�����������״̬����Ϊ���ǿա�
        /*for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(k == putin_num) is_empty[k] = 0;
            else is_empty[k] = is_empty[k];
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end*/
        end
    else if(state == 2 && istake == 1 && iswait == 1) begin  //���ȡ���ɹ�
        //empty_num = empty_num + 1;  //������+1
        is_empty[takeout_num] <= 1'b1;  //��Ӧ��ȡ��������״̬����Ϊ���ա�
        /*for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(k == takeout_num) is_empty[k] = 1;
            else is_empty[k] = is_empty[k];
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end*/
        end
    else begin is_empty <= is_empty; end  //��������²��ܱ��ı�
    end
    
    always@(state or istake )begin
    for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end
    end
    
    always@(posedge clk) begin  //isinput��־λ���ƣ��Ƿ��������
    if(state == 2 && enter == 1) isinput <= 1'b1;  //��ȡ��״̬�°��������
    else if(state != 2) isinput <= 1'b0;  //���˳�ȡ��״̬����ԭ
    else isinput <= isinput;
    end
    
    always @(posedge clk) begin  //istake���ƣ��ж��Ƿ�ȡ���ɹ�
    if(isinput == 1 && state == 2) begin   //���ȡ��״̬�����������
        for(i = 0;i < 16 ;i = i+1) begin  //�����Ĵ������������
            if( password[i] == enter_password) begin istake = 1'b1; takeout_num = i[5:0]; end  //������ܶ�Ӧ�����룬��ȡ���ɹ�����¼ȡ�������
            else begin istake = istake; takeout_num = takeout_num; end
            end
        end
    else if(state != 2) istake <= 1'b0;  //���˳�ȡ��״̬����ԭ
    end
    
    delay1s f21(clk, isinput, state, iswait);
    
    always@(*) begin   //�������ʾ�߼�
    if(state == 0) begin
        segs1 <= 8'b00000000; //��4λ����ʾ
        case(scan)
            0:segs0 <= dig_emptynum1;  //�������2λ��ʾ������
            1:segs0 <= dig_emptynum2;
            default:segs0 <=  8'b00000000;
        endcase
        end
    else if(state == 1) begin
        case(scan)
           0: segs0 <= dig_random_password1;  //�������4λ��ʾ������ɵ�����
           1: segs0 <= dig_random_password2;
           2: segs0 <= dig_random_password3;
           3: segs0 <= dig_random_password4;
           6: segs1 <= dig_putinnum1;  //��2λ��ʾ������ɵ����Ӻ�
           7: segs1 <= dig_putinnum2;
           default:begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end
        endcase
    end
    else if(state == 2) begin  //ȡ��״̬
        if(isinput == 0) begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end //�����û�а��£�δ������룬����ʾ
        else if(isinput == 1 && iswait == 0) begin  //��������ɣ�����ʱδ��1s����ʾ���������
            segs1 <= 8'b00000000;
            case(scan)
                0: segs0 <= dig_en_password1;  //��4λ��ʾ����
                1: segs0 <= dig_en_password2;
                2: segs0 <= dig_en_password3;
                3: segs0 <= dig_en_password4;
                default: segs0 <= 8'b00000000;
                endcase
            end
        else if(iswait == 1 && istake == 1) begin segs0 <= 8'b00000000; segs1 <= 8'b00000000; end  //��ʱ����ɣ���������ȷ������ʾ
        else if(iswait == 1 && istake == 0) begin segs0 <= 8'b11111111; segs1 <= 8'b11111111; end  //��ʱ����ɣ����벻��ȷ����ʾ88888888
        else begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end  //���������������ʾ���Է���һ
    end
    else begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end  //���������������ʾ���Է���һ
    end
    
    always@(posedge clk) begin   //�ƹ����
    if(state == 0) //led = is_empty; //��ӭ���棬�����Ӧ�ĵ���
    begin
        for(l = 0;l < 16;l = l+1) begin
            led[l] = is_empty[l];
        end
        end
    else if(state == 1 && iscertain == 1) begin  //������棬ֻ�д�������Ӧ����
        for(l = 0;l < 16;l = l+1) begin
            if(l == putin_num) led[l] = 1;
            else led[l] = 0;
            end
        end
    else if(state == 2) begin
        if(iswait == 1 && istake == 1) begin
            for(l = 0;l < 16;l = l+1) begin
            if(l == takeout_num) led[l] = flicker;
            else led[l] = 0;
            end  //���ȡ���ɹ�����Ӧ�ĵ���˸
        end
        else led = 16'h0000;  //�����ȫ����
        end
    else led = 16'h0000; //�쳣״����state����0,1,2���Ʋ���
    end
    
    flicker_light f22(clk, flicker);
    
endmodule
