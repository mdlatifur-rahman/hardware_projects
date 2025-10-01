# project2_fifo — Design Specification

## 1. Overview
Briefly describe what this module/design does, the problem it solves, and the performance/area/power goals.

## 2. Interface Specification
| Signal | Dir | Width | Reset | Description |
|--------|-----|-------|-------|-------------|
| clk    |  I  | 1     | —     | Rising-edge system clock |
| rst_n  |  I  | 1     | 0     | **Active-low synchronous** reset |
| ...    |     |       |       | (add interface signals here) |

### Timing
- Throughput: (items/cycle)
- Latency: (cycles)
- Reset behavior: (what values, for how long)
- Back-pressure/handshake: (ready/valid/etc., if any)

## 3. Functional Description
- Cycle-accurate behavior (what happens on each clock)
- Edge cases (all-zeros, all-ones, empty frames, back-to-back requests, etc.)
- Error handling / illegal inputs

## 4. Micro-Architecture
- Block-level diagram and short description (datapath, control, FIFOs, arbiters)
- Pipelining stages and cut points
- Clock/reset domain notes (CDC if present)
- Power/clock gating strategy (if any)

## 5. Parameters & Configuration
| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| WIDTH     | 32      |       | Example parameter; remove/rename |

## 6. Implementation Notes
- Synthesis hints (RAM/ROM inference, DSP usage, keep attributes)
- Coding style constraints (no latches, blocking vs non-blocking rules)
- Tool/version assumptions

## 7. Performance Targets
- Fmax target(s) on (tech/fpga)
- Area guidance (e.g., LUTs/FFs/BRAMs/DSPs) if known
- Power expectations or budgets (if applicable)

## 8. Verification Hooks
- Assertions (SVA) to include
- Reference model / scoreboard expectations
- Coverage points to expose

## 9. Known Limitations & TODOs
- What is not supported (by design)
- Future improvements

## 10. References
- Protocol specs, papers, tickets, or related repos
