%%
%{
This code uses potential fields as a path planning tool for a multi-robot 
system to reach a goal. There are three key constraints. First, all robots 
in the system must avoid each other as well as any number of dynamic 
obstacles in the map. Second, the robots need to stay in formation if 
possible. Finally, for the task to be considered complete, the robots 
will need to "capture" the static goal by surrounding it
%}

% Declare potential field parameters

parameters.e_form = 1; %Epsilon for a robot and its formation goal location
parameters.f_goal = 1; %Epsilon for the formation center and green goal
parameters.zeta_robot = .025; %Attractive field strength between robot and its formation goal location
parameters.zeta_formation = .003; %Attractive field strength between formation center and green goal
parameters.rho = 75; %Minimum distance of influence of obstacles
parameters.rho_rob = 20; %Minimum distance of influence of robots
parameters.rho_gl = 15; %Miniumum distance of influence of goal
parameters.eta = 20000; %Repulsive field strength of obstacle
parameters.eta_rob = 1500; %Repulsive field strength of robots
parameters.eta_gl = 1500; %Repulsive field strength of goal


%Run potential field planner. This project is designed around formations so
%3 is the minimum number of robots. Any number of obstacles is possible.
%Change number of robots and obstacles to run different tests.

robots = 5; %Number of robots
obstacles = 7; %Number of obstacles

if robots < 3
    fprintf('Please input number of robots greater than or equal to 3 \n')
    return
else
    steps = MRS_goal(robots, obstacles, parameters)
end
