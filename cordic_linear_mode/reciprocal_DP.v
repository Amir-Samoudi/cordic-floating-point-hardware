module reciprocal_DP #(
    parameter FLOAT_SIZE = 24,
    parameter INT_SIZE = 8
) (
    input clk, rst,
    input signed [INT_SIZE + FLOAT_SIZE - 1:0] x,
    input loadX, start_cordic,

    output signed [INT_SIZE + FLOAT_SIZE - 1:0] out,
    output done_cordic
);

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] x_val;
    register_param #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) X_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadX),
        .parIn(x),
        .parOut(x_val)
    );

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] z, y;
    assign y = { {(INT_SIZE-1){1'b0}}, 1'b1, {(FLOAT_SIZE){1'b0}} }; // one
    assign z = {(INT_SIZE + FLOAT_SIZE){1'b0}}; // zero

    wire mode;
    assign mode = 1'b1; // vector mode

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] x_out, y_out, z_out;

    cordic_linear #(.FLOAT_SIZE(FLOAT_SIZE), .INT_SIZE(INT_SIZE)) Cordic_core(
        .clk(clk),
        .rst(rst),
        .start(start_cordic),
        .x(x_val),
        .y(y),
        .z(z),
        .mode(mode),
        .x_out(x_out),
        .y_out(y_out),
        .z_out(z_out),
        .done(done_cordic)
    );

    assign out = z_out;

endmodule
