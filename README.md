Most recent update - Implemented randomisation in driver and made driver independent of dut empty and full signals.

# FIFO Verification (SystemVerilog)

## Overview

Implemented and verified a synchronous FIFO (in Vivado) using a basic SystemVerilog testbench (non-UVM) to understand core DV concepts: stimulus, monitoring, and checking.

---

## FIFO Specs

* 8-bit data, depth = 8
* Signals: `wr_en`, `rd_en`, `full`, `empty`
* **1-cycle read latency (registered output)**

---

## Verification Architecture

```text
Driver → Interface → DUT → Monitor → Scoreboard
```

* **Driver**: Generates write/read stimulus (clocking block)
* **Monitor**: Observes DUT signals, aligns read latency (1-cycle delay)
* **Scoreboard**: Queue-based reference model

  * write → push_back
  * read  → pop_front + compare

---

## Key Concepts

* **Latency alignment**: monitor delays `rd_en` to match DUT timing
* **Blocking vs non-blocking**: `<=` used for cycle-accurate delay
* **Transaction ≠ cycle**: valid reads = cycles − latency
* **Separation**: DUT (design) vs TB (verification logic)

---

## Bugs Found & Fixed

* Early sampling → shifted data mismatch
* Over-delay → skipped transactions
* Mixing delayed control with current `empty` → last value drop

---

## Result

```text
PASS: 10
PASS: 20
PASS: 30
PASS: 40
```

---

## Structure

```text
main.sv        # FIFO RTL
fifo_if.sv     # Interface
driver.sv
monitor.sv
scoreboard.sv
tb.sv
```
