% Run this script in MATLAB to automatically generate the Simulink .slx file!

modelName = 'dc_motor_pid_model';

% Close it if it's already open
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end

% Create and open a new Simulink model
new_system(modelName);
open_system(modelName);

% Add the blocks
add_block('simulink/Sources/Step', [modelName, '/Target_Position'], 'Position', [50, 100, 80, 130]);
add_block('simulink/Math Operations/Sum', [modelName, '/Error_Sum'], 'Inputs', '|+ -', 'Position', [150, 100, 170, 130]);
add_block('simulink/Continuous/PID Controller', [modelName, '/PID_Controller'], 'P', '100', 'I', '1', 'D', '10', 'Position', [250, 100, 290, 130]);
add_block('simulink/Continuous/Transfer Fcn', [modelName, '/DC_Motor'], 'Numerator', '[0.01]', 'Denominator', '[0.005 0.06 0.1001 0]', 'Position', [370, 95, 450, 135]);
add_block('simulink/Sinks/Scope', [modelName, '/Position_Output'], 'Position', [550, 100, 580, 130]);

% Connect the blocks
add_line(modelName, 'Target_Position/1', 'Error_Sum/1', 'autorouting', 'on');
add_line(modelName, 'Error_Sum/1', 'PID_Controller/1', 'autorouting', 'on');
add_line(modelName, 'PID_Controller/1', 'DC_Motor/1', 'autorouting', 'on');
add_line(modelName, 'DC_Motor/1', 'Position_Output/1', 'autorouting', 'on');

% Add the negative feedback loop from motor output back to the Sum block
add_line(modelName, 'DC_Motor/1', 'Error_Sum/2', 'autorouting', 'on');

% Save the model
save_system(modelName);
disp('Successfully generated dc_motor_pid_model.slx!');
