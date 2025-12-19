# CSARCH1
Introduction to Computer Organization and Hardware

# Microcoded Digital Access Controller (MDAC)

A keypad-controlled finite-state machine built using combinational logic, control decoding, and synchronous sequential behavior.

This project is designed to mirror how real hardware control units work and serves as a practical bridge between logic gates and computer architecture.

---

The **Microcoded Digital Access Controller (MDAC)** is a digital system that:

- Accepts button inputs as **signals**, not numeric values
- Uses **combinational logic** to decode inputs and generate control signals
- Uses **synchronous sequential logic** (flip-flops and an FSM) to track system state over time
- Operates in multiple modes:
  - Locked
  - Input
  - Verify
  - Error
  - Unlocked
- Is implemented entirely in **Verilog**, using:
  - Explicit logic gates
  - Structural modeling
  - Behavioral modeling
- Is fully testable via simulation using **iVerilog** and **GTKWave**

This is a small but realistic digital system—the kind of design that sits underneath CPUs, controllers, and embedded devices.

---

## Functional Specifications

### Inputs

- `clk` — system clock  
- `reset` — synchronous reset  
- `btn[3:0]` — four button inputs (one-hot encoded, non-numeric)  
- `enter` — confirms input  
- `clear` — clears current entry  

### Outputs

- `locked` — indicates system is locked  
- `unlocked` — indicates system is unlocked  
- `error` — indicates incorrect sequence  
- `state[2:0]` — current FSM state (debugging output)  

---

## Behavioral Requirements

### Finite State Machine (Synchronous Sequential Logic)

The controller must implement an FSM with **at least five states**:

1. `LOCKED`
2. `INPUT`
3. `VERIFY`
4. `UNLOCKED`
5. `ERROR`

All state transitions must be:
- Clocked
- Synchronous
- Deterministic

---

### Input Handling (Combinational Logic)

- Button presses are **one-hot encoded**
- A combinational **decoder** translates button signals into control signals
- Invalid input combinations (e.g., multiple buttons pressed simultaneously) must be:
  - Detected
  - Properly handled by the system

This portion of the design explicitly uses **Boolean algebra** and **Karnaugh map minimization**.

---

### Verification Logic (Combinational Circuit)

- The access pattern is stored internally as **logic**, not memory
- A combinational comparison circuit determines whether the input sequence matches the expected pattern
- Must be implemented using explicit logic gates:
  - AND
  - OR
  - NOT
  - XOR
- Boolean expressions must be minimized using **Karnaugh maps**, which are documented in the project

---

### Control Unit (Hybrid Design)

- A combinational **next-state logic** block
- A sequential **state register**
- Output logic depends only on the current state  
  (Moore-style FSM is preferred)

---

## HDL Design Requirements

### 1. Gate-Level Module

- Manual implementation of:
  - AND
  - OR
  - NOT
  - XOR
- Used by higher-level modules
- Structural modeling only

---

### 2. Combinational Modules

Includes:
- Button decoder
- Invalid-input detector
- Comparison logic

Each module must include:
- Truth tables
- Boolean expressions
- Karnaugh map minimization

---

### 3. Sequential Modules

- D flip-flop  
  - Implemented structurally **or** using `always @(posedge clk)`
- State register
- FSM controller

---

### 4. Top-Level Integration

- All modules are connected in a clear hierarchy
- No behavioral shortcuts or “magic comparisons”
- Signal flow is explicit and traceable

---

## Verification & Testing

The project includes a comprehensive testbench that:

- Generates clock and reset signals
- Simulates valid and invalid input sequences
- Demonstrates all FSM state transitions

GTKWave waveforms are provided to show:
- State transitions
- Input decoding behavior
- Error detection and recovery

---

## Documentation

The repository includes documentation covering:

- FSM state diagram
- Boolean equations (before and after minimization)
- Karnaugh maps
- Module hierarchy diagram
- Design rationale, including:
  - Why synchronous logic is used
  - Why each state exists
  - How race conditions are avoided

This mirrors how real digital hardware is not only built, but **justified**.

---

## Tools Used

- **Verilog HDL**
- **Icarus Verilog (iVerilog)** for simulation
- **GTKWave** for waveform visualization

---

