function [x,y,r] = robot(robots)
%This code randomly generates robots of a radius 3 at a random
%location
    for i = 1:robots
            %x,y range in the map where robots should be randomly generated
            x(i) = randi([10 190]);
            y(i) = randi([-180 -160]);
            r(i) = 3;   %radius of all robots should be 3

    end   
    
    %Check to make sure that a robot does not initially intersect
    %all other robots. If it does, regenerate the robot.
    for i = 1:robots
        for k = 1:robots
            if k == i
                continue
            else
                while sqrt((x(k)-x(i))^2+(y(k)-y(i))^2)<(r(k)+r(i)+10)
                    x(k) = randi([10 190]);
                    y(k) = randi([-180 -160]);
                    r(k) = 3;
                end
            end
        end
    end
    
end