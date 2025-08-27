module upCounterRE #(
    parameter BIT_LENGTH = 16
) (
    input clk, rst,
    input init_cnt, en_cnt,
    output reg [BIT_LENGTH - 1 : 0] count
);

    always @(posedge clk, posedge rst) begin
        if (rst == 1)
            count <= 0;
        else begin
            if (init_cnt == 1)
                count <= 0;
            else if (en_cnt == 1)
                count <= count + 1;
        end
    end
    
endmodule
