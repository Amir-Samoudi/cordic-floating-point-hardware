module cordic_linear_DP #(
    parameter FLOAT_SIZE = 24,
    parameter INT_SIZE = 8
) (
    input clk, rst,
    input signed [INT_SIZE + FLOAT_SIZE - 1:0] x, y, z,
    input mode,

    input loadX, loadY, loadZ,loadMode,
    input sel_input, adder_mode,
    input init_cnt, en_cnt,

    output signed [INT_SIZE + FLOAT_SIZE - 1:0] x_out, y_out, z_out,

    output co, phi
);

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] y_in, z_in;
    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] out_adder_y, out_adder_z;

    assign y_in = (sel_input == 1) ? y : out_adder_y; 
    assign z_in = (sel_input == 1) ? z : out_adder_z; 

    register_param #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) X_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadX),
        .parIn(x),
        .parOut(x_out)
    );

    register_param #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) Y_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadY),
        .parIn(y_in),
        .parOut(y_out)
    );

    register_param #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) Z_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadZ),
        .parIn(z_in),
        .parOut(z_out)
    );

    wire mode_val;
    register_param #(.BIT_LENGTH(1)) M_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadMode),
        .parIn(mode),
        .parOut(mode_val)
    );

    wire [$clog2(FLOAT_SIZE) : 0] iter;
    upCounterRE #(.BIT_LENGTH($clog2(FLOAT_SIZE) + 1)) Iter_Count(
        .clk(clk),
        .rst(rst),
        .init_cnt(init_cnt),
        .en_cnt(en_cnt),
        .count(iter)
    );
    assign co = (iter == (FLOAT_SIZE)) ? 1'b1 : 1'b0;

    wire signed [INT_SIZE + FLOAT_SIZE - 1:0] x_shift, one, one_shift;

    assign x_shift = x >>> iter;
    assign one = { {(INT_SIZE-1){1'b0}}, 1'b1, {(FLOAT_SIZE){1'b0}} }; 
    assign one_shift = one >>> iter;



    adder #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) Y_Adder(
        .in1(y_out),
        .in2(x_shift),
        .mode(adder_mode),
        .out(out_adder_y)
    );

    adder #(.BIT_LENGTH(INT_SIZE + FLOAT_SIZE)) Z_Adder(
        .in1(z_out),
        .in2(one_shift),
        .mode(~adder_mode),
        .out(out_adder_z)
    );

    wire phi_rotate, phi_vector; 
    assign phi_rotate = (z_out[INT_SIZE + FLOAT_SIZE - 1] == 1) ? 1'b0 : 1'b1;
    assign phi_vector = (y_out[INT_SIZE + FLOAT_SIZE - 1] == 1) ? 1'b1 : 1'b0;
    assign phi = (mode_val == 1) ? phi_vector : phi_rotate;







    
endmodule
