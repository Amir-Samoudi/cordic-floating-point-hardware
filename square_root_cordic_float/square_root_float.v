module square_root_float #(
    parameter NUM_ITER = 16
) (
    input clk, rst,
    input start,
    input [31:0] u,

    output [31:0] out,
    output done, neg_flag
);

    // Internal signals
    wire loadS, loadE, loadM;
    wire loadE_out;
    wire [1:0] src_x;
    wire src_y;
    wire loadX, loadY;
    wire init_cnt, en_cnt;
    wire co, repeat_iter, neg, zero_flag, one_flag;

    square_root_cordic_DP #(.NUM_ITER(NUM_ITER) ) DP (
        .clk(clk),
        .rst(rst),
        .u(u),
        .loadS(loadS),
        .loadE(loadE),
        .loadM(loadM),
        .loadE_out(loadE_out),
        .src_x(src_x),
        .src_y(src_y),
        .loadX(loadX),
        .loadY(loadY),
        .init_cnt(init_cnt),
        .en_cnt(en_cnt),
        .out(out),
        .co(co),
        .repeat_iter(repeat_iter),
        .neg(neg),
        .zero_flag(zero_flag),
        .one_flag(one_flag)
    );

    square_root_cordic_CU CU (
        .clk(clk),
        .rst(rst),
        .start(start),
        .co(co),
        .repeat_iter(repeat_iter),
        .neg(neg),
        .zero_flag(zero_flag),
        .one_flag(one_flag),
        .loadS(loadS),
        .loadE(loadE),
        .loadM(loadM),
        .loadE_out(loadE_out),
        .src_x(src_x),
        .src_y(src_y),
        .loadX(loadX),
        .loadY(loadY),
        .init_cnt(init_cnt),
        .en_cnt(en_cnt),
        .done(done),
        .neg_flag(neg_flag)
    );

endmodule

