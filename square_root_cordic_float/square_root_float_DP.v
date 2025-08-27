module square_root_cordic_DP #(
    parameter NUM_ITER = 16
) (
    input clk, rst,
    input [31:0] u,

    input loadS, loadE, loadM,
    input loadE_out,
    input [1:0] src_x,
    input src_y,
    input loadX, loadY,
    input init_cnt, en_cnt,

    output [31:0] out,
    output co, repeat_iter, neg, zero_flag, one_flag
);

    wire [7:0] E_val, E_in;
    wire [8:0] shift_E;
    wire [8:0] out_sub_E;

    assign E_in = u[30:23];
    register_param #(.BIT_LENGTH(8)) E_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadE),
        .parIn(E_in),
        .parOut(E_val)
    );

    wire [7:0] E_out;
    register_param #(.BIT_LENGTH(8)) E_out_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadE_out),
        .parIn(shift_E[7:0]),
        .parOut(E_out)
    );

    assign out_sub_E = $unsigned(9'd127) + $unsigned(E_val);
    assign shift_E = out_sub_E >> 1;
    // assign E_reg_in = (selE == 1) ? shift_E[7:0] : E_in;

    wire [22:0] M_val, M_in;
    assign M_in = u[22:0];
    register_param #(.BIT_LENGTH(23)) M_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadM),
        .parIn(M_in),
        .parOut(M_val)
    );

    wire S_val, S_in;
    assign S_in = u[31];
    register_param #(.BIT_LENGTH(1)) S_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadS),
        .parIn(S_in),
        .parOut(S_val)
    );
    assign neg = (S_val == 1'b1) ? 1'b1 : 1'b0;

    // INT size = 4, FLOAT size = 23
    wire signed [26:0] x_y_in, x_0, y_0;
    assign x_y_in = (E_val[0] == 1) ? {4'b0001, M_val} : {3'b001, M_val, 1'b0};
    assign x_0 = x_y_in + {5'b0, 1'b1, 21'b0}; // u + 0.25
    assign y_0 = x_y_in - {5'b0, 1'b1, 21'b0}; // u - 0.25

    assign one_flag = (x_y_in == {4'b0001, 23'b0}) ? 1'b1 : 1'b0;

    wire signed [26:0] x_in, y_in, x_val, y_val;

    register_param #(.BIT_LENGTH(27)) X_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadX),
        .parIn(x_in),
        .parOut(x_val)
    );

    register_param #(.BIT_LENGTH(27)) Y_Reg(
        .clk(clk),
        .rst(rst),
        .load(loadY),
        .parIn(y_in),
        .parOut(y_val)
    );

    wire phi_vector; 
    assign phi_vector = (y_val[26] == 1) ? 1'b1 : 1'b0;


    wire signed [26:0] x_shift, y_shift, out_adder_x, out_adder_y;
    
    adder #(.BIT_LENGTH(27)) X_Adder(
        .in1(x_val),
        .in2(y_shift),
        .mode(phi_vector),
        .out(out_adder_x)
    );

    adder #(.BIT_LENGTH(27)) Y_Adder(
        .in1(y_val),
        .in2(x_shift),
        .mode(phi_vector),
        .out(out_adder_y)
    );

    reg [$clog2(NUM_ITER) : 0] iter;
    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            iter <= 0;
        else begin
            if (init_cnt == 1)
                iter <= 1;
            else if (en_cnt == 1)
                iter <= iter + 1;
        end
    end
    assign co = (iter == NUM_ITER) ? 1'b1 : 1'b0;

    assign repeat_iter = (iter == 4 || iter == 13) ? 1'b1 : 1'b0;

    assign x_shift = x_val >>> iter;
    assign y_shift = y_val >>> iter;


    wire signed [26:0] x_scaled;
    wire signed [53:0] product;

    //0001 0011 0101 0001 1110 1000 0111 0010            0
    assign product = x_val * {27'b0001_0011_0101_0001_1110_1000_100};
    assign x_scaled = product[49:23];

    assign x_in = (src_x == 2'b00) ? x_0 :
                  (src_x == 2'b01) ? out_adder_x :
                  (src_x == 2'b10) ? x_scaled :
                  27'b0;
    assign y_in = (src_y == 1'b0) ? y_0 : out_adder_y;

    assign zero_flag = ({S_val, E_val, M_val} == 0) ? 1 : 0;

    assign out[31] = S_val;
    assign out[30:23] = (zero_flag == 1) ? E_val : E_out;
    assign out[22:0] = (zero_flag == 1 || one_flag == 1) ? M_val : x_val[22:0];

    
endmodule
