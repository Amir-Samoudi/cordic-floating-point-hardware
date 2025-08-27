//  IEEE Standard for Floating-Point Arithmetic (IEEE 754)
// Single-precision floating-point format
`timescale 1ns/1ns
module TB_reciprocal_float ();
    
    reg clk = 0, rst;
    reg start = 0;
    reg [31:0] x;

    wire [31:0] out;
    wire done, zero_flag;

    reciprocal_float  UUT(
        .clk(clk),
        .rst(rst),
        .start(start),
        .x(x),
        .out(out),
        .done(done),
        .zero_flag(zero_flag)
    );

    always #5 clk = ~clk;

    initial begin
         #10 rst = 1;
        #10 rst = 0;


        /////////// Test 1
        #10 x = 32'h3F800000; // decimal = 1.0
            // Expected reciprocal = 1.0 = 0x3F800000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 2
        #400 x = 32'h40000000; // decimal = 2.0
            // Expected reciprocal = 0.5 = 0x3F000000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 3
        #400 x = 32'h40400000; // decimal = 3.0
            // Expected reciprocal = 0.3333333... = 0x3EAAAAAB (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 4
        #400 x = 32'h40800000; // decimal = 4.0
            // Expected reciprocal = 0.25 = 0x3E800000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 5
        #400 x = 32'h40A00000; // decimal = 5.0
            // Expected reciprocal = 0.2 = 0x3E4CCCCD (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 6
        #400 x = 32'h3F000000; // decimal = 0.5
            // Expected reciprocal = 2.0 = 0x40000000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 7
        #400 x = 32'h3E800000; // decimal = 0.25
            // Expected reciprocal = 4.0 = 0x40800000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 8
        #400 x = 32'h41100000; // decimal = 9.0
            // Expected reciprocal = 0.1111111... = 0x3DE38E39 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 9
        #400 x = 32'h3F4CCCCD; // decimal = 0.8
            // Expected reciprocal = 1.25 = 0x3FA00000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 10
        #400 x = 32'h3DCCCCCD; // decimal = 0.1 
            // Expected reciprocal = 10.0 = 0x41200000 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 11: Zero
        #400 x = 32'h00000000; // decimal = 0.0
            // Expected reciprocal = INF (infinity) = 0x7F800000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 12: Small positive number
        #400 x = 32'h3F800001; // decimal ≈ 1.000000119
            // Expected reciprocal ≈ 0.9999998810= 0x3F7FFFFF
        #10 start = 1;
        #20 start = 0;

        /////////// Test 13: Small negative number
        #400 x = 32'hBF800001; // decimal ≈ -1.000000119
            // Expected reciprocal ≈ -0.9999998810= 0xBF7FFFFF
        #10 start = 1;
        #20 start = 0;

        /////////// Test 14: Large positive number
        #400 x = 32'h41000000; // decimal = 8.0
            // Expected reciprocal = 0.125 = 0x3E000000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 15: Large negative number
        #400 x = 32'hc44b1af7; // decimal = -812.4213
            // Expected reciprocal = 0.001230888 = 0xbaa155c3
        #10 start = 1;
        #20 start = 0;

        /////////// Test 16: Small positive fraction
        #400 x = 32'h3DCCCCCD; // decimal ≈ 0.1
            // Expected reciprocal ≈ 10.0 = 0x41200000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 17: Small negative fraction
        #400 x = 32'hBDCCCCCD; // decimal ≈ -0.1
            // Expected reciprocal ≈ -10.0 = 0xC1200000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 18: Very large number
        #400 x = 32'h7F800000; // decimal = +INF (positive infinity)
            // Expected reciprocal = 0.0 = 0x00000000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 19: Very small number
        #400 x = 32'h00000001; // decimal ≈ 1.4E-45
            // Expected reciprocal ≈ 7.0E+44 = 0x7F7FFFFF
        #10 start = 1;
        #20 start = 0;

        /////////// Test 20: Very small negative number
        #400 x = 32'h80000001; // decimal ≈ -1.4E-45
            // Expected reciprocal ≈ -7.0E+44 = 0xFF7FFFFF
        #10 start = 1;
        #20 start = 0;

        //// so on
        #500 $stop;

    end
endmodule
