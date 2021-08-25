module rx(clk1, transmition, ledData, display);
    input clk1, [4:0]transmition; // Transmition => first 4 are instruction bits, last 4 are the data
    output [7:0]ledData, display;
    
    reg [3:0]recorder; // Registrador

    // 9600 bits/s => 1/9600s = 1bit

    always @(posedge clk1) begin
        
    end

endmodule
