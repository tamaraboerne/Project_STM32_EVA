# 5x7 Bitmap Font Logic

## 1. Data Structure
Each character in our font is represented by **5 bytes**. Each byte represents a single vertical column of the character (8 pixels high). 

* **Character Width:** 5 pixels
* **Character Height:** 7 pixels (stored in an 8-bit byte, the 8th bit is usually used for spacing or descenders).
* **Total Storage:** 5 bytes per character.

## 2. Accessing the Table
Since the standard ASCII table starts with non-printable characters (like "Backslash-Zero" or "Escape"), our table starts at ASCII **32** (the Space character).

To find a character in the `font5x7` array:
$$Index = (ASCII\_Value - 32) \times 5$$

## 3. Rendering Logic
To display a character at $(x, y)$:
1. Calculate the starting index in the table.
2. Loop through **5 columns** ($i = 0$ to $4$).
3. For each column, read the byte and loop through **8 bits** ($j = 0$ to $7$).
4. If a bit is set to `1`, call `drawPixel(x + i, y + j)`.

## 4. Text Spacing
To prevent letters from touching, we add **1 pixel of padding** after each character. Therefore, each character effectively takes up **6 pixels** of horizontal space.


## 5. Visualizing the Bit-to-Pixel Mapping
For the letter 'A', the first byte in the table is `0x7E` (Binary: `01111110`).

| Bit | Value | Pixel State |
| :--- | :--- | :--- |
| 0 | 0 | OFF (Bottom Padding) |
| 1 | 1 | ON |
| 2 | 1 | ON |
| 3 | 1 | ON |
| 4 | 1 | ON |
| 5 | 1 | ON |
| 6 | 1 | ON |
| 7 | 0 | OFF (Top Padding) |

As the `writeChar` function loops through the 5 bytes, it builds the character column by column.