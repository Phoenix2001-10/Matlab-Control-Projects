# Mass-Spring-Damper Position Control

## Goal

Model a classical mechanical system and use a PID controller to make the mass follow a desired position.

## Dynamics

The governing equation is

`m*x'' + c*x' + k*x = F`

where `m` is mass, `c` is damping, `k` is spring stiffness, `F` is applied force, and `x` is displacement.

The transfer function from force to displacement is

`X(s)/F(s) = 1 / (m*s^2 + c*s + k)`

## What the MATLAB script does

- Creates the plant transfer function.
- Displays the plant poles.
- Plots the open-loop step response.
- Adds a PID controller.
- Plots the closed-loop position response.
- Calculates rise time, settling time, overshoot, and other `stepinfo` metrics.
- Saves generated figures to `figures/`.

## Run

```matlab
mass_spring_damper_pid
```

## Good discussion points

- Increasing damping reduces oscillation.
- Increasing stiffness generally increases the natural frequency.
- The integral term removes steady-state tracking error.
- Too much proportional or derivative action can produce undesirable transients or control effort.

## Ideas to extend it

Try different values of `m`, `c`, and `k`, compare P/PD/PID controllers, or add actuator saturation in Simulink.
