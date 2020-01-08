function [obst,obstacle_struct] = move_obstacle(obst,obstacles,obstacle_struct,r_ob)
%This function calculates how each obstacle in the map should move. The
%direction of movement was determined so as to get in the robots' way to
%see how they would react.

    for k = 1:obstacles
        %Half the robots should move in one direction and the other half
        %will move in the opposite direction. ALl robots will exit the map.
        if mod(k,2) == 0
            %move robot and update plot data
            obstacle_struct.o(k).XData = obstacle_struct.o(k).XData+.25;  
            obstacle_struct.o(k).YData = obstacle_struct.o(k).YData+.25;
        else
            %move robot and update plot data
            obstacle_struct.o(k).XData = obstacle_struct.o(k).XData-.25;  
            obstacle_struct.o(k).YData = obstacle_struct.o(k).YData-.25;

        end
        %Recalculate obstacle centers after motion
        obst(k,1) = mean(obstacle_struct.o(k).XData-r_ob(k)*cos(linspace(0,2*pi,100)));
        obst(k,2) = mean(obstacle_struct.o(k).YData-r_ob(k)*sin(linspace(0,2*pi,100)));
    end

end
