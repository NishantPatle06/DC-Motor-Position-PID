# DC Motor Position Control PID Analysis

This project demonstrates the mathematical modeling and feedback control of a DC motor using Proportional-Integral-Derivative (PID) control. 

This repository fulfills the core requirements for Control Systems Engineering by analyzing overshoot, settling time, rise time, and steady-state error using MATLAB and Simulink.

## Repository Contents
- `dc_motor_pid.m`: A MATLAB script that defines the mathematical transfer function of the motor, applies a PID controller, and plots the closed-loop system response.

## 1. MATLAB Mathematical Analysis
To run the mathematical simulation:
1. Open MATLAB (or [MATLAB Online](https://matlab.mathworks.com/) if you don't have it installed).
2. Open `dc_motor_pid.m`.
3. Click **Run**.
4. The script will output the exact Transfer Function and display a graph of the step response. You can tweak the $K_p, K_i, K_d$ values in the code to see how they affect the system stability!

## 2. How to Build the Simulink Model
To demonstrate practical control systems knowledge, you can recreate this mathematical model visually in Simulink.

1. Open MATLAB and click the **Simulink** button in the Home tab.
2. Create a **Blank Model**.
3. Open the **Library Browser** and drag the following blocks into your workspace:
   - **Step** (Source): Represents your target position command.
   - **Sum** (Math Operations): Double-click and change the signs to `|+-` to create a negative feedback loop.
   - **PID Controller** (Continuous): Double-click to set your P, I, and D values.
   - **Transfer Fcn** (Continuous): This is the motor. Double click and set the Numerator to `[0.01]` and Denominator to `[0.005 0.06 0.1001 0]`. *(This matches the complex math derived in the .m file!)*
   - **Scope** (Sinks): To view the output graph.
4. **Wire them together:**
   `Step` -> `Sum (+)` 
   `Sum` -> `PID Controller` -> `Transfer Fcn` -> `Scope`
   *Wire the output of the Transfer Fcn back to the `(-)` input of the Sum block to close the loop!*
5. Click **Run** in Simulink and double-click the Scope block to watch the motor smoothly curve into its target position!
