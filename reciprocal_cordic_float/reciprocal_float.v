//  IEEE Standard for Floating-Point Arithmetic (IEEE 754)
// Single-precision floating-point format

module reciprocal_float(
    input clk, rst,
    input start,
    input [31:0] x,
    output [31:0] out,
    output done, zero_flag
);

    // Internal signals to connect the datapath and controller
    wire loadE, loadM, loadS;
    wire selE, start_cordic;
    wire done_cordic, zero_input;

    // Instantiate the datapath
    reciprocal_float_DP DP (
        .clk(clk),
        .rst(rst),
        .x(x),
        .loadE(loadE),
        .loadM(loadM),
        .loadS(loadS),
        .selE(selE),
        .start_cordic(start_cordic),
        .out(out),
        .done_cordic(done_cordic),
        .zero_flag(zero_input)
    );

    reciprocal_float_CU CU (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done_cordic(done_cordic),
        .zero_input(zero_input),
        .loadE(loadE),
        .loadM(loadM),
        .loadS(loadS),
        .selE(selE),
        .start_cordic(start_cordic),
        .done(done),
        .zero_flag(zero_flag)
    );

endmodule
