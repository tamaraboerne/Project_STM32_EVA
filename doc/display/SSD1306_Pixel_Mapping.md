# Coordinate System (Display Mapping)

After initializing the display with `0xA0` (Segment Remap) and `0xC0` (COM Scan Direction), the coordinate system is defined as follows:

- **Origin (0,0):** Top-left corner.
- **X-Direction:** 0 to 127 (Horizontal from left to right).
- **Y-Direction:** 0 to 63 (Vertical from top to bottom).



### Coordinate Reference Table

| Point | X-Coordinate | Y-Coordinate | Position Description |
| :--- | :--- | :--- | :--- |
| **Top-Left** | 0 | 0 | Origin / Starting Point |
| **Top-Right** | 127 | 0 | End of Page 0 (Top row) |
| **Bottom-Left** | 0 | 63 | Start of Page 7 (Bottom row) |
| **Bottom-Right** | 127 | 63 | End of Display Buffer |

---

### Implementation Note
When using the `writeString(x, y, ...)` function, the **Y** parameter represents the top-most pixel of the character. Since our font is 7 pixels high, a string placed at $y=10$ will occupy the vertical space from $y=10$ to $y=17$.

To center a single line of text vertically, use a **Y** value of approximately **28**:
- Formula: $(64 \text{ pixels height} - 8 \text{ font height}) / 2 = 28$

### Hardware Configuration
These specific hardware commands in the `init()` sequence establish this mapping:
* `0xA0`: Segment Remap (Column 0 is mapped to SEG0).
* `0xC0`: COM Scan Direction (Scan from COM0 to COM63).