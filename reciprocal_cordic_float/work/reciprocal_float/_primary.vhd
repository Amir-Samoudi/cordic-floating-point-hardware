library verilog;
use verilog.vl_types.all;
entity reciprocal_float is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        x               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic;
        zero_flag       : out    vl_logic
    );
end reciprocal_float;
