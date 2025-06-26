module ALU (
    input  logic [7:0]  X,        
    input  logic [7:0]  Y,        
    input  logic [1:0]  ALU_Sel,  
    output logic [7:0]  Result    
);

    always_comb begin
        case (ALU_Sel)
            2'b00: Result = X + Y;  
            2'b01: Result = X - Y;  
            2'b10: Result = X & Y;  
            2'b11: Result = ~{X};     
            default: Result = 7'b0; 
        endcase
    end

endmodule