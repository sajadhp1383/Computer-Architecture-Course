module InstructionMemory(pc, instruction);
  input [31:0] pc;
  output reg [31:0] instruction;

  reg [7:0] instructionMemory [0:2000];


  wire [31:0] adr;
  assign adr = {pc[31:2], 2'b00};

  initial begin
    $readmemh("instructions.mem", instructionMemory);
  end


  always @(pc) begin
    instruction = {instructionMemory[adr], instructionMemory[adr + 1], 
                   instructionMemory[adr + 2], instructionMemory[adr + 3]};
end

endmodule

// module InstructionMemory(
//     input [31:0] PC,
//     output [31:0] instr
// );
// reg [7:0] instrMemory [0:65536];
//     wire [31:0] address;

//     initial begin
//         $readmemh("InstructionMemory.mem", instrMemory); 
//     end

//     assign address = {PC[31:2], 2'b00}; 
//     assign instr = {instrMemory[address], 
//                     instrMemory[address + 1], 
//                     instrMemory[address + 2], 
//                     instrMemory[address + 3]};
// endmodule