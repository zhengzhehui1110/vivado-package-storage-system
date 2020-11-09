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
//存包按键：S4；   取包按键：S1；   确认按键：S0；   输入按键：S3；

module main(
input clk,
input save_in,  //存包键
input take_out,  //取包键
input confirm,  //确认键
input enter,   //输入键
input [15:0]enter_password,  //16位拨码开关
output reg [15:0]led,  //16个led
output wire [7:0]dig_len,   //数码管使能
output reg [7:0]segs0,  //接收右4位数码管需要显示的数字显示码
output reg [7:0]segs1  //接收左4位数码管需要显示的数字显示码
    );
    
    reg [15:0]is_empty = 16'hffff;  //空箱标记
    reg [5:0]empty_num = 5'd16;   //空箱的数量
    wire [1:0]state ;  //状态机的现态
    wire clk1 ;  //1kHz时钟
    wire flicker ;  //led的闪烁
    reg [5:0] putin_num = 0;  //取定存箱时的箱号 0~15
    reg [5:0] takeout_num = 0;  //取箱时的箱号 0~15
    reg [15:0] password [15:0];   //16个16位密码寄存器组 
    reg istake = 0;   //取件标志位，成功为1，不成功为0
    reg isinput = 0;   //输入标志位，取包状态下完成输入为1，否则为0
    wire iswait ;   //等待标志位，取包状态下完成延时为1，否则为0
    reg iscertain = 0;
    integer i;  //for循环计数变量
    integer j;  //for循环计数变量
    integer k;  //for循环计数变量
    integer l;  //for循环计数变量
    
    wire [7:0] random_num;  //滚动d11~hff的随机数
    wire [15:0]random_hex4;   //滚动4位16进制随机数
    wire [5:0]random_boxnum;  //滚动1位16进制存箱号
    reg [15:0]random_password = 16'h0000;  //取定的4位16进制随机密码
    
    //数码管显示所需变量
    //reg [7:0]en;   //决定数码管哪些位可以显示
    reg [5:0]putin_num_print;    //0~15的箱号转为1~16
    wire [3:0]scan;   //数码管扫描位
    wire [7:0]dig_emptynum1 ;  //空箱数个位的数码管显示码
    wire [7:0]dig_emptynum2 ;  //空箱数十位的数码管显示码
    wire [3:0]dec_emptynum1; //空箱数的个位
    wire [3:0]dec_emptynum2; //空箱数的十位
    wire [7:0]dig_putinnum1;  //存箱编号个位的数码管显示码
    wire [7:0]dig_putinnum2;  //存箱编号十位的数码管显示码
    wire [3:0]dec_putinnum1;  //存箱编号个位
    wire [3:0]dec_putinnum2;  //存箱编号十位
    wire [7:0]dig_en_password1;  //拨码开关输入密码，右1显示码
    wire [7:0]dig_en_password2;  //拨码开关输入密码，右2显示码
    wire [7:0]dig_en_password3;  //拨码开关输入密码，右3显示码
    wire [7:0]dig_en_password4;  //拨码开关输入密码，右4显示码
    wire [7:0]dig_random_password1;  //随机生成的密码，右1显示码
    wire [7:0]dig_random_password2;  //随机生成的密码，右2显示码
    wire [7:0]dig_random_password3;  //随机生成的密码，右3显示码
    wire [7:0]dig_random_password4;  //随机生成的密码，右4显示码
    
    state_machine f0(clk, is_empty, save_in, take_out, confirm, iswait, state);  //状态机，0：欢迎界面，1：存包，2：取包
    div_clk1 f1(clk, clk1);  //1kHz时钟分频
    produce_random f3(clk, random_num);   //生成d11~hff的随机数
    produce_password f15(clk, random_num, random_hex4);   //生成4位16进制随机数
    produce_boxnum f16(clk, random_boxnum);   //生成0~d15的存箱箱号
    
    always@(putin_num) begin
        putin_num_print <= putin_num + 1;
    end
    
    en_tube f4(clk1, dig_len, scan);   //八位数码管扫描使能
    hex_to_dec f5(empty_num, dec_emptynum1, dec_emptynum2);   //将1位16进制数转为两位十进制：空箱数
    trans_dig f6(dec_emptynum1, dig_emptynum1);  //将空箱数个位转为数码管显示码
    trans_dig f7(dec_emptynum2, dig_emptynum2);  //将空箱数十位转为数码管显示码
    hex_to_dec f8(putin_num_print , dec_putinnum1, dec_putinnum2);   //将1位16进制数转为两位十进制：存箱编号
    trans_dig f9(dec_putinnum1, dig_putinnum1);  //将存箱编号个位转为数码管显示码
    trans_dig f10(dec_putinnum2, dig_putinnum2);  //将存箱编号十位转为数码管显示码
    trans_dig f11(enter_password[3:0], dig_en_password1);   //拨码开关输入的密码右1位转为数码管显示码
    trans_dig f12(enter_password[7:4], dig_en_password2);   //拨码开关输入的密码右2位转为数码管显示码
    trans_dig f13(enter_password[11:8], dig_en_password3);   //拨码开关输入的密码右3位转为数码管显示码
    trans_dig f14(enter_password[15:12], dig_en_password4);   //拨码开关输入的密码右4位转为数码管显示码
    trans_dig f17(random_password[3:0], dig_random_password1);   //随机生成的密码右1位转为数码管显示码
    trans_dig f18(random_password[7:4], dig_random_password2);   //随机生成的密码右2位转为数码管显示码
    trans_dig f19(random_password[11:8], dig_random_password3);   //随机生成的密码右3位转为数码管显示码
    trans_dig f20(random_password[15:12], dig_random_password4);   //随机生成的密码右4位转为数码管显示码
    
    always@(posedge clk) begin //当状态0到1的瞬间取定随机的密码和箱号
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
    
    always@(posedge clk) begin   //寄存器组的控制
    if(state == 1 && iscertain == 1) password[putin_num] = random_password; //取定的密码存入密码寄存器组
    else if(state == 2 && istake == 1) password[takeout_num] = 16'h0000;//取出时对应的密码清零
    else begin password[putin_num] <= password[putin_num]; password[takeout_num] = password[takeout_num]; end //其他时候保持不变
    end
    
    always@(posedge clk) begin  //空箱状态的改变
    if(state == 1 && iscertain == 1) begin //如果在存包
        //empty_num = empty_num - 1;  //空箱数-1
        is_empty[putin_num] <= 1'b0;  //对应被存入的箱子状态设置为“非空”
        /*for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(k == putin_num) is_empty[k] = 0;
            else is_empty[k] = is_empty[k];
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end*/
        end
    else if(state == 2 && istake == 1 && iswait == 1) begin  //如果取包成功
        //empty_num = empty_num + 1;  //空箱数+1
        is_empty[takeout_num] <= 1'b1;  //对应被取出的箱子状态设置为“空”
        /*for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(k == takeout_num) is_empty[k] = 1;
            else is_empty[k] = is_empty[k];
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end*/
        end
    else begin is_empty <= is_empty; end  //其他情况下不能被改变
    end
    
    always@(state or istake )begin
    for(k = 0, empty_num = 0;k < 16;k = k+1) begin
            if(is_empty[k] == 1) empty_num = empty_num + 1;
            else empty_num = empty_num;
            end
    end
    
    always@(posedge clk) begin  //isinput标志位控制，是否完成输入
    if(state == 2 && enter == 1) isinput <= 1'b1;  //当取包状态下按下输入键
    else if(state != 2) isinput <= 1'b0;  //当退出取包状态，还原
    else isinput <= isinput;
    end
    
    always @(posedge clk) begin  //istake控制，判断是否取包成功
    if(isinput == 1 && state == 2) begin   //如果取包状态下已完成输入
        for(i = 0;i < 16 ;i = i+1) begin  //检索寄存器组里的密码
            if( password[i] == enter_password) begin istake = 1'b1; takeout_num = i[5:0]; end  //如果有能对应的密码，则取件成功，记录取出的箱号
            else begin istake = istake; takeout_num = takeout_num; end
            end
        end
    else if(state != 2) istake <= 1'b0;  //当退出取包状态，还原
    end
    
    delay1s f21(clk, isinput, state, iswait);
    
    always@(*) begin   //数码管显示逻辑
    if(state == 0) begin
        segs1 <= 8'b00000000; //左4位无显示
        case(scan)
            0:segs0 <= dig_emptynum1;  //数码管右2位显示空箱数
            1:segs0 <= dig_emptynum2;
            default:segs0 <=  8'b00000000;
        endcase
        end
    else if(state == 1) begin
        case(scan)
           0: segs0 <= dig_random_password1;  //数码管右4位显示随机生成的密码
           1: segs0 <= dig_random_password2;
           2: segs0 <= dig_random_password3;
           3: segs0 <= dig_random_password4;
           6: segs1 <= dig_putinnum1;  //左2位显示随机生成的箱子号
           7: segs1 <= dig_putinnum2;
           default:begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end
        endcase
    end
    else if(state == 2) begin  //取包状态
        if(isinput == 0) begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end //输入键没有按下，未完成输入，无显示
        else if(isinput == 1 && iswait == 0) begin  //输入已完成，但延时未满1s，显示输入的密码
            segs1 <= 8'b00000000;
            case(scan)
                0: segs0 <= dig_en_password1;  //右4位显示密码
                1: segs0 <= dig_en_password2;
                2: segs0 <= dig_en_password3;
                3: segs0 <= dig_en_password4;
                default: segs0 <= 8'b00000000;
                endcase
            end
        else if(iswait == 1 && istake == 1) begin segs0 <= 8'b00000000; segs1 <= 8'b00000000; end  //延时已完成，且密码正确，无显示
        else if(iswait == 1 && istake == 0) begin segs0 <= 8'b11111111; segs1 <= 8'b11111111; end  //延时已完成，密码不正确，显示88888888
        else begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end  //如果程序不正常则不显示，以防万一
    end
    else begin segs0 <=  8'b00000000; segs1 <= 8'b00000000; end  //如果程序不正常则不显示，以防万一
    end
    
    always@(posedge clk) begin   //灯光控制
    if(state == 0) //led = is_empty; //欢迎界面，空箱对应的灯亮
    begin
        for(l = 0;l < 16;l = l+1) begin
            led[l] = is_empty[l];
        end
        end
    else if(state == 1 && iscertain == 1) begin  //存包界面，只有存入的箱对应灯亮
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
            end  //如果取包成功，对应的灯闪烁
        end
        else led = 16'h0000;  //否则灯全不亮
        end
    else led = 16'h0000; //异常状况（state不是0,1,2）灯不亮
    end
    
    flicker_light f22(clk, flicker);
    
endmodule
