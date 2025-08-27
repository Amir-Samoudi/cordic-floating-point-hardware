module reciprocal_CU (
    input clk, rst,
    input start,
    input done_cordic,

    output reg loadX, start_cordic
);

    parameter [1:0] IDLE = 0, INIT = 1, START = 2, WAIT = 3;
    reg [1:0] ps, ns;

    always @(ps, start, done_cordic) begin
        case (ps)
            IDLE: ns = (start == 1) ? INIT : IDLE;
            INIT: ns = (start == 1 ) ? INIT : START;
            START: ns = WAIT;
            WAIT: ns = (done_cordic == 1) ? IDLE : WAIT;
            default: ns = IDLE;
        endcase
    end

    always @(ps) begin
        loadX = 0;
        start_cordic = 0;
        case (ps)
            IDLE: ;
            INIT: loadX = 1;
            START: start_cordic = 1;
            WAIT:;
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
