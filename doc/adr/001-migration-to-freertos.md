# ADR 001: Selection of FreeRTOS as Operating System

**Status:** Accepted

**Context:**
The project requirements include multi-tasking (concurrent sensor acquisition, HMI updates, and safety monitoring). A traditional bare-metal "super-loop" approach, while simpler, introduces high risk regarding:
1. Deterministic behavior (e.g., timely handling of safety-critical events).
2. Code maintainability as peripheral complexity increases.
3. Scalability for future connectivity features.

**Decision:**
) have decided to use FreeRTOS (CMSIS-RTOS V2) from the start of the implementation.

**Consequences:**
* + Robust task management and priority handling.
* + Improved system stability due to established RTOS primitives (Mutex, Queues).
* - Slight overhead in memory and system complexity.