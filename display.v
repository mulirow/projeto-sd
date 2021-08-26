module display (data, disp1, disp0, enable);
    
    input [3:0] data;
    input enable;
    output reg [6:0] disp1;
    output reg [6:0] disp0;

    assign zero = 7'b0000001;  // "0"
    assign one = 7'b1001111;  // "1"
    assign two = 7'b0010010; // "2"
    assign three = 7'b0000110;  // "3"
    assign four = 7'b1001100;  // "4"
    assign five = 7'b0100100; // "5"
    assign six = 7'b0100000; // "6"
    assign seven = 7'b0001111; // "7"
    assign eight= 7'b0000000; // "8"
    assign nine= 7'b0000100; // "9"
    assign clr = 7'b1111111; // Clean display

    always @ (*)
        begin
            if(enable == 1'b0) begin
                 case(data)
                    4'b0000: begin
                        disp1 = clr;
                        disp0 = zero;
                    end
                    4'b0001: begin
                        disp1 = clr;
                        disp0 = one;
                    end
                    4'b0010: begin
                        disp1 = clr;
                        disp0 = two;
                    end
                    4'b0011: begin
                        disp1 = clr;
                        disp0 = three;
                    end
                    4'b0100: begin
                        disp1 = clr;
                        disp0 = four;
                    end
                    4'b0101: begin
                        disp1 = clr;
                        disp0 = five;
                    end
                    4'b0110: begin
                        disp1 = clr;
                        disp0 = six;
                    end
                    4'b0111: begin
                        disp1 = clr;
                        disp0 = seven;
                    end
                    4'b1000: begin
                        disp1 = clr;
                        disp0 = eight;
                    end
                    4'b1001: begin
                        disp1 = clr;
                        disp0 = nine;
                    end
                    4'b1010: begin
                        disp1 = one;
                        disp0 = zero;
                    end
                    4'b1011: begin
                        disp1 = one;
                        disp0 = one;
                    end
                    4'b1100: begin
                        disp1 = one;
                        disp0 = two;
                    end
                    4'b1101: begin
                        disp1 = one;
                        disp0 = three;
                    end
                    4'b1110: begin
                        disp1 = one;
                        disp0 = four;
                    end
                    4'b1111: begin
                        disp1 = one;
                        disp0 = five;
                    end
                endcase
            end else begin
                disp1 = clr;
                disp0 = clr;
            end
        end

endmodule