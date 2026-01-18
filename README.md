# 🖥️ SAP-I Processor Architecture (Verilog Implementation)

## Overview

This project presents a **Verilog-based implementation of the SAP-I (Simple-As-Possible I) computer architecture**, inspired by the classic processor design described in **Albert Paul Malvino’s Digital Logic and Computer Design**. The SAP-I architecture is a minimal yet complete 8-bit processor that demonstrates the fundamental concepts of computer organization, instruction execution, and control logic.

The design has been:
- Fully described using **Verilog HDL**
- **Simulated and functionally verified**
- **Synthesized and implemented on a Spartan-7 FPGA Boolean Board**

This project serves as both an educational reference and a practical demonstration of how classical CPU architectures can be translated into real hardware using modern FPGA technology.

---

## Architectural Background

SAP-I is a foundational processor architecture designed to teach:

- Stored-program concept  
- Instruction fetch–decode–execute cycle  
- Data path and control unit separation  
- Micro-operations and timing control  

Despite its simplicity, SAP-I contains all the essential components of a general-purpose CPU, making it ideal for understanding low-level processor behavior.

---

## Key Specifications

- **Architecture Type:** 8-bit accumulator-based processor  
- **Instruction Width:** 8 bits  
- **Address Width:** 4 bits (16 memory locations)  
- **Data Width:** 8 bits  
- **Clocked Synchronous Design**  
- **Hardwired Control Unit**  

---

## Major Components

The SAP-I processor is composed of the following core hardware modules:

### 1. Program Counter (PC)

- 4-bit register
- Holds the address of the next instruction
- Supports increment and load operations
- Drives the memory address bus during instruction fetch

---

### 2. Memory Address Register (MAR)

- Stores the address used to access RAM
- Receives input from the Program Counter or Instruction Register
- Acts as an intermediary between the CPU and memory

---

### 3. Random Access Memory (RAM)

- 16 × 8-bit memory
- Stores both instructions and data
- Addressed via the MAR
- Outputs data to the system data bus

---

### 4. Instruction Register (IR)

- Holds the currently executing instruction
- Upper nibble represents the opcode
- Lower nibble represents the operand or memory address
- Feeds the control unit for instruction decoding

---

### 5. Accumulator (A Register)

- 8-bit register
- Primary operand and result storage
- Connected directly to the ALU
- Stores intermediate and final computation results

---

### 6. B Register

- Temporary 8-bit register
- Holds the second operand for ALU operations
- Isolated from the main data bus during arithmetic execution

---

### 7. Arithmetic Logic Unit (ALU)

- Performs arithmetic and logical operations
- Supported operations include:
  - ADD
  - SUB
- Outputs results back to the accumulator
- Generates flags (if implemented)

---

### 8. Output Register

- Stores final output data
- Drives external LEDs or display hardware on the FPGA board
- Used to observe program results in real time

---

### 9. Control Unit

- Hardwired control logic
- Implements the instruction execution sequence
- Generates timing and control signals
- Based on a step counter (T-states)

The control unit orchestrates:
- Instruction fetch
- Instruction decode
- Execution micro-operations

---

## Instruction Set Architecture (ISA)

The implemented SAP-I processor supports a minimal instruction set, including:

| Instruction | Description |
|-------------|------------|
| LDA addr | Load accumulator from memory |
| ADD addr | Add memory value to accumulator |
| SUB addr | Subtract memory value from accumulator |
| OUT | Output accumulator value |
| HLT | Halt execution |

Each instruction is executed over multiple clock cycles using predefined micro-operations.

---

## Instruction Cycle

The processor follows the classic **Fetch–Decode–Execute** cycle:

### Fetch Phase
1. PC → MAR
2. RAM → IR
3. PC increment

### Decode Phase
- Opcode decoded by the control unit
- Execution path selected

### Execute Phase
- Memory access and ALU operations performed
- Results stored in registers or output

Each phase is synchronized using clock-driven timing states.

---

## Verilog Design Methodology

- Each architectural block is implemented as a **separate Verilog module**
- Clear separation between:
  - Data path logic
  - Control logic
- Modular and hierarchical design approach
- Synchronous logic using clocked always blocks
- Designed for FPGA synthesis compatibility

---

## Simulation and Verification

The design was extensively verified using:

- Behavioral simulation
- Module-level testing
- Full system integration simulation

Simulation verified:
- Correct instruction execution
- Proper control signal timing
- Accurate data movement across the bus
- Stable clock-domain behavior

---

## FPGA Implementation

The SAP-I processor was synthesized and deployed on a **Spartan-7 FPGA Boolean Board**.

### Hardware Highlights

- Clock mapped to onboard oscillator
- Output register connected to LEDs
- Reset and control inputs mapped to switches
- Real-time execution observable on hardware

The FPGA implementation confirms that the Verilog design is not only functionally correct but also hardware-realizable.

---

## Educational Significance

This project demonstrates:

- Translation of textbook CPU architecture into HDL
- Practical understanding of processor internals
- Real-world FPGA implementation of a classical design
- Strong foundation in digital logic and computer architecture

It bridges the gap between theoretical processor design and actual digital hardware realization.

---

## Future Enhancements

Potential extensions to this architecture include:

- SAP-II style instruction expansion
- Flag registers and conditional branching
- Pipelined execution
- Microprogrammed control unit
- UART or VGA output interfaces
- Expanded memory address space

---

## Conclusion

This SAP-I Verilog implementation faithfully recreates the processor architecture described in Malvino’s Digital Logic textbook while extending it into real, synthesizable hardware on a modern FPGA platform. The project serves as a comprehensive learning tool and a strong demonstration of digital design, Verilog proficiency, and computer architecture fundamentals.

---

## References

- Albert Paul Malvino – *Digital Logic and Computer Design*
- SAP-I Architecture Documentation
- Spartan-7 FPGA Technical Reference Manuals
