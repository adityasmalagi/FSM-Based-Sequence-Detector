# FSM-Based 1010 Sequence Detector Using Verilog HDL

## 1. Project Overview

A **1010 Sequence Detector** is a sequential digital circuit that monitors a continuous stream of binary data and identifies the occurrence of the specific pattern `1010`.

This project implements a sequence detector using **Verilog HDL and AMD Xilinx Vivado**, applying the concept of a Finite State Machine (FSM). The design demonstrates how digital circuits can store information about previously received bits and use that information to detect a particular sequence.

Unlike combinational circuits, which depend only on current inputs, a sequence detector requires memory of previous inputs. This is achieved using states stored in flip-flops and updated according to the clock signal.

### Objectives

- Design an FSM-based sequence detector using Verilog HDL.
- Understand sequential logic and state transitions.
- Explore Moore and Mealy FSM architectures.
- Simulate the RTL design and analyze waveforms in Vivado.
- Verify the detection output for different input patterns.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Project | 1010 Sequence Detector |
| Design methodology | Finite State Machine (FSM) |
| Target pattern | `1010` |
| Input | Serial binary data (`din`) |
| Output | Detection flag (`dout`) |
| HDL | Verilog HDL |
| Tool | AMD Xilinx Vivado |
| Verification | RTL simulation and waveform analysis |

*The exact FSM type, reset behavior, and overlapping detection support depend on the implemented RTL.*

## 3. Working Principle

The detector processes one input bit at a time. Each FSM state represents the progress made toward matching the target sequence.

For a typical implementation, the states represent:

- **S0:** No matching prefix detected.
- **S1:** The first bit `1` is detected.
- **S2:** The partial sequence `10` is detected.
- **S3:** The partial sequence `101` is detected.
- **Detection:** The complete sequence `1010` is recognized.

### Example

```text
Serial Input:  1 0 1 0
               | | | |
FSM State:     S1 S2 S3 DETECT
Output:        0  0  0  1
```

This example illustrates a Moore-style detector with a dedicated detection state. The precise output timing depends on the implementation.

When the input bit completes the pattern `1010`, the detector asserts its output to indicate successful detection.

## 4. Finite State Machine (FSM)

An FSM is a digital design model containing a finite number of states and defined rules for transitioning between them.

In this project, the FSM tracks the partial sequence received so far instead of storing the entire input stream.

### State Transition Concept

| Current State | Input `0` | Input `1` |
|---|---|---|
| S0 | S0 | S1 |
| S1 | S2 | S1 |
| S2 | S0 | S3 |
| S3 | Detection transition | S1 |

The transition from S3 on input `0` completes the sequence `1010`. In a Moore implementation, the circuit can enter a dedicated detection state. In a Mealy implementation, detection can be indicated directly by the relevant state and input combination.

The transition after detection must be designed according to whether overlapping sequences are supported.

## 5. Moore and Mealy Architectures

A sequence detector can be implemented using either a Moore or a Mealy FSM.

**Moore FSM:** The output depends only on the current state.

\[
dout=f(state)
\]

A dedicated detection state is commonly used. The output changes when the FSM enters or leaves that state.

**Mealy FSM:** The output depends on the current state and input.

\[
dout=f(state,din)
\]

The output can be asserted on the transition that completes the sequence, potentially avoiding an additional detection state.

The main difference is the dependency of the output: state only for Moore, and state plus input for Mealy.

## 6. RTL Design Structure

A typical FSM implementation contains three main sections:

1. **State register:** Stores the current state and updates on the specified clock edge.
2. **Next-state logic:** Determines the next state from the current state and input.
3. **Output logic:** Generates the sequence detection signal.

Illustrative Verilog for a state register:

```verilog
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= S0;
    else
        state <= next_state;
end
```

This example uses a rising-edge clock and active-low asynchronous reset. The actual design may use different reset behavior.

The next-state logic is commonly described using a combinational `always @(*)` block and a `case` statement. Output logic depends on whether the design uses a Moore or Mealy architecture.

## 7. Simulation and Verification

RTL simulation is used to verify that the design behaves according to its specification before hardware implementation.

A testbench applies the clock, reset, and serial input pattern, then observes the detection output.

### Recommended Test Cases

| Test | Input | Expected behavior |
|---|---|---|
| Reset | Reset asserted | FSM returns to initial state |
| Valid pattern | `1010` | Detection output asserts |
| Incomplete pattern | `101` | No completed-sequence detection |
| No matching pattern | `0000` | No detection |
| Valid pattern with prefix | `11010` | Detects the `1010` suffix |
| Repeated patterns | `101010` | Verify repeated and overlapping detection behavior |

The exact waveform must be interpreted according to the FSM architecture and output timing.

### Signals to Observe in Vivado

- `clk` — clock signal.
- `rst_n` or `reset` — reset signal.
- `din` — serial input.
- `state` — current FSM state, if exposed.
- `dout` — sequence detection output.

Waveform analysis helps identify incorrect transitions, reset issues, and unexpected output behavior.

## 8. Synthesis and Applications

During synthesis, the RTL is converted into a gate-level representation. The FSM may be implemented using flip-flops for state storage and combinational logic for state transitions and output generation.

Sequence detectors are useful in:

- Serial communication receivers.
- Digital protocol monitoring.
- Command recognition systems.
- Data-stream pattern matching.
- FPGA-based digital systems.
- ASIC control and interface logic.

## 9. Learning Outcomes

This project provides practical experience in:

- Designing sequential circuits using Verilog HDL.
- Translating a pattern into an FSM.
- Understanding clocked logic and state transitions.
- Comparing Moore and Mealy architectures.
- Writing and running RTL simulations.
- Debugging circuit behavior using waveforms.
- Understanding basic FPGA and ASIC RTL design concepts.

## 10. Future Improvements

- Implement both Moore and Mealy versions.
- Support configurable sequence patterns.
- Add overlapping sequence detection.
- Develop a self-checking SystemVerilog testbench.
- Implement the design on an FPGA board.

## Tools and Technologies

**Verilog HDL | AMD Xilinx Vivado | Finite State Machines | RTL Simulation | Waveform Analysis**

## Author

**Aditya S. Malagi**  
B.Tech, Electronics and Communication Engineering  
CMR University, Bengaluru

---

*This project demonstrates the application of FSM-based sequential logic for binary pattern detection and strengthens foundational skills in digital design, RTL development, and functional verification.*
