module tx(clk1, btn, data, out);
    input clk1, btn;
    input [7:0]data;
    output reg out;

    reg [1:0]state;
    reg [3:0]clockCount;
    reg [3:0]bitIndex;
    reg [7:0]dataStore;

    parameter standby = 0, startBit = 1, processBits = 2, endBit = 3;

    always @ (*) begin
        case(state)
            // Waiting for input state
            standby: begin
                dataStore <= data;
                clockCount <= 0;

                if(~btn) state <= startBit;
            end

            //  Start bit to start getting the data bits
            startBit: begin
                if(clockCount < 1) begin
                    clockCount <= clockCount + 1;
                end
                else begin
                    clockCount <= 0; // To start receiving Bits
                    bitIndex <= 7;
                    state <= processBits;
                end
            end

            // Get bit by bit looping through the indexes
            processBits: begin
                if(bitIndex >= 0) begin
                    out <= data[bitIndex];
                    bitIndex <= bitIndex - 1;
                end
                else state <= endBit;
            end

            // Go back to standby after finishing getting the data bits
            endBit: begin
                if(clockCount < 1) begin
                    clockCount <= clockCount + 1;
                end
                else begin
                    clockCount <= 0;
                    state <= standby;
                end
            end
        endcase
    end
endmodule