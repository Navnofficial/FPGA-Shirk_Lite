(* top *)
module mux(
    (* iopad_external_pin *) input  sel,
    (* iopad_external_pin *) output y,
    (* iopad_external_pin *) output y_en
);

assign y_en = 1'b1;

wire a = 1'b1;
wire b = 1'b0;

assign y = sel ? a : b;

endmodule
