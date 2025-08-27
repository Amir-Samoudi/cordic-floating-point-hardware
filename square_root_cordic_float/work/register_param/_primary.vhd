library verilog;
use verilog.vl_types.all;
entity register_param is
    generic(
        BIT_LENGTH      : integer := 2048
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load            : in     vl_logic;
        parIn           : in     vl_logic_vector;
        parOut          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIT_LENGTH : constant is 1;
end register_param;
