library verilog;
use verilog.vl_types.all;
entity square_root_cordic_DP is
    generic(
        NUM_ITER        : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        u               : in     vl_logic_vector(31 downto 0);
        loadS           : in     vl_logic;
        loadE           : in     vl_logic;
        loadM           : in     vl_logic;
        selE            : in     vl_logic;
        src_x           : in     vl_logic_vector(1 downto 0);
        src_y           : in     vl_logic;
        loadX           : in     vl_logic;
        loadY           : in     vl_logic;
        init_cnt        : in     vl_logic;
        en_cnt          : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0);
        co              : out    vl_logic;
        repeat_iter     : out    vl_logic;
        neg             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_ITER : constant is 1;
end square_root_cordic_DP;
