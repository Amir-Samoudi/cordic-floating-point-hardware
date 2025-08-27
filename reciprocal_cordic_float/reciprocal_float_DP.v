module reciprocal_float_DP (
    input clk, rst,
    input [31:0] x,
    
    input loadE, loadM, loadS,
    input selE, start_cordic,

    output [31:0] out,
    output done_cordic, zero_flag
);

    wire [7:0] E_val, E_in;
    wire [7:0] out_sub, E_reg_in;

    assign E_in = x[30:23];
    register_param #(.BIT_LENGTH(8)) E_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadE),
        .parIn(E_reg_in),
        .parOut(E_val)
    );

    wire [22:0] M_val, M_in;
    assign M_in = x[22:0];
    register_param #(.BIT_LENGTH(23)) M_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadM),
        .parIn(M_in),
        .parOut(M_val)
    );

    wire S_val, S_in;
    assign S_in = x[31];
    register_param #(.BIT_LENGTH(1)) S_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadS),
        .parIn(S_in),
        .parOut(S_val)
    );

    assign E_reg_in = (selE == 1) ? E_in : out_sub;

    wire frac_zero;
    assign frac_zero = ~(|M_val);
    wire cin;
    assign cin = (frac_zero == 1) ? 1'b1 : 1'b0;
    assign out_sub = $unsigned(8'd253) - $unsigned(E_val) + cin;


    // 2 bit INT, 24 bits FRAC
    localparam FLOAT_SIZE = 24;
    localparam INT_SIZE = 2;

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] x_in, z, y;
    assign y = { {(INT_SIZE-1){1'b0}}, 1'b1, {(FLOAT_SIZE){1'b0}} }; // one
    assign z = {(INT_SIZE + FLOAT_SIZE){1'b0}}; // zero
    assign x_in = { 2'b01, M_val, 1'b0};

    wire mode;
    assign mode = 1'b1; // vector mode

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] x_out, y_out, z_out;

    cordic_linear #(.FLOAT_SIZE(FLOAT_SIZE), .INT_SIZE(INT_SIZE)) Cordic_core(
        .clk(clk),
        .rst(rst),
        .start(start_cordic),
        .x(x_in),
        .y(y),
        .z(z),
        .mode(mode),
        .x_out(x_out),
        .y_out(y_out),
        .z_out(z_out),
        .done(done_cordic)
    );

    assign out = {S_val, E_val, z_out[22:0] };

    wire exp_zero;
    assign exp_zero = ~(|E_val);

    assign zero_flag = exp_zero && frac_zero;
endmodule
