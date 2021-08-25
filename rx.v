module rx(clk2, transmission, ledData, display);
    input clk2, transmission; // transmission => first 4 are instruction bits, last 4 are the data
    output reg [7:0]ledData;
    output reg [4:0]display;
    
    reg [3:0]dataRecorder; // Registrador de Data
    reg [3:0]instructionRecorder; // Registrador de Instruction
    reg [3:0]bitIndex = 7; // Index do bit para saber quando para de pegar instrução e data
    reg [3:0]state = 6;
    reg gotStartBit = 0;
    parameter clean = 1, loadData = 2, showData = 4, startBit = 3, getInstruction = 6;

    always @(posedge clk2) begin
        case(state)
            startBit: begin
                if(~transmission) begin
                    state <= loadData;
                end
            end

            loadData: begin
                if(bitIndex < 4) begin // 7 6 5 4
                    state <= getInstruction;
                end
                else begin
                    dataRecorder[bitIndex - 4] <= transmission; // Instruction is after data
                    ledData[bitIndex] = transmission;
                    bitIndex <= bitIndex - 1;
                end
            end

            getInstruction: begin // 3 2 1 0
                if(bitIndex < 0) begin
                    if(instructionRecorder == 1) begin
                        state <= clean;
                    end
                    else begin 
                            if(instructionRecorder == 4) begin
                            state <= showData;
                        end
                    end
                    bitIndex <= 7; // resetar para pegar o próximo transmission
                end
                else begin
                    instructionRecorder[bitIndex] <= transmission; // Instruction is after data
                    ledData[bitIndex] = transmission;
                    bitIndex <= bitIndex - 1;
                end
            end

            showData: begin
                state <= startBit;
            end

            clean: begin
                state <= startBit;
            end
        endcase
    end

    always @(*) begin
        case(state)
            showData: begin
                display <= dataRecorder;
            end

            clean: begin
                display <= 16; // Any value not allowed by the data amount
            end
        endcase
        
    end

    // grab instruction (execute)
    // grab data
    // standby

endmodule
