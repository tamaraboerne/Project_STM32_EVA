### Why is my display not updating?
- **The One-Shot Trap:** If drawing logic is placed before the `for(;;)` loop, it only executes once. If the display is still initializing or the I2C bus is busy, the command is lost.
- **The Buffer Sync:** Always ensure `display.update()` is called *after* all `draw` or `write` commands.
- **Continuous Refresh:** For dynamic data (like sensor values), drawing logic MUST be inside the infinite loop.

