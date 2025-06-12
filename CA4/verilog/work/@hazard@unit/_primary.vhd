library verilog;
use verilog.vl_types.all;
entity HazardUnit is
    port(
        RegWriteM       : in     vl_logic;
        RegWriteW       : in     vl_logic;
        ResultSrcE      : in     vl_logic_vector(1 downto 0);
        PCSrcE          : in     vl_logic_vector(1 downto 0);
        ResultSrcM      : in     vl_logic_vector(1 downto 0);
        ResultSrcW      : in     vl_logic_vector(1 downto 0);
        Rs1D            : in     vl_logic_vector(4 downto 0);
        Rs2D            : in     vl_logic_vector(4 downto 0);
        Rs1E            : in     vl_logic_vector(4 downto 0);
        Rs2E            : in     vl_logic_vector(4 downto 0);
        RdE             : in     vl_logic_vector(4 downto 0);
        RdM             : in     vl_logic_vector(4 downto 0);
        RdW             : in     vl_logic_vector(4 downto 0);
        StallF          : out    vl_logic;
        StallD          : out    vl_logic;
        FlushD          : out    vl_logic;
        FlushE          : out    vl_logic;
        ForwardAE       : out    vl_logic_vector(1 downto 0);
        ForwardBE       : out    vl_logic_vector(1 downto 0)
    );
end HazardUnit;
