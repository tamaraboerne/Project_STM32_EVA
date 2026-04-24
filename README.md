# Project_STM32_EVA
**Environmental Variable Analyzer (EVA)**

A modular, real-time, and professional-grade environmental monitoring system powered by the STM32 ARM Cortex-M4 platform.

## Overview
Project_EVA is a real-time environmental monitoring system designed to acquire, process, and visualize sensor data (Temperature, Humidity, Pressure). It utilizes **FreeRTOS** to provide a deterministic, concurrent architecture, ensuring high reliability and modularity. This project serves as a showcase for robust C++ embedded development, FSM-based state management, and thread-safe peripheral integration.

## Project Structure
```text
Project_STM32_EVA/
├── doc/              # Documentation (Technical Design Report, Hardware Specs)
|   └── adr/          # Architecture Decision Records (Why we made our choices)
├── firmware/         # STM32CubeIDE Project + Source Code
├── hardware/         # Schematics, datasheets, photos
└── README.md         # Project entry point
```
## Key Features
* **RTOS Architecture:** Multi-tasking design using FreeRTOS for concurrent sensor processing and HMI updates.
* **Thread-Safe I/O:** Mutex-protected bus communication for I2C and hardware resource management.
* **Deterministic FSM:** Robust state-based architecture with priority-driven safety handling.
* **Security & Safety:** Keypad authentication and hardware-interrupt-driven (EXTI) emergency stop logic.
* **Power Efficient:** Light-sensor-aware UI management to minimize consumption.

## Technical Stack
* **MCU:** STM32F401RET6 (Nucleo-64)
* **OS / Middleware:** FreeRTOS, STM32 HAL
* **Language:** C++17
* **Development:** STM32CubeIDE

## Documentation
* **Technical Design Report (TDR):** `doc/TDR.md`
* **Hardware Specifications:** `doc/Hardware_Specs.md`
* **Decision Records (ADRs):** `doc/adr/` folder (Chronological project history and architectural choices)

## Status
* **Phase 1 (In Progress):** RTOS migration, task architecture, and local sensor fusion.
* **Phase 2 (Planned):** Connectivity integration (WLAN/Bluetooth).

---
*Created by: Tamara Boerner*