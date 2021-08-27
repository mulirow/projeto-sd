module rx(clk2, transmission, ledData, display);
    input clk2, transmission; // transmission => first 4 are instruction bits, last 4 are the data
    output [0:7]ledData;
    output [0:4]display;
    
    reg [0:7]led_date_placeholder;
    reg [0:4]display_placeholder;
    reg [0:3]dataRecorder; // Registrador de Data
    reg [0:3]dataRegistry;
    reg [0:3]instructionRecorder; // Registrador de Instruction
    reg [0:3]bitIndex = 7; // Index do bit para saber quando para de pegar instrução e data
    reg [0:3]state = 5;
    parameter clean = 1, loadData = 3, storeData = 2, showData = 4, startBit = 5, getInstruction = 6;

    assign ledData = led_date_placeholder;
    assign display = display_placeholder;

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
                    if(bitIndex == 4) begin
                        state <= getInstruction;
                    end
                    dataRecorder[bitIndex - 4] <= transmission; // Instruction is after data
                    led_date_placeholder[bitIndex] <= transmission;
                    bitIndex <= bitIndex - 1;
                end
            end

            getInstruction: begin // 3 2 1 0
                if(bitIndex == 8) begin
                    if(instructionRecorder == 1) begin
                        state <= clean;
                    end
                    else begin 
                        if(instructionRecorder == 4) begin
                            state <= showData;
                        end
                        else begin
                            if(instructionRecorder == 2) begin
                                state <= storeData;
                            end
                            else begin
                            state <= startBit;
                            end
                        end
                    end
                    bitIndex <= 7; // resetar para pegar o próximo transmission
                end
                else begin
                    instructionRecorder[bitIndex] <= transmission; // Instruction is after data
                    led_date_placeholder[bitIndex] <= transmission;
                    
                    if(bitIndex > 0) begin
                        bitIndex <= bitIndex - 1;
                    end
                    else begin 
                        bitIndex <= 8;
                    end
                end
            end

            showData: begin
                display_placeholder <= dataRegistry;
                state <= startBit;
            end

            storeData: begin
                dataRegistry <= dataRecorder;
                state <= startBit;
            end

            clean: begin
                display_placeholder <= 16;
                state <= startBit;
            end
        endcase
    end
endmodule
