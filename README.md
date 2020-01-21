# Multi-Robot Goal-Seeking in a Dynamic Map Using Potential Fields

  Multi-robot systems are an increasingly popular area of research. They have great potential in a wide variety of applications and they will be essential to make significant strides in robotics. One of the key areas of research within this field is the study of motion and
path planning techniques for a system of robots. While path planning for a single robot
is no trivial task, planning for multiple robots in a system is particularly challenging since
the configuration space grows exponentially with the number of robots. Of course, the
problem becomes even harder once you include dynamic obstacles in the workspace.

This project explores how potential fields can be used as a path planning tool for a multirobot system to reach a goal. There are three key constraints. First, all robots in the system must avoid each other as well as any number of dynamic obstacles in the map. Second, the
robots need to stay in formation if possible. Finally, for the task to be considered complete,
the robots will need to "capture" the static goal by surrounding it.

To run code:

1) Open PF_Planner.m
2) Set desired number of robots and obstacles. Minimum number of robots is 3 since this project
   is designed around formations.
3) You can also play around with the parameters or leave them be.
3) Run code.
