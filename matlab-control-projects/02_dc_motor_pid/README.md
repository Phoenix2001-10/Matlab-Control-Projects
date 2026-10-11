# DC Motor Speed Control with PID

## Goal

Model an armature-controlled DC motor and regulate its angular speed with feedback control.

## Model

The electrical dynamics are

`V = L*di/dt + R*i + K*omega`

and the mechanical dynamics are

`J*d(omega)/dt + b*omega = K*i`

Combining them gives the speed transfer function used in the MATLAB script.

## What the project demonstrates

- Electromechanical modeling.
- Transfer functions and poles.
- Open-loop motor response.
- P, PI, and PID controller comparison.
- Transient-performance measurement using `stepinfo`.

## Run

```matlab
dc_motor_pid
```

## Good discussion points

- A P controller improves response but can leave tracking error.
- Integral action helps eliminate steady-state error.
- Derivative action can improve damping and reduce overshoot.
- Real motors also have voltage/current limits, nonlinear friction, and load-torque disturbances.

## Extensions

Add a load torque disturbance, compare manual gains with `pidtune`, or build the same motor using Simulink blocks.
