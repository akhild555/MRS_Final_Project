function steps = MRS_goal(robots,obstacles,parameters)
%% Initialize parameters, robots, obstacles, goal

    %Get potential field parameters
    e_form = parameters.e_form;
    f_goal = parameters.f_goal;
    zeta_robot = parameters.zeta_robot;
    zeta_formation = parameters.zeta_formation;
    rho = parameters.rho;
    rho_rob = parameters.rho_rob;
    rho_gl = parameters.rho_gl;
    eta = parameters.eta;
    eta_rob = parameters.eta_rob;
    eta_gl = parameters.eta_gl;
    
    %Initialize random robots locations, robot radius will be 3.
    [x,y,r] = robot(robots);
    
    %Obtain formation coordinates for robots
    [f_center, form_coord] = formation(x,y,robots);
    
    %Initialize random obstacle location,size
    [x_ob,y_ob,r_ob] = obstacle(obstacles);
    
    %Initialize random goal location. Goal radius will be 2.
    x_goal = randi([10 190]);
    y_goal = randi([250 300]);
    r_goal = 2;

    %Store center positions for robot, obstacles, goal
    coord = [x' y'];
    obst = [x_ob' y_ob'];
    gl = [x_goal y_goal];

    %Draw circles for robot, obstacle, goal
    [x1,y1] = draw_circle(coord(:,1),coord(:,2),r);
    [xob,yob] = draw_circle(obst(:,1),obst(:,2),r_ob);
    [xg,yg] = draw_circle(gl(1),gl(2),r_goal);
    
    %Store points for robot, obstacle, goal circles in structure
    map.robotx = x1;
    map.roboty = y1;
    map.obstaclex = xob;
    map.obstacley = yob;
    map.goalx = xg;
    map.goaly = yg;    
    
%% Plot robots, obstacles, goal

    %Plot map of robots, obstacles, goals. Store robot and obstacle
    %position values in structures so they can be updated later in the
    %plot.
    
    for j = 1:robots
        hold on
        plot_g = plot(map.goalx{1},map.goaly{1},'g');
        plot_r = plot(map.robotx{j},map.roboty{j},'k');
        robot_struct.r(j) = plot_r;
    end

    for j = 1:obstacles
        hold on
        plot_o = plot(map.obstaclex{j},map.obstacley{j},'r');
        obstacle_struct.o(j) = plot_o;
        hold off
    end
    
    
    %Set plot axes and window size
    xlim([-50 250]);
    ylim([-200 390]);
    set(gcf, 'Position',  [45, 45, 600, 950])
    

%% Potential Field Planner
    
    %Initialize steps and vectors
    steps = 0;
    F_rep = zeros(obstacles,2);
    F_rep_rob = zeros(robots,2);
    form_goal = e_form*ones(robots,1)';
    
    A = ((abs(norm(f_center)-norm(gl)) > f_goal)); %Check if formation is at goal
    B = sum(abs(vecnorm(coord')-vecnorm(form_coord')) > form_goal); %Check if all robots are at their formation goal locations
    
    while A + B ~= 0
        
        for i = 1:robots          
            %If robots are not at their formation goal coordinates, move
            %them there.
            if sum(abs(vecnorm(coord')-vecnorm(form_coord')) > form_goal) ~= 0
                % Calculate attractive force to push robot to formation
                % goal location
                F_att = AttractiveF(coord(i,:),form_coord(i,:),zeta_robot);
                
                %For all obstacles in the map, calculate repulsive force
                %between robot and obstacle
                for k = 1:obstacles
                    F_rep(k,:) = RepulsiveF(coord(i,:),obst(k,:),robot_struct.r(i).XData,robot_struct.r(i).YData,obstacle_struct.o(k).XData,obstacle_struct.o(k).YData,rho,eta);                                               
                end
                
                %For all other robots m in the map, calculate repulsive
                %force between robot m and robot i
                for m = 1:robots
                    if m == i %don't calculate a robots repulsive force against itself
                        continue
                    else
                        F_rep_rob(m,:) = RepulsiveF(coord(i,:),coord(m,:),robot_struct.r(i).XData,robot_struct.r(i).YData,robot_struct.r(m).XData,robot_struct.r(m).YData,rho_rob,eta_rob);                                               
                    end                
                end          
                
                %Calculate repulsive force on robots from the goal
                F_rep_goal = RepulsiveF(coord(i,:),gl,robot_struct.r(i).XData,robot_struct.r(i).YData,plot_g.XData,plot_g.YData,rho_gl,eta_gl);                                               

                
                F_rep_sum = sum(F_rep,1); %Sum repulsive forces from obstacles
                F_rep_rob_sum = sum(F_rep_rob,1); %Sum repulsive forces from other robots
                F_totx = (F_att(1))+F_rep_sum(1)+F_rep_rob_sum(1)+F_rep_goal(1); %Add all forces in x
                F_toty = (F_att(2))+F_rep_sum(2)+F_rep_rob_sum(2)+F_rep_goal(2); %Add all forces in y
                
                robot_struct.r(i).XData = robot_struct.r(i).XData+F_totx; %Update robot i's x direction by moving the circle
                robot_struct.r(i).YData = robot_struct.r(i).YData+F_toty; %Update robot i's y direction by moving the circle
                pause(0.001);
                coord(i,1) = mean(robot_struct.r(i).XData-r(i)*cos(linspace(0,2*pi,100))); %Update robot i's center point x
                coord(i,2) = mean(robot_struct.r(i).YData-r(i)*sin(linspace(0,2*pi,100))); %Update robot i's center point y
            end           
        end
        
        %Move obstacles in the map        
        [obst,obstacle_struct] = move_obstacle(obst,obstacles,obstacle_struct,r_ob);
    
        %Move formation center towards green goal
        F_att_form = AttractiveF(f_center,gl(:,:),zeta_formation); %Attractive force between formation center and green goal
        f_center = f_center+F_att_form; %Move formation center towards goal
        [f_center, form_coord] = formation(f_center(1),f_center(2),robots); %Update location of formation goal locations for robots
        
        steps = steps+1;
        
        A = ((abs(norm(f_center)-norm(gl)) > f_goal)); %Update A to see if the formation center is within f_goal
        B = sum(abs(vecnorm(coord')-vecnorm(form_coord')) > form_goal); %Update B to see if all robots are within form_goal
    end
end