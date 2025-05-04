module InstructionMemory(pc, instruction);
  input [31:0] pc;
  output reg [31:0] instruction;

  reg [7:0] instructionMemory [0:65535];


  wire [31:0] adr;
  assign adr = pc >> 2;

  initial begin
    $readmemh("instructions.mem", instructionMemory);
  end

  always @(pc) begin
    instruction = {instructionMemory[adr], instructionMemory[adr + 1], 
                   instructionMemory[adr + 2], instructionMemory[adr + 3]};
end

endmodule