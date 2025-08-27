module reciprocal_float_CU (
    input clk, rst,
    input start,

    input done_cordic, zero_input,

    output reg loadE, loadM, loadS,
    output reg selE, start_cordic,
    output reg done, zero_flag
);

    parameter [2:0] IDLE = 0, INIT = 1, EXP = 2, CALC = 3, ZERO = 4;
    reg [2:0] ps, ns;

    always @(ps, start, zero_input, done_cordic) begin
        case (ps)
            IDLE: ns = (start == 1) ? INIT : IDLE;
            INIT: ns = (start == 1) ? INIT : EXP;
            EXP: ns = (zero_input == 1) ? ZERO : CALC;
            CALC: ns = (done_cordic == 1) ? IDLE : CALC;
            ZERO: ns = IDLE; 
            default: ns = IDLE;
        endcase
    end

    always @(ps, done_cordic) begin
        loadE = 0;
        loadM = 0;
        loadS = 0;
        selE = 0;
        start_cordic = 0;
        done = 0;
        zero_flag = 0;
        case (ps)
            IDLE: ;
            INIT: begin
                selE = 1;
                loadE = 1;
                loadM = 1;
                loadS = 1;
            end 
            EXP: begin
                loadE = 1;
                start_cordic = 1;
            end
            CALC: done = done_cordic;
            ZERO: begin
                done = 1;
                zero_flag = 1;
            end
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
