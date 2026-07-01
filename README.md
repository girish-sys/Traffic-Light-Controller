# Traffic Light Controller using Verilog HDL

A Finite State Machine (FSM)-based traffic light controller implemented in Verilog HDL. The controller manages a highway and country-road intersection, giving priority to the highway while responding to vehicle detection on the country road.

## Features

- Finite State Machine (FSM) implementation
- Highway remains green by default
- Country-road green signal activated only when a vehicle is detected
- Automatic yellow-light transitions for safe switching
- Highway priority restored when the country road is clear
- Timer-based state transitions
- Verilog testbench for functional verification
- Compatible with Icarus Verilog and GTKWave

---

## FSM States

- **HW_GREEN** – Highway Green, Country Road Red
- **HW_YELLOW** – Highway Yellow before switching
- **CT_GREEN** – Country Road Green, Highway Red
- **CT_YELLOW** – Country Road Yellow before returning

State transition sequence:

```
HW_GREEN
    │
(vehicle detected)
    ▼
HW_YELLOW
    │
    ▼
CT_GREEN
    │
(vehicle leaves or timeout)
    ▼
CT_YELLOW
    │
    ▼
HW_GREEN
```

---

## Project Structure

```
TrafficLightController/
│
├── traffic_light_controller.v
├── traffic_light_tb.v
└── README.md
```

---

## Requirements

- Icarus Verilog
- GTKWave (optional for waveform viewing)

---

## Compilation

Compile the design:

```bash
iverilog -o traffic_sim traffic_light_controller.v traffic_light_tb.v
```

Run the simulation:

```bash
vvp traffic_sim
```

---

## Waveform Generation

Open it using GTKWave:

```bash
gtkwave traffic.vcd
```

---

## Outputs

The controller drives two traffic signals:

### Highway Signal

| Code | Light |
|------|-------|
|100|Red|
|010|Yellow|
|001|Green|

### Country Road Signal

| Code | Light |
|------|-------|
|100|Red|
|010|Yellow|
|001|Green|

---

## Technologies Used

- Verilog HDL
- Finite State Machines (FSM)
- Digital Logic Design
- Icarus Verilog
- GTKWave

---

## Learning Outcomes

- FSM design using Verilog
- Timer-based sequential logic
- State transition implementation
- Traffic signal control logic
- Digital circuit simulation
- Testbench development and verification

---
