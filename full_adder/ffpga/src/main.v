(* top *)
module full_adder(
    (* iopad_external_pin *) input  a,
    (* iopad_external_pin *) input  b,
    (* iopad_external_pin *) input  c,
    (* iopad_external_pin *) output sum,
    (* iopad_external_pin *) output sum_en,
    (* iopad_external_pin *) output carry,
    (* iopad_external_pin *) output carry_en
);

assign sum_en   = 1'b1;
assign carry_en = 1'b1;

assign sum   = a ^ b ^ c;
assign carry = (a & b) | (b & c) | (c & a);

endmodule
