module cordic_linear_CU (
    input clk, rst,
    input start,
    input co, phi,

    output reg loadX, loadY, loadZ,loadMode,
    output reg sel_input, adder_mode,
    output reg init_cnt, en_cnt,
    output reg done
);

    parameter [1:0] IDLE = 0, INIT = 1, CALC = 2, DONE = 3;
    reg [1:0] ps, ns;

    always @(ps, start, co) begin
        case (ps)
            IDLE: ns = (start == 1) ? INIT : IDLE;
            INIT: ns = (start == 1 ) ? INIT : CALC;
            CALC: ns = (co == 1) ? DONE : CALC;
            DONE: ns = IDLE;
            default: ns = IDLE;
        endcase
    end

    always @(ps, phi) begin
        loadX = 0;
        loadY = 0;
        loadZ = 0;
        loadMode = 0;
        sel_input = 0;
        adder_mode = 0;
        init_cnt = 0;
        en_cnt = 0;
        done = 0;

        case (ps)
            IDLE: ;
            INIT: begin
                init_cnt = 1;
                loadX = 1;
                loadY = 1;
                loadZ = 1;
                loadMode = 1;
                sel_input = 1;
            end
            CALC: begin
                adder_mode = phi;
                en_cnt = 1;
                sel_input = 0;
                loadY = 1;
                loadZ = 1;
            end 
            DONE: done = 1;
            default: ;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst == 1)
            ps <= IDLE;
        else 
            ps <= ns;
    end

endmodule
