library verilog;
use verilog.vl_types.all;
entity reciprocal_CU is
    generic(
        IDLE            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        INIT            : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        \START\         : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        \WAIT\          : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        done_cordic     : in     vl_logic;
        loadX           : out    vl_logic;
        start_cordic    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of INIT : constant is 2;
    attribute mti_svvh_generic_type of \START\ : constant is 2;
    attribute mti_svvh_generic_type of \WAIT\ : constant is 2;
end reciprocal_CU;
