`timescale 1us/10ns

module uart_tb();
    reg clk, btn;
    reg [7:0]data;
    wire [4:0]display;
    wire [7:0]ledData;
    wire transmission;
    wire [6:0]disp1;
    wire [6:0]disp0;

    parameter clockPeriod = 1; // 1 MHz base clock
    parameter clocksPerBit = 104; //How many pulses are needed so transmission is 9600 baud

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_tb);
        clk = 1;
        btn = 1;
        data = 0;
        
        #(clockPeriod * clocksPerBit) data = 20;

        #(clockPeriod * clocksPerBit) btn = 0;

        #(clockPeriod * clocksPerBit) btn = 1;

        #(clockPeriod * clocksPerBit * 100) data = 44;

        #(clockPeriod * clocksPerBit) btn = 0;

        #(clockPeriod * clocksPerBit) btn = 1;

        #(clockPeriod * clocksPerBit * 100) data = 66;

        #(clockPeriod * clocksPerBit) btn = 0;

        #(clockPeriod * clocksPerBit) btn = 1;

        #(clockPeriod * clocksPerBit * 50) data = 20;

        #(clockPeriod * clocksPerBit) btn = 0;

        #(clockPeriod * clocksPerBit) btn = 1;

        #(clockPeriod * clocksPerBit * 100) $finish;
    end

    always begin
        #(clockPeriod * clocksPerBit/2) clk = ~clk;
    end

    tx tx_UUT(clk, btn, data, transmission);
    rx rx_UUT(clk, transmission, ledData, display);
    display display_UUT(display, disp1, disp0);
endmodule