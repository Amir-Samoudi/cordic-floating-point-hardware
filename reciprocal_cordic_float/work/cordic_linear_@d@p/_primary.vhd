library verilog;
use verilog.vl_types.all;
entity cordic_linear_DP is
    generic(
        FLOAT_SIZE      : integer := 24;
        INT_SIZE        : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        x               : in     vl_logic_vector;
        y               : in     vl_logic_vector;
        z               : in     vl_logic_vector;
        mode            : in     vl_logic;
        loadX           : in     vl_logic;
        loadY           : in     vl_logic;
        loadZ           : in     vl_logic;
        loadMode        : in     vl_logic;
        sel_input       : in     vl_logic;
        adder_mode      : in     vl_logic;
        init_cnt        : in     vl_logic;
        en_cnt          : in     vl_logic;
        x_out           : out    vl_logic_vector;
        y_out           : out    vl_logic_vector;
        z_out           : out    vl_logic_vector;
        co              : out    vl_logic;
        phi             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FLOAT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of INT_SIZE : constant is 1;
end cordic_linear_DP;
