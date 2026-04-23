# Technical Design Report: Project_STM32_EVA

**Author:** Tamara Boerner  
**Platform:** STM32 (ARM Cortex-M4)  
**Objective:** To design and implement a modular embedded system for real-time environmental data acquisition and processing.

## 1. Project Motivation
The objective of this project is to apply advanced embedded software engineering principles to a modular environmental monitoring system. This project serves as a technical evolution of previous academic work, addressing architectural challenges encountered during earlier prototyping phases (e.g., peripheral driver stability).

**Development Roadmap:**
* **Phase 1:** Local Sensor Fusion and HMI (Human-Machine Interface).
* **Phase 2:** Connectivity Integration (WLAN/Bluetooth).
* **Phase 3:** Real-Time Operating System (RTOS) migration to Zephyr.

## 2. Requirements Specification

This section defines the technical and functional requirements for Project_STM32_EVA. It establishes the system's operational scope, hardware boundaries, and design constraints. By formalizing these specifications, we ensure a structured development process that prioritizes modularity, reliability, and deterministic system behavior, providing a clear roadmap for both implementation and verification.

### 2.1 Tech Stack
* **Microcontroller:** STM32F401RE (Nucleo-64)
* **Peripherals:** OLED Display, 4x4 Matrix Keypad, Trimm Potentiometer, Tactile Push-Button, BME280 (I2C), Light Sensor (LDR), Piezo Buzzer, Status LEDs.

### 2.2 Hardware Interface
| Component | Protocol | Purpose |
| :--- | :--- | :--- |
| **BME280** | I2C | Environmental sensing (T, P, H) |
| **OLED Display** | SPI | UI feedback |
| **Matrix Keypad** | GPIO | Security code and threshold entry |
| **Potentiometer** | ADC | Manual threshold adjustment |
| **Piezo/LEDs** | GPIO/PWM | Alarm signaling & State indication |

### 2.3 User Experience (UX) Goals
* **Security:** The system remains `LOCKED` until a valid 4-digit code is input via the keypad.
* **Safety:** A dedicated physical button implements a "Global Reset/Emergency STOP."
* **Power Awareness:** Automatic screen-saver mode (Display OFF) triggered by the Light Sensor to prevent burn-in and minimize power consumption.

### 2.4 Design Constraints
* **Language:** ISO C++17 (Object-Oriented Architecture).
* **Reliability:** Hardware Watchdog Timer (WDT) enabled.
* **Coding Standard:** Adherence to subset of MISRA C++ and LLVM standards for portability.

## 3. Processing & Logic (Finite State Machine)

The system architecture utilizes a Finite State Machine (FSM) to ensure deterministic behavior, robust error handling, and a clear separation of concerns. The FSM is categorized into **Operative Modes** (standard workflows) and **Safety/Exception Modes** (critical overrides).

### 3.1 State Definitions

| State | Category | Description |
| :--- | :--- | :--- |
| **BOOT** | Operative | System initialization, Hardware Abstraction Layer (HAL) self-test, and sensor calibration. |
| **LOCKED** | Operative | Idle/Standby state; prevents unauthorized access via a mandatory 4-digit security code. |
| **RUNNING** | Operative | Standard data acquisition loop; real-time sensor processing and display updates. |
| **ADJUST** | Operative | Configuration mode; enables parameter modification via potentiometer and keypad input. |
| **ALARM** | Exception | Triggered by a threshold violation; activates audio/visual signaling requiring manual code clearance. |
| **EMERGENCY** | Safety | Triggered by hardware interrupt; immediate cessation of all actuator operations for system safety. |

### 3.2 Design Notes
* **Deterministic Transition:** State transitions are managed via a central control structure to prevent illegal state jumps and ensure system stability.
* **Safety Priority:** The `EMERGENCY` state is mapped to an External Interrupt (EXTI), allowing it to bypass the main control loop and ensure immediate system response regardless of the current mode.
* **Scalability:** The modular design of this FSM allows for the addition of future connectivity states (e.g., WLAN/Bluetooth integration) without restructuring the core logic.



Useing FreeRTOS CMSIS_V2 + HAL 

---
*Created by: Tamara Boerner*