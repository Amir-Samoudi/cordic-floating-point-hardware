// Fixed-point reciprocal based on the CORDIC algorithm

////////////////////////////////

module reciprocal #(
    parameter FLOAT_SIZE = 24,
    parameter INT_SIZE = 8
) (
    input clk, rst,
    input start,
    input signed [INT_SIZE + FLOAT_SIZE - 1:0] x,

    output signed [INT_SIZE + FLOAT_SIZE - 1:0] out,
    output done
);

    wire loadX, start_cordic;

    reciprocal_DP #(.FLOAT_SIZE(FLOAT_SIZE), .INT_SIZE(INT_SIZE)) DP(
        .clk(clk),
        .rst(rst),
        .x(x),
        .loadX(loadX),
        .start_cordic(start_cordic),
        .out(out),
        .done_cordic(done)
    );

    reciprocal_CU CU(
        .clk(clk),
        .rst(rst),
        .start(start),
        .done_cordic(done),
        .loadX(loadX),
        .start_cordic(start_cordic)
    );
    
endmodule
