library verilog;
use verilog.vl_types.all;
entity reciprocal_float_CU is
    generic(
        IDLE            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        INIT            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        EXP             : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        CALC            : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        ZERO            : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        done_cordic     : in     vl_logic;
        zero_input      : in     vl_logic;
        loadE           : out    vl_logic;
        loadM           : out    vl_logic;
        loadS           : out    vl_logic;
        selE            : out    vl_logic;
        start_cordic    : out    vl_logic;
        done            : out    vl_logic;
        zero_flag       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of INIT : constant is 2;
    attribute mti_svvh_generic_type of EXP : constant is 2;
    attribute mti_svvh_generic_type of CALC : constant is 2;
    attribute mti_svvh_generic_type of ZERO : constant is 2;
end reciprocal_float_CU;
