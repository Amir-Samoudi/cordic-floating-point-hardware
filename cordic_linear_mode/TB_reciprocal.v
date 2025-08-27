`timescale 1ns/1ns

module TB_reciprocal();

    localparam FLOAT_SIZE = 24;
    localparam INT_SIZE = 8;

    reg clk = 0, rst;
    reg start;
    reg signed [INT_SIZE + FLOAT_SIZE - 1:0] x;

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] out;
    wire done;

    reciprocal  #(.FLOAT_SIZE(FLOAT_SIZE), .INT_SIZE(INT_SIZE)) UUT(
        .clk(clk),
        .rst(rst),
        .start(start),
        .x(x),
        .out(out),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin

        #10 rst = 1;
        #10 rst = 0;


        /////////// test1
        #10 x = 32'h01_800000;
            // out = 0.66  = 00.AAAAAAAAAAAAAAAABA68
        #10 start = 1;
        #20 start = 0;
        
        ///////////  test2
        #300 x = 32'h3f_7ae147;  //  63.48 
            // out = 00.0408635E0B4AAFD4222D

        #10 start = 1;
        #20 start = 0;

        //////////  test3
        #300 x = 32'h10_400000;  //  15.25
            // out = 0.06557377049180 = 0X0.10C9714FBCDA3AC1138F   (with some error)
        #10 start = 1;
        #20 start = 0;

        ////////// test4
        #300 x = 32'h01_7bcd35;  //  1.4836
            // out = 0.6740361 = 0X0.AC8DA1B787131E704F73
        #10 start = 1;
        #20 start = 0;

        //////////  test5
        #300 x = 32'h01_d24207;  //  1.82132 
            // out = 0.5490523356686 = 0X0.8C8EB1A17D3C948A8FB4
        #10 start = 1;
        #20 start = 0;

        #500 $stop;
    end

endmodule

