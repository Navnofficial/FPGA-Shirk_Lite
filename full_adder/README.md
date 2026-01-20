# Full Adder - 1-Bit Binary Adder

A complete 1-bit full adder implementation demonstrating fundamental arithmetic logic on the Vicharak Shrike FPGA board. This circuit performs binary addition of three input bits and produces a sum and carry output.

## Project Overview

This project implements a full adder, one of the most important building blocks in digital arithmetic circuits. Unlike a half adder, a full adder can accept a carry input from a previous stage, making it essential for multi-bit addition in CPUs and ALUs.

## Hardware Setup

<img src="full_add_img_1.jpeg" alt="Hardware Setup" width="400"/>

## Output Demonstration

<video width="640" controls>
  <source src="full_add_vid.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

### Video Explanation

The video demonstrates the full adder circuit in operation:

1. **Input Configuration**: Three inputs (a, b, c) are controlled via switches or input pins
2. **Combinational Logic**: The circuit immediately computes sum and carry outputs (no clock delay)
3. **LED Indicators**: Two LEDs show the results:
   - **Sum LED**: Displays the XOR result of all three inputs
   - **Carry LED**: Displays when two or more inputs are HIGH

4. **Test Cases Shown**:
   - **All zeros (0+0+0)**: Sum=0, Carry=0
   - **Single input (1+0+0)**: Sum=1, Carry=0
   - **Two inputs (1+1+0)**: Sum=0, Carry=1
   - **Three inputs (1+1+1)**: Sum=1, Carry=1

The video demonstrates the purely combinational nature of the circuit - outputs change instantaneously when inputs change, with no clock dependency. This shows how the full adder performs basic arithmetic at the hardware level, forming the foundation for more complex arithmetic units.

## Verilog Code

```verilog
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
```

## How It Works

### Full Adder Arithmetic

A full adder performs the binary addition:
```
  a  (first operand)
+ b  (second operand)
+ c  (carry in)
―――――――――――――――――――
 sum (result bit)
carry (carry out to next stage)
```

### Truth Table

Complete behavior for all 8 input combinations:

| a | b | c | sum | carry | Decimal |
|---|---|---|-----|-------|---------|
| 0 | 0 | 0 |  0  |   0   | 0+0+0=0 |
| 0 | 0 | 1 |  1  |   0   | 0+0+1=1 |
| 0 | 1 | 0 |  1  |   0   | 0+1+0=1 |
| 0 | 1 | 1 |  0  |   1   | 0+1+1=2 |
| 1 | 0 | 0 |  1  |   0   | 1+0+0=1 |
| 1 | 0 | 1 |  0  |   1   | 1+0+1=2 |
| 1 | 1 | 0 |  0  |   1   | 1+1+0=2 |
| 1 | 1 | 1 |  1  |   1   | 1+1+1=3 |

**Key Observations**:
- **Sum is 1** when an odd number of inputs are 1 (XOR behavior)
- **Carry is 1** when at least two inputs are 1 (majority function)

### Boolean Logic

#### Sum Output
```
sum = a ⊕ b ⊕ c
```
The sum is a **triple XOR** - it's 1 when an odd number of inputs are 1.

**XOR Chain**:
```
Step 1: a ⊕ b → intermediate result
Step 2: (a ⊕ b) ⊕ c → final sum
```

#### Carry Output
```
carry = (a·b) + (b·c) + (c·a)
```
The carry is a **majority function** - it's 1 when at least two inputs are 1.

**Logic Breakdown**:
- `a & b` → carry when both a and b are 1
- `b & c` → carry when both b and c are 1
- `c & a` → carry when both c and a are 1
- OR all three conditions together

### Karnaugh Map

**Sum (a ⊕ b ⊕ c)**:
```
     c=0  c=1
ab ┌────┬────┐
00 │ 0  │ 1  │
01 │ 1  │ 0  │
11 │ 0  │ 1  │
10 │ 1  │ 0  │
   └────┴────┘
```
Checkerboard pattern → XOR function

**Carry (majority function)**:
```
     c=0  c=1
ab ┌────┬────┐
00 │ 0  │ 0  │
01 │ 0  │ 1  │
11 │ 1  │ 1  │
10 │ 0  │ 1  │
   └────┴────┘
```
Grouped terms → sum of products

## Implementation Details

### Design Style

This implementation uses **continuous assignment** with `assign` statements:

```verilog
assign sum   = a ^ b ^ c;        // Pure combinational
assign carry = (a & b) | (b & c) | (c & a);
```

**Advantages**:
- Simplest, most readable form
- Directly represents Boolean equations
- Synthesizer optimizes to minimal gates
- No clock required (combinational logic)

### Alternative Implementations

**1. Using intermediate wires**:
```verilog
wire sum_ab = a ^ b;
assign sum = sum_ab ^ c;

wire carry_ab = a & b;
wire carry_bc = b & c;
wire carry_ca = c & a;
assign carry = carry_ab | carry_bc | carry_ca;
```

**2. Using always block (behavioral)**:
```verilog
always @(*) begin
    sum = a ^ b ^ c;
    carry = (a & b) | (b & c) | (c & a);
end
```

