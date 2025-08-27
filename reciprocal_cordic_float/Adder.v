module adder #(
    parameter BIT_LENGTH = 32
) (
    input signed [BIT_LENGTH - 1 : 0] in1, in2,
    input mode, // add = 1  & sub = 0
    output signed [BIT_LENGTH - 1 : 0] out
);

    assign out = (mode == 1) ? (in1 + in2) : (in1 - in2);
    
endmodule
