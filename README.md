# Project_STM32_EVA
**Environmental Variable Analyzer (EVA)**

A modular, robust, and professional-grade environmental monitoring system powered by the STM32 ARM Cortex-M4 platform.

## Overview
Project_EVA is designed to acquire, process, and visualize environmental sensor data (Temp, Humidity, Pressure) with a focus on real-time reliability and industrial-standard coding practices. This project serves as a showcase for C++ embedded development, FSM-based system architecture, and peripheral integration.

## Project Structure
```text
Project_STM32_EVA/
├── doc/              # Documentation (TDR, Hardware Specs, BOM)
├── firmware/         # STM32CubeIDE Project
│   ├── src/          # Source code (C++17)
│   └── inc/          # Header files
├── hardware/         # Schematics, datasheets, photos
└── README.md         # Project entry point
```
## Key Features
* **Multi-Sensor Fusion:** I2C-based BME280 data acquisition.
* **Deterministic FSM:** Robust state-based architecture for system control.
* **Security & Safety:** 4-digit keypad authentication and hardware-interrupt-driven emergency stop.
* **Power Efficient:** Light-sensor-aware UI management.

## Technical Stack
* **MCU:** STM32F401RET6 (Nucleo-64)
* **Language:** C++17
* **Development:** STM32CubeIDE (Ubuntu)
* **Standards:** MISRA C++ subset, LLVM guidelines.

## Documentation
* **Technical Design Report (TDR):** Located in `doc/TDR.md`.
* **Hardware Specifications:** Located in `doc/Hardware_Specs.md`.

## Status
* **Phase 1 (In Progress):** Local sensor fusion and HMI development.
* **Phase 2 (Planned):** Connectivity (WLAN/Bluetooth).
* **Phase 3 (Planned):** Zephyr RTOS migration.

---
*Created by: Tamara Boerner*