library verilog;
use verilog.vl_types.all;
entity cordic_linear_CU is
    generic(
        IDLE            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        INIT            : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        CALC            : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        \DONE\          : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        co              : in     vl_logic;
        phi             : in     vl_logic;
        loadX           : out    vl_logic;
        loadY           : out    vl_logic;
        loadZ           : out    vl_logic;
        loadMode        : out    vl_logic;
        sel_input       : out    vl_logic;
        adder_mode      : out    vl_logic;
        init_cnt        : out    vl_logic;
        en_cnt          : out    vl_logic;
        done            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of INIT : constant is 2;
    attribute mti_svvh_generic_type of CALC : constant is 2;
    attribute mti_svvh_generic_type of \DONE\ : constant is 2;
end cordic_linear_CU;
