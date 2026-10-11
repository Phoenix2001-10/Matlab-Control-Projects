# Simplified Inverted Pendulum Stabilization with PD Control

## Goal

Stabilize an inverted pendulum near its upright equilibrium using a simple PD controller.

## Linearized dynamics

For a torque-driven pendulum near the upright position, a simplified linearized equation is

`m*l^2*theta'' - m*g*l*theta = tau`

The negative stiffness term makes the upright equilibrium unstable.

The transfer function is

`Theta(s)/Tau(s) = 1 / (m*l^2*s^2 - m*g*l)`

## What the MATLAB script does

- Builds an unstable inverted-pendulum transfer function.
- Displays the unstable open-loop poles.
- Shows the diverging open-loop step response.
- Applies a PD controller.
- Shows stabilized small-angle tracking.
- Displays a root locus for the controlled loop.

## Run

```matlab
inverted_pendulum_pd
```

## Good discussion points

- The upright equilibrium is naturally unstable.
- Proportional feedback supplies an effective restoring action.
- Derivative feedback adds damping.
- This model is deliberately simplified: a cart-pole system is a more complete and more difficult inverted-pendulum project.

## Extensions

Create a state-space model, design an LQR controller, add sensor noise, or upgrade the model to a cart-pole system.
