module rx(clk2, transmission, ledData, display);
    input clk2, transmission; // transmission => first 4 are instruction bits, last 4 are the data
    output [7:0]ledData;
    output [4:0]display;
    
    reg [7:0]led_date_placeholder;
    reg [4:0]display_placeholder;
    reg [3:0]dataRecorder; // Registrador de Data
    reg [3:0]dataRegistry;
    reg [3:0]instructionRecorder; // Registrador de Instruction
    reg [3:0]bitIndex; // Index do bit para saber quando para de pegar instrução e data
    reg [3:0]state = 5;
    parameter clean = 1, loadData = 3, storeData = 2, showData = 4, startBit = 5, getInstruction = 6;

    assign ledData = led_date_placeholder;
    assign display = display_placeholder;

    always @(posedge clk2) begin
        case(state)
            startBit: begin
                if(~transmission) begin
                    bitIndex <= 0;
                    state <= loadData;
                end
            end

            loadData: begin
                if(bitIndex == 3) begin
                    state <= getInstruction;
                end
                dataRecorder[bitIndex] <= transmission; // Instruction is after data
                led_date_placeholder[bitIndex] <= transmission;
                bitIndex <= bitIndex + 1;
            end

            getInstruction: begin // 4 5 6 7
                if(bitIndex == 8) begin
                    if(instructionRecorder == 1) state <= clean;
                    else begin 
                        if(instructionRecorder == 2) state <= storeData;
                        else begin
                            if(instructionRecorder == 4) state <= showData;
                            else state <= startBit;
                        end
                    end
                    bitIndex <= 0; // resetar para pegar o próximo transmission
                end
                else begin
                    instructionRecorder[bitIndex-4] <= transmission; // Instruction is after data
                    led_date_placeholder[bitIndex] <= transmission;
                    
                    bitIndex <= bitIndex + 1;
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
