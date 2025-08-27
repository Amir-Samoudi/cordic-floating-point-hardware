library verilog;
use verilog.vl_types.all;
entity reciprocal is
    generic(
        FLOAT_SIZE      : integer := 24;
        INT_SIZE        : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        x               : in     vl_logic_vector;
        \out\           : out    vl_logic_vector;
        done            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FLOAT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of INT_SIZE : constant is 1;
end reciprocal;
