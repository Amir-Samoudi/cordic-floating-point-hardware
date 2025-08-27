library verilog;
use verilog.vl_types.all;
entity upCounterRE is
    generic(
        BIT_LENGTH      : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        init_cnt        : in     vl_logic;
        en_cnt          : in     vl_logic;
        count           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_LENGTH : constant is 1;
end upCounterRE;
