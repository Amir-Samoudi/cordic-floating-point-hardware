module register_param #(
    parameter BIT_LENGTH = 2048
) (
    input clk, rst,
    input load,
    input [BIT_LENGTH - 1 : 0] parIn,
    output reg [BIT_LENGTH - 1 : 0] parOut
);

    always@(posedge clk, posedge rst) begin
        if (rst == 1)
            parOut <= 0;
        else begin
            if (load == 1)
                parOut <= parIn;
        end
    end

endmodule