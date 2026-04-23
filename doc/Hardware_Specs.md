# Hardware Design & Specifications: Project_STM32_EVA

**Platform:** STM32 (ARM Cortex-M4), FreeRTOS (CMSIS-RTOS V2)  

## 1. Bill of Materials (BOM)

| Category | Component | Part/Model | Interface |
| :--- | :--- | :--- | :--- |
| **Compute** | Microcontroller | STM32 Nucleo-F401RE | - |
| **Sensor** | Barometer/Sensor | BME280 | I2C |
| **Sensor** | Light Sensor | KY-018 (LDR) | Analog |
| **Display** | OLED Display | SSD1306 (128x64) | I2C |
| **Input** | Matrix Keyboard | 4x4 Array | GPIO |
| **Input** | Potentiometer | 10k (Penglin P503) | Analog |
| **Input** | Push-Button | 12mm Tactile | GPIO |
| **Actuator** | Piezo Buzzer | KY-006 (Passive) | PWM |
| **Actuator** | LED Set | 5mm (W/Y/G/R/B) | GPIO |
| **Hardware** | Breadboard | RB-Breadboard2 (830) | - |
| **Hardware** | Jumper Wires | M-M / M-F | - |
| **Passive** | Resistor Kit | Standard assortment | - |

## 2. Wiring & Pin Mapping

| Peripheral | STM32 Pin | Function |
| :--- | :--- | :--- |
| **OLED (SDA)** | PB9 | I2C1_SDA |
| **BME280** | PB8 | I2C1_SCL |
| **Matrix Keypad (R1-R4)** | PC0 - PC3 | GPIO Input (Pull-up) |
| **Matrix Keypad (C1-C4)** | PC4 - PC7 | GPIO Output |
| **Potentiometer (Signal)**| PA0 | ADC1_IN0 |
| **Emergency Button** | PA1 | GPIO_Input (EXTI) |
| **Piezo Buzzer (Signal)** | PA8 | PWM_OUT (TIM1) |
| **Status LEDs (5x)** | PB2, PB4 - PB7 | GPIO_Output |

## 3. Design Notes & RTOS Integration

* **Power:** All sensors must operate at **3.3V**. Ensure common ground between the Nucleo board and the breadboard rails to prevent signal noise.
* **I2C Shared Bus (Thread-Safe Access):** The OLED and BME280 share the I2C1 bus. Under FreeRTOS, you **must** use a **Mutex** to prevent simultaneous access by different tasks (e.g., `SensorTask` and `UITask`).
* **Emergency Interrupts (EXTI):** The Emergency Button (PA1) is connected via an External Interrupt. The ISR must not perform heavy processing; it should only send a *Task Notification* to the `SafetyTask` to ensure minimum latency.
* **PWM Signaling:** The Passive Buzzer requires a stable frequency via TIM1. Ensure the `UITask` or `SystemTask` updates the Duty Cycle without blocking the scheduler.
* **Current Limiting:** Use 220Ω - 330Ω resistors for all LEDs to protect GPIO pins and ensure valid logic levels.
* **Pull-up Requirements:** Check your I2C modules; if they do not include built-in pull-ups, add ~4.7kΩ resistors to the SCL and SDA lines.

---
*Created by: Tamara Boerner*