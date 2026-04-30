# SSD1306 Memory Addressing Modes

The command `0x20` followed by a specific byte defines the **Memory Addressing Mode**. This setting determines how the display's internal "cursor" (the pointer that decides where the next byte of data goes) moves automatically when it receives data.

---

## 1. Page Addressing Mode (`0x02`) — *Current Implementation*
In this mode, the display acts like a classic typewriter that **cannot** automatically advance to the next line.

* **Behavior:** When data is sent, the column pointer moves from $0$ to $127$. Upon reaching column $127$, the pointer wraps back to column $0$ **on the same page**. The page pointer does not change.
* **Why we use it:** It is the most reliable mode for custom drivers. Our `update()` function manually "steers" the display by explicitly setting the Page ($0-7$) and Column ($0$) before sending each 128-byte row. This prevents the hardware from moving the cursor unexpectedly and ensures our RAM buffer matches the screen exactly.

## 2. Horizontal Addressing Mode (`0x00`)
In this mode, the display acts like a modern word processor with "word wrap."

* **Behavior:** When the column pointer hits $127$, it **automatically** jumps to column $0$ of the **next page**. After the 128th byte of Page 7 is received, it wraps all the way back to Page 0, Column 0.
* **Why it failed initially:** While our code was trying to manually set the page (using the command `0xB0`), the hardware was *also* trying to auto-advance the page because it was receiving data. These two "drivers" (the software and the hardware logic) conflicted, causing the data to smear or shift into the wrong memory locations (the "chunk" at the bottom).

## 3. Vertical Addressing Mode (`0x01`)
This is a "rotated" version of the Horizontal mode.

* **Behavior:** Data fills vertically through the pages first. After the 8th bit (the bottom) of Page 7 is filled, the cursor moves to the top of the **next column** at Page 0.
* **Use Case:** This is rarely used unless the physical display is mounted vertically (90° rotation) and you want to optimize how text is "poured" into the memory buffer.

---

## Summary Table

| Mode | Value | Auto-advance Page? | Best Use Case |
| :--- | :--- | :--- | :--- |
| **Page** | `0x02` | **No** | Custom drivers, manual control, and Page-mode libraries. |
| **Horizontal** | `0x00` | **Yes** | High-speed full-screen updates and animations. |
| **Vertical** | `0x01` | **Yes (Vertical)** | Specialized vertical user interfaces. |