**3. Using case statement**:
```verilog
always @(*) begin
    case ({a, b, c})
        3'b000: {carry, sum} = 2'b00;
        3'b001: {carry, sum} = 2'b01;
        3'b010: {carry, sum} = 2'b01;
        // ... etc
    endcase
end
```

All synthesize to equivalent gate-level circuits.

## Gate-Level Representation

The full adder synthesizes to approximately:
- **2 XOR gates** (for sum)
- **3 AND gates** (for carry products)
- **1 OR gate** (for carry sum)

```
      ┌───┐
a ────┤XOR├───┐
b ────┤   │   │     ┌───┐
      └───┘   └─────┤XOR├──── sum
                c ──┤   │
                    └───┘

a ──┬────────────┐
    │  ┌───┐     │
b ──┼──┤AND├─┐   │
    │  └───┘ │   │  ┌──┐
c ──┼──┐     ├───┼──┤OR├──── carry
    │  │┌───┐│   │  └──┘
    └──┼┤AND├┘   │
       │└───┘    │
       │  ┌───┐  │
       └──┤AND├──┘
          └───┘
```

## Key Concepts Demonstrated

1. **Combinational Logic**
   - Output depends only on current inputs
   - No memory or state
   - Instantaneous response (within propagation delay)

2. **Boolean Algebra**
   - XOR (exclusive OR) operations
   - AND/OR logic combination
   - Sum-of-products form

3. **Arithmetic Building Blocks**
   - Foundation for multi-bit adders
   - Ripple-carry adders chain full adders
   - Used in ALUs and processors

4. **Logic Minimization**
   - Efficient Boolean expression
   - Minimal gate count
   - SOP (Sum of Products) form for carry

## Learning Outcomes

After studying this project, you will understand:
- How binary addition works at the gate level
- XOR and majority function implementations
- Combinational circuit design
- Truth table to Boolean expression conversion
- Building blocks of arithmetic circuits
- Difference between half adder and full adder

## Multi-Bit Addition

Full adders chain together for multi-bit arithmetic:

**4-Bit Ripple Carry Adder**:
```
  A[3:0]  +  B[3:0]  +  Cin
  
Cin ──→ FA0 ──→ FA1 ──→ FA2 ──→ FA3 ──→ Cout
        ↑       ↑       ↑       ↑
       A[0]    A[1]    A[2]    A[3]
       B[0]    B[1]    B[2]    B[3]
        ↓       ↓       ↓       ↓
       S[0]    S[1]    S[2]    S[3]
```

Each full adder's carry output feeds into the next stage's carry input.

## Performance Considerations

**Propagation Delay**:
- Single full adder: ~2-3 gate delays
- 32-bit ripple adder: ~64-96 gate delays (slow!)

**Optimization Techniques**:
- **Carry Lookahead**: Computes carry in parallel (faster)
- **Carry Select**: Pre-computes both carry scenarios
- **Carry Save**: Delays carry propagation to final stage

These advanced adders trade area for speed.

## Customization Ideas

1. **Half Adder**: Remove carry input `c`
   ```verilog
   assign sum = a ^ b;
   assign carry = a & b;
   ```

2. **4-Bit Adder**: Chain four full adders
   ```verilog
   wire c1, c2, c3;
   full_adder fa0(a[0], b[0], cin,  sum[0], c1);
   full_adder fa1(a[1], b[1], c1,   sum[1], c2);
   full_adder fa2(a[2], b[2], c2,   sum[2], c3);
   full_adder fa3(a[3], b[3], c3,   sum[3], cout);
   ```

3. **Subtractor**: Invert one input and set carry-in to 1
   ```verilog
   assign sum = a ^ ~b ^ 1'b1;  // a - b
   ```

4. **LED Display**: Connect outputs to LEDs for visualization

## Hardware Connections

| Signal | Direction | Description |
|--------|-----------|-------------|
| `a` | Input | First operand bit |
| `b` | Input | Second operand bit |
| `c` | Input | Carry input from previous stage |
| `sum` | Output | Sum result (XOR of all inputs) |
| `carry` | Output | Carry output to next stage |
| `sum_en` | Output | Sum enable (always high) |
| `carry_en` | Output | Carry enable (always high) |

## Testing Procedure

To verify the full adder:

1. **Connect inputs**: Wire a, b, c to switches
2. **Connect outputs**: Wire sum and carry to LEDs
3. **Test all 8 combinations**: Verify truth table
4. **Example test**:
   - Set a=1, b=1, c=1
   - Expected: sum=1 (LED on), carry=1 (LED on)
   - This represents: 1+1+1 = 3 = 11₂ (binary)

## Applications

Full adders are used in:
- **CPUs**: Integer arithmetic units
- **ALUs**: Addition/subtraction operations  
- **DSPs**: Fixed-point arithmetic
- **Memory Controllers**: Address calculation
- **Error Correction**: Syndrome computation

## Related Concepts

- **Half Adder**: 2-input adder (no carry in)
- **Ripple Carry Adder**: Chain of full adders
- **Carry Lookahead Adder**: Parallel carry computation
- **ALU**: Arithmetic Logic Unit (includes adder)
- **Subtractor**: Related circuit using complement
