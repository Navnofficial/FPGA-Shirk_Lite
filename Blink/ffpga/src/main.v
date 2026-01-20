(* top *) 
module blink (
  (* iopad_external_pin, clkbuf_inhibit *) input  clk,
  (* iopad_external_pin *) output [4:0] LED,
  (* iopad_external_pin *) output [4:0] LED_en,
  (* iopad_external_pin *) output clk_en
);

  reg [31:0] counter = 32'd0;
  reg [2:0]  led_ptr = 3'd0;
  reg [4:0]  LED_reg;

  localparam integer BLINK_CNT = 32'd5_000_000; 

  assign LED_en = 5'b11111;
  assign clk_en = 1'b1;
  assign LED    = LED_reg;

  always @(posedge clk) begin
    if (counter == BLINK_CNT) begin
      counter <= 32'd0;

      if (led_ptr == 3'd4)
        led_ptr <= 3'd0;
      else
        led_ptr <= led_ptr + 1'b1;

    end else begin
      counter <= counter + 1'b1;
    end
  end

  // FIFO one-hot LEDs
  always @(*) begin
    LED_reg = 5'b00000;
    LED_reg[led_ptr] = 1'b1;
  end

endmodule
