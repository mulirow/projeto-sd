`timescale 1us/10ns

module uart_tb();
    reg clk1, clk2, btn;
    reg [7:0]data;
    wire [4:0]display;
    wire [7:0]ledData;
    wire transmission;
    wire [6:0]disp1;
    wire [6:0]disp0;

    parameter clockPeriod = 1; // 1 MHz base clock
    parameter clocksPerBit = 53; //How many pulses are needed so transmission is 9600 baud

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_tb);
        clk1 = 1;
        clk2 = 1;
        btn = 1;
        data = 0;
        
        #(clockPeriod * clocksPerBit) data = 20;

        #(clockPeriod * clocksPerBit) btn = 0;

        #(clockPeriod * clocksPerBit) btn = 1;

        #(clockPeriod * clocksPerBit * 100) $finish;
    end

    always begin
        #(clockPeriod * clocksPerBit/2) clk1 = ~clk1;
    end

    always begin
        #(clockPeriod * clocksPerBit/2) clk2 = ~clk2;
    end

    tx tx_UUT(clk1, btn, data, transmission);
    rx rx_UUT(clk2, transmission, ledData, display);
    display display_UUT(display, disp1, disp0);
endmodule