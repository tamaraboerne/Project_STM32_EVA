# Technical Documentation: SSD1306 Memory Mapping & Logic

## 1. Hardware Architecture
The SSD1306 is a monochrome OLED controller for a **128x64 pixel** matrix. Unlike a standard PC monitor where memory is organized pixel-by-pixel horizontally, the SSD1306 uses a **Page-Oriented structure** to optimize I2C data throughput.

* **Total Pixels:** $128 \times 64 = 8,192$ pixels.
* **Memory Pages:** The 64 vertical pixels are divided into **8 Pages** (Page 0 to Page 7).
* **Page Height:** Each page is exactly **8 pixels high**.
* **Data Unit:** **1 Byte (8 bits)**. In this architecture, one byte represents a vertical column of 8 pixels within a page.



---

## 2. Coordinate Mapping Math
To draw a pixel at a logical coordinate $(x, y)$, we must translate it into an index for our 1024-byte linear array (`buffer[1024]`).

### The Index Formula
$$Index = x + \left(\frac{y}{8}\right) \times 128$$

* **`y / 8`**: Integer division determines which **Page** the pixel belongs to.
* **`* 128`**: Since each page spans the full width of the display (128 columns), we skip 128 bytes for every page we move down.
* **`+ x`**: Moves the pointer to the specific horizontal **Column**.

---

### 3. Bitwise Manipulation Details

Since one byte controls 8 vertical pixels, we use specific bitwise operators to target a single pixel (bit) without affecting the other seven pixels sharing that same byte.

#### Setting a Pixel (ON)
To turn a pixel on, we use the **Bitwise OR** operator (`|=`) with a **Bitmask**.

* **(1 << (y % 8))**: Creates the mask. 
    * Example: If $y = 3$, then $3 \pmod 8 = 3$. 
    * Shifting `1` left by 3 positions gives `00001000`.
* **`|=`**: The OR operation ensures that if the mask has a `1`, the corresponding bit in the buffer becomes `1`. If the buffer bit was already `1`, it remains `1`.

#### Clearing a Pixel (OFF)
To turn a pixel off, we use the **Bitwise AND** operator (`&`) with an **Inverted Mask**.

```cpp
buffer[index] &= ~(1 << (y % 8));
```
* **`~` (NOT)**: Inverts the mask. 
    * *Example:* A mask of `00001000` becomes `11110111`.
* **`&=`**: The **AND** operation forces the bit to `0` only where the mask has a `0`. Because all other bits in the inverted mask are `1`, those pixels in the buffer remain unchanged.

---

## 4. Communication Protocol (`update()`)

The `update()` function serves as the bridge that synchronizes the STM32 internal RAM buffer with the physical Display Hardware.

* **Iterate Pages**: The function loops through all 8 pages (Page 0 to Page 7).
* **Set Hardware Pointers**: Before sending pixel data, we must tell the SSD1306 where to store it:
    * `0xB0 + i`: Command to set the **Page Start Address**.
    * `0x00` & `0x10`: Commands to reset the **Column Start Address** to the far left (0).
* **Burst Transfer**: `writeData` sends all 128 bytes of the current page in one continuous I2C stream.
* **Thread Safety**: By wrapping this logic in a **Mutex**, we ensure that if another FreeRTOS task tries to use the I2C bus, it must wait until the current "Update" is finished. This prevents screen tearing or data corruption.

---

## 5. Summary of Implementation

| Function | Responsibility |
| :--- | :--- |
| **`clear()`** | Resets the entire local 1024-byte RAM buffer to `0x00` (All pixels black). |
| **`drawPixel()`** | Calculates the buffer index and applies bitwise logic to modify a specific bit. |
| **`update()`** | Executes the I2C protocol to push the local RAM buffer to the OLED hardware. |

---

## Code Reference
```cpp
/**
 * @brief Maps logical coordinates to the SSD1306 page-buffer.
 * @param x Horizontal coordinate (0-127)
 * @param y Vertical coordinate (0-63)
 * @param color True for white (ON), False for black (OFF)
 */
void SSD1306::drawPixel(int16_t x, int16_t y, bool color) {
    // 1. Boundary Protection
    if (x < 0 || x >= 128 || y < 0 || y >= 64) return;

    // 2. Locate the byte in the buffer
    uint16_t index = x + (y / 8) * 128;

    // 3. Apply Bitwise Logic
    if (color) {
        buffer[index] |= (1 << (y % 8));    // Set bit ON
    } else {
        buffer[index] &= ~(1 << (y % 8));   // Clear bit OFF
    }
}
```