`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/17 19:38:23
// Design Name: 
// Module Name: package_sim
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


module package_sim(

    );
    reg clk = 1'b0;
    reg save_in;
    reg take_out;
    reg confirm;
    reg enter;
    reg [15:0]enter_password;
    wire [15:0]led;
    wire [7:0]dig_len;
    wire [7:0]segs0;
    wire [7:0]segs1;
    
    main U(.clk(clk),.save_in(save_in),.take_out(take_out),.confirm(confirm),.enter(enter),.enter_password(enter_password),.led(led),.dig_len(dig_len),.segs0(segs0),.segs1(segs1));
    
    always begin
    #1 clk = ~clk;  
    end
    
    initial begin
    #0 begin save_in = 1'b0; take_out = 1'b0; confirm = 1'b0; enter = 1'b0; enter_password = 16'h0000; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    
    #20 begin save_in = 1'b1; end
    #10 begin save_in = 1'b0; end
    #30 begin confirm = 1'b1; end
    #10 begin confirm = 1'b0; end
    #30 $finish;
    end
endmodule
