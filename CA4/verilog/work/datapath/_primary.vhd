library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        StallF          : in     vl_logic;
        StallD          : in     vl_logic;
        RegWriteW       : in     vl_logic;
        FlushD          : in     vl_logic;
        BranchD         : in     vl_logic;
        RegWriteD       : in     vl_logic;
        MemWriteD       : in     vl_logic;
        JumpD           : in     vl_logic;
        ALUSrcD         : in     vl_logic;
        ALUControlD     : in     vl_logic_vector(2 downto 0);
        ImmSrcD         : in     vl_logic_vector(1 downto 0);
        ResultSrcD      : in     vl_logic_vector(1 downto 0);
        LuiD            : in     vl_logic;
        FlushE          : in     vl_logic;
        Rs1             : out    vl_logic_vector(4 downto 0);
        Rs2             : out    vl_logic_vector(4 downto 0)
    );
end datapath;
