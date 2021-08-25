module tx(clk1, btn, data, out);
    input clk1;
    input btn;
    input [7:0]data;
    output out;

    reg [2:0]state;
    reg [3:0]bitIndex;
    reg [7:0]dataStore;
    reg o = 1;

    parameter standby = 0, waitRelease = 1, startBit = 2, processBits = 3, endBit = 4;

    assign out = o; // Initialize out as 1

    always @ (posedge clk1) begin
        case(state)
            // Waiting for input state
            standby: begin
                o <= 1;    // Output is high while idle
                if(~btn) state <= waitRelease;
            end

            // Waiting for button release
            waitRelease: begin
                if(btn) begin
                    dataStore <= data;
                    state <= startBit;
                end
            end

            // Start bit to start getting the data bits
            startBit: begin
                bitIndex <= 0; // Reset index count for processing
                o <= 0;
                state <= processBits;
            end

            // Get bit by bit looping through the indexes
            processBits: begin
                if(bitIndex < 7) begin
                    o <= data[bitIndex];
                    bitIndex <= bitIndex + 1;
                end
                else begin
                    o <= data[bitIndex];
                    state <= endBit;
                end
            end

            // Go back to standby after finishing getting the data bits
            endBit: begin
                o <= 1;
                state <= standby;
            end

            default: begin
                state <= standby;
            end
        endcase
    end
endmodule