module cordic_linear #(
    parameter FLOAT_SIZE = 24,
    parameter INT_SIZE = 8
) (
    input clk, rst,
    input start,
    input signed [INT_SIZE + FLOAT_SIZE - 1:0] x, y, z,
    input mode,

    output signed [INT_SIZE + FLOAT_SIZE - 1:0] x_out, y_out, z_out,
    output done
);
    // Internal signals
    wire loadX, loadY, loadZ, loadMode;
    wire sel_input, adder_mode;
    wire init_cnt, en_cnt;
    wire co, phi;

    cordic_linear_DP #(.FLOAT_SIZE(FLOAT_SIZE), .INT_SIZE(INT_SIZE)) DP (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y),
        .z(z),
        .mode(mode),
        .loadX(loadX),
        .loadY(loadY),
        .loadZ(loadZ),
        .loadMode(loadMode),
        .sel_input(sel_input),
        .adder_mode(adder_mode),
        .init_cnt(init_cnt),
        .en_cnt(en_cnt),
        .x_out(x_out),
        .y_out(y_out),
        .z_out(z_out),
        .co(co),
        .phi(phi)
    );

    cordic_linear_CU CU (
        .clk(clk),
        .rst(rst),
        .start(start),
        .co(co),
        .phi(phi),
        .loadX(loadX),
        .loadY(loadY),
        .loadZ(loadZ),
        .loadMode(loadMode),
        .sel_input(sel_input),
        .adder_mode(adder_mode),
        .init_cnt(init_cnt),
        .en_cnt(en_cnt),
        .done(done)
    );

endmodule

