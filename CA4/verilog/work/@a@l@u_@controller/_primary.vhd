library verilog;
use verilog.vl_types.all;
entity ALU_Controller is
    port(
        funct3          : in     vl_logic_vector(2 downto 0);
        funct7          : in     vl_logic_vector(6 downto 0);
        op              : in     vl_logic_vector(6 downto 0);
        ALUControlD     : out    vl_logic_vector(2 downto 0)
    );
end ALU_Controller;
