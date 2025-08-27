module square_root_cordic_CU (
    input clk, rst,
    input start,
    input co, repeat_iter, neg, zero_flag, one_flag,

    output reg loadS, loadE, loadM,
    output reg loadE_out,
    output reg [1:0] src_x,
    output reg src_y,
    output reg loadX, loadY,
    output reg init_cnt, en_cnt,
    output reg done, neg_flag
);
    parameter [3:0] IDLE = 0, INIT = 1, EXP = 2, NEG = 3, CALC = 4, REPEAT = 5, SCALE = 6, DONE = 7, ONE = 8;
    reg [3:0] ps, ns;

    always @(ps, start, neg, repeat_iter, co, zero_flag, one_flag) begin
        case (ps)
            IDLE: ns = (start == 1) ? INIT : IDLE;
            INIT: ns = (start == 1) ? INIT : EXP;

            EXP: ns = (neg == 1) ? NEG :
                      (zero_flag == 1) ? DONE : 
                      (one_flag == 1) ? ONE : CALC;
            // EXP: ns = (zero_flag == 1) ? DONE : 
            //           (one_flag == 1) ? ONE :
            //           ((neg == 1) ? NEG : CALC);
            NEG: ns = IDLE;
            ONE: ns = DONE;
            CALC: ns = (co == 1) ? SCALE :(repeat_iter == 1 ? REPEAT : CALC);
            REPEAT: ns = CALC;
            SCALE: ns = DONE;
            DONE: ns = IDLE; 
            default: ns = IDLE;
        endcase
    end

    always @(ps, repeat_iter) begin
        loadS = 0;
        loadE = 0;
        loadM = 0;
        loadE_out = 0;
        src_x = 0;
        src_y = 0;
        loadX = 0;
        loadY = 0;
        init_cnt = 0;
        en_cnt = 0;
        done = 0;
        neg_flag = 0;

        case (ps)
            IDLE: ;
            INIT: begin
                loadS = 1;
                loadE = 1;
                loadM = 1;
            end
            EXP: begin
                src_x = 2'b00;
                src_y = 0;
                loadX = 1;
                loadY = 1;
                init_cnt = 1;
            end 
            NEG: begin
                done = 1;
                neg_flag = 1;
            end
            CALC: begin
                en_cnt = ~repeat_iter;
                src_x = 2'b01;
                src_y = 1;
                loadX = 1;
                loadY = 1;
            end
            REPEAT: begin
                en_cnt = 1;
                src_x = 2'b01;
                src_y = 1;
                loadX = 1;
                loadY = 1;
            end
            SCALE: begin
                src_x = 2'b10;
                loadX = 1;
                loadE_out = 1;
            end
            ONE: begin
                loadE_out = 1;
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
