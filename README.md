# Shrike_lite - FPGA Projects Repository

This repository contains beginner-friendly FPGA projects designed for the **Vicharak Shrike** FPGA development board. Each project demonstrates fundamental digital logic concepts implemented in Verilog HDL.

## About Shrike Board

The **Vicharak Shrike** is a powerful FPGA development board perfect for learning digital design and implementing hardware projects.

- **Board Introduction**: [Shrike Documentation](https://vicharak-in.github.io/shrike/introduction.html)
- **Hardware Overview**: [Hardware Specifications](https://vicharak-in.github.io/shrike/hardware_overview.html)

### Pinout Reference

The repository includes comprehensive pinout diagrams for hardware connections:

#### Shrike Board Pinout
<img src="shrike_pinouts.svg" alt="Shrike Board Complete Pinout" width="600"/>

#### CPU Interconnect Pinout
<img src="CPU Interconnect pin out.png" alt="CPU Interconnect Pinout" width="600"/>

## Projects

This repository contains the following FPGA projects:

| Project | Description | 
|---------|-------------|
| [Blink](Blink/) | Sequential LED blinking pattern using one-hot encoding | 
| [Mux](Mux/) | 2:1 Multiplexer with selector input | 
| [Counter](counter/) | 0-9 Seven-segment display counter with button input | 
| [Full Adder](full_adder/) | 1-bit full adder with sum and carry outputs | 

## Project Structure

Each project folder contains:
- **Verilog source file** (`.v`) - HDL implementation
- **FFPGA project file** (`.ffpga`) - Project configuration
- **Images** (`.jpeg`) - Hardware setup photos (where available)
- **Video** (`.mp4`) - Working demonstration (where available)
- **README.md** - Detailed project documentation

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd Shirk_lite
   ```

2. **Select a project**: Navigate to any project folder (e.g., `cd Blink`)

3. **Open in your FPGA IDE**: Load the `.ffpga` project file

4. **Review the code**: Study the Verilog source file and README

5. **Build and deploy**: Compile and upload to your Shrike board

## Requirements

- Vicharak Shrike FPGA board
- FPGA development tools compatible with Shrike
- Basic understanding of Verilog HDL (helpful but not required)

## Learning Path

We recommend exploring the projects in this order:

1. **Mux** - Learn basic combinational logic
2. **Full Adder** - Understand arithmetic circuits
3. **Blink** - Explore sequential logic and counters
4. **Counter** - Master complex state machines and displays

## Contributing

Feel free to add more beginner-friendly projects or improve existing ones!

## License

This repository is for educational purposes.
