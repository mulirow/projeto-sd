module rx_tb();
    reg clk2, transmission;
    wire [4:0]display;
    wire [7:0]ledData;

    initial begin
        $dumpfile("rx.vcd");
        $dumpvars(0, rx_tb);
        $display("time   clock     transmission       display     ledData");
        $monitor(" %g\t %b\t    %b\t    %b    %b", $time, clk2, transmission, display, ledData);
        clk2 = 1;
        transmission = 1;
        display = 16;
        ledData = 0;

        #1 transmission = 0; // StartBit
        #1 transmission = 1;
        #1 transmission = 0;
        #1 transmission = 0;
        #1 transmission = 0;
        #1 transmission = 1;
        #1 transmission = 0;
        #1 transmission = 0;
        #1 transmission = 1;
        #1 transmission = 1; // EndBit
        #45 $finish;
    end

    always begin
        #1 clk2 = ~clk2;
    end

    rx UUT(clk2, transmission, display, ledData);
endmodule