% DC Motor Position Control PID Analysis
% This script models a DC motor and applies a PID controller for position control.

%% 1. Motor Physical Parameters
% (Typical values for a small DC motor)
J = 0.01;   % Moment of inertia of the rotor (kg.m^2)
b = 0.1;    % Motor viscous friction constant (N.m.s)
K = 0.01;   % Electromotive force constant / Motor torque constant (V/rad/s or N.m/A)
R = 1.0;    % Electric resistance (Ohm)
L = 0.5;    % Electric inductance (H)

%% 2. Transfer Function Derivation
% The transfer function from input voltage (V) to output angular position (theta)
s = tf('s');
P_motor = K / (s * ((J*s + b)*(L*s + R) + K^2));

disp('Open-Loop Transfer Function (Voltage to Position):');
P_motor

%% 3. PID Controller Design
% Tune these parameters to achieve desired rise time, overshoot, and settling time.
Kp = 100;   % Proportional gain
Ki = 1;     % Integral gain
Kd = 10;    % Derivative gain

C = pid(Kp, Ki, Kd);

%% 4. Closed-Loop System
% Create the closed-loop system with negative feedback
sys_cl = feedback(C * P_motor, 1);

disp('Closed-Loop Transfer Function:');
sys_cl

%% 5. System Response Analysis
figure('Name', 'DC Motor PID Control Analysis', 'NumberTitle', 'off');

% Plot Step Response
step(sys_cl, 0:0.01:5);
title('Step Response with PID Controller');
xlabel('Time (seconds)');
ylabel('Angular Position (Radians)');
grid on;

% Display Step Response Characteristics
step_info = stepinfo(sys_cl);
disp('Step Response Characteristics:');
disp(step_info);
