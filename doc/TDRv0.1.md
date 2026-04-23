# Technical Design Report: Project_STM32_EVA
 
**Platform:** STM32 (ARM Cortex-M4), FreeRTOS (CMSIS-RTOS V2)  
**Objective:** Design and implementation of a modular, real-time multi-tasking environmental monitoring system.

## 1. Project Motivation
Using **FreeRTOS (CMSIS-RTOS V2)** allows for deterministic system behavior, where time-critical tasks (sensor acquisition, safety protocols) can execute independently of slower background processes (UI, data logging). This architecture shifts the system from a simple procedural loop to an event-driven, concurrent design.

**Development Roadmap:**
* **Phase 1:** RTOS & Task Architecture.
* **Phase 2:** Implementation of IPC (Queues/Mutex) for Sensor Fusion & HMI.
* **Phase 3:** Connectivity (Wireless)

---

## 2. Requirements Specification

### 2.1 Tech Stack
* **Microcontroller:** STM32F401RE (Nucleo-64)
* **OS / Middleware:** FreeRTOS (CMSIS-RTOS V2), STM32 HAL
* **Peripherals:** OLED (SPI), 4x4 Matrix Keypad (GPIO), BME280 (I2C), LDR, Buzzer.

### 2.2 Task Architecture (FreeRTOS)
To maintain high system responsiveness, core functions are divided into dedicated tasks:

| Task Name | Priority | Purpose |
| :--- | :--- | :--- |
| **SystemTask** | Real-Time | State Machine management and system health monitoring. |
| **SensorTask** | Medium | Periodic sampling (BME280, LDR) and signal filtering. |
| **UITask** | Low | OLED updates, keypad scanning, and user feedback. |
| **SafetyTask** | High | Hardware Watchdog management and Emergency STOP logic. |

---

## 3. Processing & Logic (Concurrent FSM)

With the FreeRTOS integration, the **Finite State Machine (FSM)** has evolved from a sequential code block to a centralized controller task that processes events.

### 3.1 Inter-Process Communication (IPC)
To ensure thread-safe data exchange, the following FreeRTOS primitives are utilized:

* **Queues:** For transferring keypad inputs and buffered sensor data packages between tasks.
* **Mutex:** For protecting I2C bus access, preventing contention between the BME280 driver and other potential bus peripherals.
* **Event Groups:** For signaling state transitions (e.g., triggering a transition from `RUNNING` to `ALARM`).

### 3.2 State Definitions & Behavior

| State | Execution | Focus |
| :--- | :--- | :--- |
| **BOOT** | One-time | Hardware initialization and task creation. |
| **LOCKED** | Task `UITask` | Idle state, waiting for key input events. |
| **RUNNING** | Task `SensorTask` | Cyclic data acquisition and streaming. |
| **ADJUST** | Task `UITask` | Parameter modification; temporarily pauses sensor logic. |
| **ALARM** | Task `SystemTask` | High-priority activation of audio/visual signaling. |
| **EMERGENCY**| ISR / Task `Safety` | Immediate suspension of all operational tasks. |

### 3.3 Design Notes
* **Deterministic Transitions:** State changes are triggered by semaphores and event flags. If `SensorTask` detects a threshold violation, it sets a flag that `SystemTask` processes immediately.
* **Safety Priority:** The `EMERGENCY` state is triggered directly from the Interrupt Service Routine (ISR) via *Task Notifications*, ensuring microsecond-level latency for system shutdowns.
* **Resource Management:** All non-reentrant functions (specifically HAL I2C drivers) are wrapped within `Mutex` protection blocks to ensure data integrity.

---
*Created by: Tamara Boerner*