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

        #10 transmission = 0; // StartBit
        #2 transmission = 0;
        #2 transmission = 1;
        #2 transmission = 0;
        #2 transmission = 0;
        #2 transmission = 0; //0x01
        #2 transmission = 1; //0x02
        #2 transmission = 0; //0x04
        #2 transmission = 0;
        //Final: 0 0 1 0 0 0 1 0
        
        #2 transmission = 1; // EndBit

        #10 transmission = 0; // StartBit
        #2 transmission = 0;
        #2 transmission = 0;
        #2 transmission = 0;
        #2 transmission = 1;
        #2 transmission = 0; //0x01
        #2 transmission = 0; //0x02
        #2 transmission = 1; //0x04
        #2 transmission = 0; 
        //Final: 0 1 0 0 1 0 0 0

        #2 transmission = 1; // EndBit
        #10 $finish;
    end

    always begin
        #1 clk2 = ~clk2;
    end

    rx UUT(clk2, transmission, ledData, display);
endmodule