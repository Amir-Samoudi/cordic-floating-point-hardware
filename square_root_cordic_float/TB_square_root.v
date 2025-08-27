`timescale 1ns/1ns
module TB_square_root_float ();
    
    reg clk = 0, rst;
    reg start = 0;
    reg [31:0] u;

    wire [31:0] out;
    wire done, neg_flag;

    localparam NUM_ITER = 16;

    square_root_float #(.NUM_ITER(NUM_ITER)) UUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .u(u),
        .out(out),
        .done(done),
        .neg_flag(neg_flag)
    );

    always #5 clk = ~clk;

    initial begin
        #10 rst = 1;
        #10 rst = 0;

        /////////// Test 1
        #10 u = 32'h3F800000; // decimal = 1.0
            // Expected sqrt(1.0) = 1.0 = 0x3F800000  (not pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 2
        #300 u = 32'h40000000; // decimal = 2.0
            // Expected sqrt(2.0) ≈ 1.41421356 = 0x3FB504F3 (pass)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 3
        #300 u = 32'h40400000; // decimal = 3.0
            // Expected sqrt(3.0) ≈ 1.73205081 = 0x3FDDB3D7 
        #10 start = 1;
        #20 start = 0;

        /////////// Test 4
        #300 u = 32'h40800000; // decimal = 4.0
            // Expected sqrt(4.0) = 2.0 = 0x40000000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 5
        #300 u = 32'h40A00000; // decimal = 5.0
            // Expected sqrt(5.0) ≈ 2.23606797 = 0x4011C5BF
        #10 start = 1;
        #20 start = 0;

        /////////// Test 6: Small number
        #300 u = 32'h3F000000; // decimal = 0.5
            // Expected sqrt(0.5) ≈ 0.70710678 = 0x3F3504F3
        #10 start = 1;
        #20 start = 0;

        /////////// Test 7: Smaller number
        #300 u = 32'h3E800000; // decimal = 0.25
            // Expected sqrt(0.25) = 0.5 = 0x3F000000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 8: Larger number
        #300 u = 32'h41100000; // decimal = 9.0
            // Expected sqrt(9.0) = 3.0 = 0x40400000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 9
        #300 u = 32'h3F4CCCCD; // decimal = 0.8
            // Expected sqrt(0.8) ≈ 0.89442719 = 0x3F5EB851
        #10 start = 1;
        #20 start = 0;

        /////////// Test 10: Small number
        #300 u = 32'h3DCCCCCD; // decimal = 0.1
            // Expected sqrt(0.1) ≈ 0.31622777 = 0x3EA1E5F8
        #10 start = 1;
        #20 start = 0;

        /////////// Test 11: Zero
        #400 u = 32'h00000000; // decimal = 0.0
            // Expected sqrt(0.0) = 0.0 = 0x00000000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 12: Small positive number near 1
        #400 u = 32'h3F800001; // decimal ≈ 1.000000119
            // Expected sqrt(1.000000119) ≈ 1.0000000596 = 0x3F800000 (rounded)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 13: Negative number (should handle as invalid)
        #400 u = 32'hBF800001; // decimal ≈ -1.000000119
            // Expected sqrt(-1.000000119) = NaN = 0xFFC00000 (neg_flag should be set)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 14: Large number
        #400 u = 32'h41000000; // decimal = 8.0
            // Expected sqrt(8.0) ≈ 2.82842712 = 0x402D70A4
        #10 start = 1;
        #20 start = 0;

        /////////// Test 15: Large negative number (should handle as invalid)
        #400 u = 32'hC44B1AF7; // decimal ≈ -812.4213
            // Expected sqrt(-812.4213) = NaN = 0xFFC00000 (neg_flag should be set)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 16: Very small positive number
        #400 u = 32'h00000001; // decimal ≈ 1.4E-45
            // Expected sqrt(1.4E-45) ≈ 1.18E-22 = 0x033A0000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 17: Very small negative number (should handle as invalid)
        #400 u = 32'h80000001; // decimal ≈ -1.4E-45
            // Expected sqrt(-1.4E-45) = NaN = 0xFFC00000 (neg_flag should be set)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 18: Positive infinity
        #400 u = 32'h7F800000; // decimal = +INF (positive infinity)
            // Expected sqrt(+INF) = +INF = 0x7F800000
        #10 start = 1;
        #20 start = 0;

        /////////// Test 19: Negative infinity
        #400 u = 32'hFF800000; // decimal = -INF (negative infinity)
            // Expected sqrt(-INF) = NaN = 0xFFC00000 (neg_flag should be set)
        #10 start = 1;
        #20 start = 0;

        /////////// Test 20: NaN (Not a Number)
        #400 u = 32'h7FC00000; // decimal = NaN
            // Expected sqrt(NaN) = NaN = 0x7FC00000
        #10 start = 1;
        #20 start = 0;

        #500 $stop;
    end
endmodule

