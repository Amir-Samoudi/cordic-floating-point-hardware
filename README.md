# Verilog Implementation of CORDIC-based Floating-Point Hardware

This repository contains the **Verilog implementation of floating-point hardware units** for calculating the **reciprocal** and **square root** of a number using the **CORDIC (COordinate Rotation DIgital Computer)** algorithm.  
The project demonstrates how iterative based CORDIC operations can approximate mathematical functions in hardware.

---

## Key Concepts
- **CORDIC Algorithm:** Efficient algorithm for performing trigonometric, hyperbolic, and other mathematical functions using only adders, subtractors, and bit-shifters.  
- **Floating-Point Arithmetic:** Representation and manipulation of floating-point numbers in hardware.   
- **Linear & Hyperbolic Modes:** Two specific CORDIC modes leveraged for reciprocal and square-root calculations.  

---

## Implementations

### 1. Floating-Point Reciprocal Unit (Linear CORDIC)
- **Goal:** Design a hardware module in Verilog that computes the reciprocal (**1/x**) of a floating-point number.  
- **Method:**  
  - Implements the **linear mode** of the CORDIC algorithm.    
  - Manages floating-point format during the process.  

---

### 2. Floating-Point Square-Root Unit (Hyperbolic CORDIC)
- **Goal:** Design a hardware module in Verilog that computes the square root (**√x**) of a floating-point number.  
- **Method:**  
  - Uses the **hyperbolic mode** of the CORDIC algorithm.    
  - Handles pre- and post-processing for floating-point numbers to ensure correct results.  

---
