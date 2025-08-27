library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        BIT_LENGTH      : integer := 32
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        mode            : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_LENGTH : constant is 1;
end adder;
