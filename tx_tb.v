module tx_tb();
    reg clk1, btn;
    reg [7:0]data;
    wire out;

    initial begin
        $dumpfile("tx.vcd");
        $dumpvars(0, tx_tb);
        $display("time   clock     button       data     out");
        $monitor(" %g\t %b\t    %b\t    %b    %b", $time, clk1, btn, data, out);
        clk1 = 1;
        btn = 1;
        data = 0;
        #1 data = 8;
        #2 btn = 0;
        #2 btn = 1;
        // #25 btn = 0;
        // #2 btn = 1;
        #45 $finish;
    end

    always begin
        #1 clk1 = ~clk1;
    end

    tx UUT(clk1, btn, data, out);
endmodule