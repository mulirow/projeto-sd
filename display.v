module display (data, disp1, disp0);
    input [4:0] data;
    output [6:0] disp1;
    output [6:0] disp0;

    reg disp0reg;
    reg disp1reg;
    parameter zero = 7'b0000001;  // "0"
    parameter one = 7'b1001111;  // "1"
    parameter two = 7'b0010010; // "2"
    parameter three = 7'b0000110;  // "3"
    parameter four = 7'b1001100;  // "4"
    parameter five = 7'b0100100; // "5"
    parameter six = 7'b0100000; // "6"
    parameter seven = 7'b0001111; // "7"
    parameter eight= 7'b0000000; // "8"
    parameter nine= 7'b0000100; // "9"
    parameter clr = 7'b1111111; // Clean display

    always @ (*) begin
        case(data)
            5'b00000: begin
                disp1reg <= clr;
                disp0reg <= zero;
            end
            5'b00001: begin
                disp1reg <= clr;
                disp0reg <= one;
            end
            5'b00010: begin
                disp1reg <= clr;
                disp0reg <= two;
            end
            5'b00011: begin
                disp1reg <= clr;
                disp0reg <= three;
            end
            5'b00100: begin
                disp1reg <= clr;
                disp0reg <= four;
            end
            5'b00101: begin
                disp1reg <= clr;
                disp0reg <= five;
            end
            5'b00110: begin
                disp1reg <= clr;
                disp0reg <= six;
            end
            5'b00111: begin
                disp1reg <= clr;
                disp0reg <= seven;
            end
            5'b01000: begin
                disp1reg <= clr;
                disp0reg <= eight;
            end
            5'b01001: begin
                disp1reg <= clr;
                disp0reg <= nine;
            end
            5'b01010: begin
                disp1reg <= one;
                disp0reg <= zero;
            end
            5'b01011: begin
                disp1reg <= one;
                disp0reg <= one;
            end
            5'b01100: begin
                disp1reg <= one;
                disp0reg <= two;
            end
            5'b01101: begin
                disp1reg <= one;
                disp0reg <= three;
            end
            5'b01110: begin
                disp1reg <= one;
                disp0reg <= four;
            end
            5'b01111: begin
                disp1reg <= one;
                disp0reg <= five;
            end
            default: begin
                disp1reg <= clr;
                disp0reg <= clr;
            end
        endcase
    end

    assign disp0 = disp0reg;
    assign disp1 = disp1reg;
endmodule