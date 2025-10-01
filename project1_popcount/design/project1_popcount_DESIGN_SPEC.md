
# Streaming Popcount (stpopcnt) – Design Specification

## 1. Overview

The **Streaming Popcount** module (`stpopcnt`) is a synchronous SystemVerilog design that computes the number of `1` bits in a 32-bit input word every clock cycle.
The design accepts one 32-bit word per cycle and produces the corresponding **population count** (range: `0–32`) as output.

This module is useful in **bit-level analysis**, **cryptography**, **compression algorithms**, and **error detection** where popcount (counting ones in a vector) is a common operation.

---

## 2. Features

* **Single-cycle throughput**: accepts a new 32-bit word each clock when reset is inactive.
* **Synchronous reset (active-low)**: clears output and internal state when `rst == 0`.
* **Combinational popcount logic** inside a sequential process (result updated every cycle).
* **Parameter-fixed width**: 32-bit input, 6-bit output.
* **Synthesizable** for ASIC and FPGA targets.

---

## 3. Interface Specification

| Signal  | Direction | Width | Description                                                                                |
| ------- | --------- | ----- | ------------------------------------------------------------------------------------------ |
| `clk`   | Input     | 1     | System clock. All operations occur on rising edge.                                         |
| `rst`   | Input     | 1     | Active-low synchronous reset. When `rst == 0`, output is cleared.                          |
| `a`     | Input     | 32    | Input word. The number of `1` bits in `a` is computed each cycle.                          |
| `count` | Output    | 6     | Population count result, range 0–32. Updated on each rising edge of `clk` when `rst == 1`. |

---

## 4. Functional Description

* On reset (`rst == 0`), the output `count` is driven to zero.
* On each rising clock edge when `rst == 1`:

  1. The module initializes a temporary accumulator (`temp_sum`) to zero.
  2. Iterates over all 32 bits of the input `a`.
  3. Adds each bit value (`0` or `1`) to the accumulator.
  4. Updates the output `count` with the final sum.

Thus, `count` always reflects the number of set bits in the **current input word**.

---

## 5. RTL Code (for reference)

```systemverilog
module stpopcnt(
  input  logic        clk,
  input  logic        rst,        // active-low reset
  input  logic [31:0] a,
  output logic [5:0]  count       // 0..32
);

  logic [5:0] temp_sum;

  always @(posedge clk) begin
    if (rst == 0) begin
      count     <= '0;
      temp_sum  <= '0;
    end else begin
      temp_sum = '0;
      for (int i = 0; i < 32; i++) begin
        temp_sum += a[i];
      end
      count <= temp_sum;
    end
  end

endmodule
```

---

## 6. Design Parameters & Notes

* **Output width**: 6 bits, since maximum count = 32 (`log2(33) ≈ 6`).
* **Reset type**: active-low synchronous reset. Reset must be held low for at least one cycle to guarantee initialization.
* **Timing**: one clock cycle latency from input `a` to output `count`.
* **Resource usage**: synthesizers will map the popcount to an **adder tree** or equivalent logic.

---

## 7. Verification Strategy

* **Directed tests**:

  * All zeros (`0x0000_0000`) → count = 0
  * All ones (`0xFFFF_FFFF`) → count = 32
  * Alternating patterns (`0xAAAA_AAAA` → 16, `0x5555_5555` → 16)
  * Edge cases (`0x8000_0001` → 2)

* **Randomized tests**:

  * Apply random 32-bit vectors, compare DUT output with a reference model (`$countones(a)`).

* **Assertions**:

  * Ensure `count` ≤ 32 always.
  * Ensure output is reset to zero when `rst == 0`.

---

## 8. Applications

* Hamming weight calculation.
* Error detection & correction codes.
* Cryptographic algorithms (bit-slicing).
* Compression and encoding schemes.
* Hardware performance counters.
