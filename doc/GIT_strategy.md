# Git Branching Strategy

To keep the project organized, we follow a **Feature Branch** workflow:

- `main`: Stable release code.
- `feature/display`: Custom SSD1306 driver development.
- `feature/sensors`: Implementation of various sensor drivers.
- `feature/security`: Encryption and data validation logic.

**Workflow:**
1. Create a feature branch.
2. Develop and test the module.
3. Merge into `main` after verification.