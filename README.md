# 8-Bit-Approximate-Multiplier-Design


This project implements an # Approximate 8x8 Multiplier using Low Error 4:2 approximate compressors and a custom-designed approximate 4-bit full adder. The architecture targets **error-tolerant applications** such as image processing, where reductions in power, area, and delay are more valuable than absolute accuracy.

The multiplier is structured in multiple reduction stages using a combination of **approximate compressors**, **approximate adders**, and **exact logic components**, optimized to minimize complexity while maintaining acceptable output quality.

---

## 🔍 Key Features

- **Custom 4:2 Compressor**: Reduced gate count and independent computation of sum and carry.
- **Approximate 4-bit Full Adder**: Designed with minimal logic to reduce delay and power, primarily used on LSB side.
- **Three-Stage Multiplier Design**: Combines approximate and exact arithmetic blocks for optimized performance.

---

## 🛠️ Technology Stack

- **Hardware Description Language**: Verilog
- **Simulation Tool**: ModelSim / Vivado (recommended for testbench execution)
- **Design Visualization**: Gate-level architecture diagrams provided in `/Figures/`

---

## 🚧 To Be Added

- Netlist and physical implementation files
- Area, power, and timing synthesis reports
- MATLAB scripts for image processing validation

---
