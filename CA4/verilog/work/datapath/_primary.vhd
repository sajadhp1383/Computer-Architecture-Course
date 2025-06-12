library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        StallF          : in     vl_logic;
        StallD          : in     vl_logic;
        ForwardAE       : in     vl_logic;
        ForwardBE       : in     vl_logic;
        FlushD          : in     vl_logic;
        BranchD         : in     vl_logic_vector(1 downto 0);
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
        Rs2             : out    vl_logic_vector(4 downto 0);
        zero            : out    vl_logic;
        funct3          : out    vl_logic_vector(2 downto 0);
        funct7          : out    vl_logic_vector(6 downto 0);
        op              : out    vl_logic_vector(6 downto 0);
        Rs1E            : out    vl_logic_vector(4 downto 0);
        Rs2E            : out    vl_logic_vector(4 downto 0);
        PCSrcE          : out    vl_logic;
        RegWriteW       : out    vl_logic;
        sel_adderD      : in     vl_logic;
        RdE             : out    vl_logic_vector(4 downto 0);
        Rdm             : out    vl_logic_vector(4 downto 0);
        BranchE         : out    vl_logic_vector(1 downto 0);
        RegWriteM       : in     vl_logic;
        ResultSrcE      : out    vl_logic_vector(1 downto 0)
    );
end datapath;
