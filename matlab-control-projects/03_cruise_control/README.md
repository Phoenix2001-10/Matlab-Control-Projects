# Vehicle Cruise Control with PI Control

## Goal

Maintain a desired vehicle speed even when an external force, such as an uphill road load, disturbs the vehicle.

## Dynamics

A simple longitudinal model is

`m*dv/dt + b*v = u + d`

where `m` is vehicle mass, `b` is an effective drag/friction coefficient, `u` is traction force, and `d` is an external disturbance.

The force-to-speed plant is

`V(s)/F(s) = 1 / (m*s + b)`

## What the MATLAB script does

- Models the vehicle as a first-order plant.
- Shows the open-loop response to a force input.
- Designs a PI speed controller.
- Tracks a 20 m/s speed target.
- Applies a -500 N disturbance after 30 seconds.
- Demonstrates how integral action restores the target speed.

## Run

```matlab
cruise_control_pi
```

## Good discussion points

- The proportional gain changes how aggressively the vehicle reacts to speed error.
- Integral control rejects constant disturbances and removes steady-state error.
- Real cruise-control systems have throttle/brake constraints, engine dynamics, gear changes, changing road grade, and aerodynamic drag proportional approximately to speed squared.

## Extensions

Use quadratic aerodynamic drag in a nonlinear simulation, add actuator saturation, or simulate different vehicle masses.
