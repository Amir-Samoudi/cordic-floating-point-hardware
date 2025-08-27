library verilog;
use verilog.vl_types.all;
entity reciprocal_float_DP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        x               : in     vl_logic_vector(31 downto 0);
        loadE           : in     vl_logic;
        loadM           : in     vl_logic;
        loadS           : in     vl_logic;
        selE            : in     vl_logic;
        start_cordic    : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0);
        done_cordic     : out    vl_logic;
        zero_flag       : out    vl_logic
    );
end reciprocal_float_DP;
