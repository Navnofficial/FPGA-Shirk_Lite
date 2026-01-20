# Mux - 2:1 Multiplexer

A simple 2:1 multiplexer implementation demonstrating fundamental combinational logic on the Vicharak Shrike FPGA board.

## Project Overview

This project implements a 2-to-1 multiplexer, one of the most basic building blocks in digital logic. The multiplexer selects between two input values based on a control signal and outputs the selected value.

## Verilog Code

```verilog
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
```

## How It Works

### Key Components

1. **Selector Input (`sel`)**
   - Control signal that determines which input is passed to the output
   - Binary input: `0` or `1`

2. **Input Signals**
   - `a = 1'b1` (Logic HIGH, constant value 1)
   - `b = 1'b0` (Logic LOW, constant value 0)

3. **Output (`y`)**
   - Selected value based on `sel` signal
   - Enabled by `y_en` (always high)

### Operation

The multiplexer uses a ternary conditional operator (`?:`) which is equivalent to:

```verilog
if (sel == 1)
    y = a;  // Output 1
else
    y = b;  // Output 0
```

**Truth Table**:

| sel | a | b | y (output) |
|-----|---|---|------------|
| 0   | 1 | 0 | **0** (selects b) |
| 1   | 1 | 0 | **1** (selects a) |

### Behavioral Description

```
sel = 0  →  y = b = 0  (Logic LOW)
sel = 1  →  y = a = 1  (Logic HIGH)
```

In this implementation:
- When the selector is **LOW (0)**, the output mirrors input `b` (0)
- When the selector is **HIGH (1)**, the output mirrors input `a` (1)

Effectively, this creates a simple **inverter-like behavior** where the output follows the selector signal.

## Multiplexer Fundamentals

### What is a Multiplexer?

A multiplexer (MUX) is a combinational circuit that:
- Accepts multiple input signals
- Uses control/select signals to choose one input
- Forwards the selected input to a single output line

### General Form

An n-to-1 multiplexer has:
- **n data inputs** (in this case, 2)
- **log₂(n) select lines** (in this case, 1)
- **1 output**

### Boolean Expression

For a 2:1 MUX:
```
y = (sel' · b) + (sel · a)
```

In Verilog, this is simplified using the ternary operator:
```verilog
y = sel ? a : b;
```

## Key Concepts Demonstrated

- **Combinational Logic**: Output depends only on current inputs (no memory/state)
- **Conditional Assignment**: Using the `?:` ternary operator
- **Constant Values**: Hardcoded wire assignments (`a = 1`, `b = 0`)
- **Module Attributes**: FPGA pin mapping with `iopad_external_pin`
- **Continuous Assignment**: Using `assign` for combinational logic

## Learning Outcomes

After studying this project, you will understand:
- How multiplexers select between multiple inputs
- The ternary conditional operator in Verilog
- Combinational logic design principles
- Simple data routing in hardware
- FPGA pin constraints

## Practical Applications

Multiplexers are used extensively in:
- **Data routing**: Selecting between multiple data sources
- **Bus systems**: Sharing communication lines
- **ALUs**: Selecting operations in processors
- **Memory addressing**: Selecting specific memory locations
- **Function implementation**: Any boolean function can be built with MUXes

## Customization Ideas

To expand this basic design:

1. **Variable Inputs**: Replace constants with actual input pins
   ```verilog
   input wire a, b;  // Make a and b external inputs
   ```

2. **4:1 Multiplexer**: Add more inputs and a 2-bit selector
   ```verilog
   input [1:0] sel;
   input a, b, c, d;
   assign y = (sel == 2'b00) ? a :
              (sel == 2'b01) ? b :
              (sel == 2'b10) ? c : d;
   ```

3. **Multi-bit MUX**: Select between multi-bit buses
   ```verilog
   input [7:0] a, b;
   output [7:0] y;
   assign y = sel ? a : b;  // 8-bit 2:1 MUX
   ```

4. **LED Output**: Connect output to an LED to visualize the selection

## Hardware Connections

| Signal | Direction | Description |
|--------|-----------|-------------|
| `sel` | Input | Selector control signal |
| `y` | Output | Selected output value |
| `y_en` | Output | Output enable (always high) |

## Testing Procedure

To test this multiplexer on hardware:

1. Connect the `sel` input to a switch or button
2. Connect the `y` output to an LED
3. Toggle the selector:
   - `sel = 0` → LED should be OFF (output = 0)
   - `sel = 1` → LED should be ON (output = 1)

## Related Concepts

- **Demultiplexer (DEMUX)**: Opposite of MUX - routes one input to multiple outputs
- **Encoder/Decoder**: Similar selection logic with different purposes
- **Tri-state Buffers**: Alternative method for data routing
