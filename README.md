# FIFO Design & Verification (SystemVerilog)

## Overview

This project implements and verifies an 8×8 synchronous FIFO in SystemVerilog. The focus is not just on design, but on building a complete verification environment and ensuring correctness under randomized stress conditions.

---

## Features

* 8-bit data width, depth = 8
* Registered read output (1-cycle latency)
* Full / Empty flag generation
* Concurrent read & write support

---

## Verification Environment

```text
Driver → Interface → DUT → Monitor → Scoreboard
```

* **Driver**: Random, protocol-aware stimulus (IDLE / READ / WRITE / BOTH)
* **Monitor**: Latency-aligned observation of DUT signals
* **Scoreboard**: Queue-based reference model for data integrity
* **Interface**: Clocking block for clean timing

---

## Key Techniques

* **Model-based stimulus** using `expected_count` (independent of DUT signals)
* **Randomized testing** with legal operation filtering
* **Functional coverage** (wr_en, rd_en, full, empty + cross coverage)
* **Assertion-based verification (SVA)** for protocol correctness:

  * No write when full
  * No read when empty
  * Count stays within bounds

---

## Debugging Highlights

* Fixed latency misalignment between `rd_en` and `rd_op`
* Resolved scoreboard desynchronization caused by underflow
* Eliminated DUT dependency in driver to avoid timing races
* Focused on **first failure debugging** to identify root causes

---

## Results

* Stable execution under **10K+ cycle randomized stress testing**
* Zero data mismatches
* No protocol violations
* Verified correct FIFO ordering under all tested conditions

---

## Key Learnings

* Verification depends on **timing correctness**, not just logic
* Random testing reveals bugs hidden by directed tests
* Testbench must be **independent of DUT internal timing**
* Coverage is required to prove completeness

---

## Future Work

* UVM-based implementation
* Asynchronous FIFO (CDC handling)
* Protocol-level verification (AXI / SPI)

---
