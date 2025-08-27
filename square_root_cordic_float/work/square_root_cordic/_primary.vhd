library verilog;
use verilog.vl_types.all;
entity square_root_cordic is
    generic(
        NUM_ITER        : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        u               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic;
        neg_flag        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_ITER : constant is 1;
end square_root_cordic;
