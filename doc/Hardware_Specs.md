# Hardware Design & Specifications: Project_STM32_EVA

This document serves as the master record for the hardware architecture, Bill of Materials (BOM), and electrical interconnects for Project_EVA.

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
| **BME280 / OLED (SDA)** | PB9 | I2C1_SDA |
| **BME280 / OLED (SCL)** | PB8 | I2C1_SCL |
| **Matrix Keypad (R1-R4)** | PC0 - PC3 | GPIO Input (Pull-up) |
| **Matrix Keypad (C1-C4)** | PC4 - PC7 | GPIO Output |
| **Potentiometer (Signal)**| PA0 | ADC1_IN0 |
| **Emergency Button** | PA1 | GPIO_Input (EXTI) |
| **Piezo Buzzer (Signal)** | PA8 | PWM_OUT (TIM1) |
| **Status LEDs (5x)** | PA2 - PA6 | GPIO_Output |

## 3. Design Notes & Safety
* **Power:** All sensors must operate at **3.3V**. Connect Nucleo GND to Breadboard GND rail.
* **I2C Constraints:** OLED and BME280 share I2C1. Ensure address separation (0x3C for OLED). Add ~4.7kΩ pull-ups if not present on modules.
* **Passive Buzzer:** This component requires a PWM signal (frequency) to generate sound.
* **Current Limiting:** Use 220Ω - 330Ω resistors for all LEDs to protect GPIO pins.

---
*Created by: Tamara Boerner*