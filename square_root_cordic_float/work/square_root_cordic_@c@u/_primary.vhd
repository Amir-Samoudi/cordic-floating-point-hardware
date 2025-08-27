library verilog;
use verilog.vl_types.all;
entity square_root_cordic_CU is
    generic(
        IDLE            : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0);
        INIT            : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        EXP             : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        \NEG\           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        CALC            : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi0);
        REPEAT          : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi1);
        SCALE           : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi0);
        \DONE\          : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        co              : in     vl_logic;
        repeat_iter     : in     vl_logic;
        neg             : in     vl_logic;
        loadS           : out    vl_logic;
        loadE           : out    vl_logic;
        loadM           : out    vl_logic;
        selE            : out    vl_logic;
        src_x           : out    vl_logic_vector(1 downto 0);
        src_y           : out    vl_logic;
        loadX           : out    vl_logic;
        loadY           : out    vl_logic;
        init_cnt        : out    vl_logic;
        en_cnt          : out    vl_logic;
        done            : out    vl_logic;
        neg_flag        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of INIT : constant is 2;
    attribute mti_svvh_generic_type of EXP : constant is 2;
    attribute mti_svvh_generic_type of \NEG\ : constant is 2;
    attribute mti_svvh_generic_type of CALC : constant is 2;
    attribute mti_svvh_generic_type of REPEAT : constant is 2;
    attribute mti_svvh_generic_type of SCALE : constant is 2;
    attribute mti_svvh_generic_type of \DONE\ : constant is 2;
end square_root_cordic_CU;
