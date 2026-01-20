(* top *) module seven_segment_counter (
    (* iopad_external_pin, clkbuf_inhibit *) input clk, // Clock input
    (* iopad_external_pin *) input reset,       
    (* iopad_external_pin *) output clk_en,   // clock enable
    (* iopad_external_pin *) input btn,        // Push button input
    (* iopad_external_pin *) output reg seg_0, // Segment A
    (* iopad_external_pin *) output reg seg_1, // Segment B
    (* iopad_external_pin *) output reg seg_2, // Segment C
    (* iopad_external_pin *) output reg seg_3, // Segment D
    (* iopad_external_pin *) output reg seg_4, // Segment E
    (* iopad_external_pin *) output reg seg_5, // Segment F
    (* iopad_external_pin *) output reg seg_6, // Segment G
    (* iopad_external_pin *) output seg_0_en,  // Enable for seg_0
    (* iopad_external_pin *) output seg_1_en,  // Enable for seg_1
    (* iopad_external_pin *) output seg_2_en,  // Enable for seg_2
    (* iopad_external_pin *) output seg_3_en,  // Enable for seg_3
    (* iopad_external_pin *) output seg_4_en,  // Enable for seg_4
    (* iopad_external_pin *) output seg_5_en,  // Enable for seg_5
    (* iopad_external_pin *) output seg_6_en   // Enable for seg_6
);

    // Internal signals
    reg [3:0] count;          // Counter (0-9)
    reg btn_prev;             // Previous button state
    reg btn_stable;           // Debounced button state
    reg [19:0] debounce_cnt;  // Debounce counter
    reg [6:0] seg;            // Internal segment register
    
    // Button debouncing (assuming 50MHz clock, ~20ms debounce)
    parameter DEBOUNCE_TIME = 20'd1000000;
    
    // Enable signals - always active for all segments
    assign seg_0_en = 1'b1;
    assign seg_1_en = 1'b1;
    assign seg_2_en = 1'b1;
    assign seg_3_en = 1'b1;
    assign seg_4_en = 1'b1;
    assign seg_5_en = 1'b1;
    assign seg_6_en = 1'b1;
    assign clk_en   = 1'b1 ;
    
    // Assign individual segments from internal register
    always @(*) begin
        seg_0 = seg[0];  // Segment A
        seg_1 = seg[1];  // Segment B
        seg_2 = seg[2];  // Segment C
        seg_3 = seg[3];  // Segment D
        seg_4 = seg[4];  // Segment E
        seg_5 = seg[5];  // Segment F
        seg_6 = seg[6];  // Segment G
    end
    
    // Button debouncing
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_prev <= 1'b0;
            btn_stable <= 1'b0;
            debounce_cnt <= 20'd0;
        end else begin
            if (btn != btn_prev) begin
                btn_prev <= btn;
                debounce_cnt <= 20'd0;
            end else if (debounce_cnt < DEBOUNCE_TIME) begin
                debounce_cnt <= debounce_cnt + 1;
            end else begin
                btn_stable <= btn_prev;
            end
        end
    end
    
    // Edge detection for button press
    reg btn_stable_prev;
    wire btn_press;
    
    assign btn_press = btn_stable && !btn_stable_prev;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_stable_prev <= 1'b0;
        end else begin
            btn_stable_prev <= btn_stable;
        end
    end
    
    // Counter logic (0-9)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'd0;
        end else if (btn_press) begin
            if (count == 4'd9)
                count <= 4'd0;  // Wrap around to 0
            else
                count <= count + 1;
        end
    end
    
    // 7-segment decoder (common cathode)
    // Segment order: {g, f, e, d, c, b, a}
    // 1 = LED ON, 0 = LED OFF for common cathode
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seg <= 7'b0111111;  // Display 0
        end else begin
            case (count)
                4'd0: seg <= 7'b0111111;  // 0
                4'd1: seg <= 7'b0000110;  // 1
                4'd2: seg <= 7'b1011011;  // 2
                4'd3: seg <= 7'b1001111;  // 3
                4'd4: seg <= 7'b1100110;  // 4
                4'd5: seg <= 7'b1101101;  // 5
                4'd6: seg <= 7'b1111101;  // 6
                4'd7: seg <= 7'b0000111;  // 7
                4'd8: seg <= 7'b1111111;  // 8
                4'd9: seg <= 7'b1101111;  // 9
                default: seg <= 7'b0000000;  // Blank
            endcase
        end
    end

endmodule