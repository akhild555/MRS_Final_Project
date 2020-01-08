function [f_center, form_coord] = formation(x,y,robots)
    %This code caluclates the formation center and the robots goal
    %locations in the formation
    
    x_coord = mean(x);
    y_coord = mean(y);
    
    %Caluclate equidistant points based on number of robots
    points = linspace(-pi,pi,robots+1);
    
    %Calculate radius of formation depending on the number of robots. The 
    %factor 5 was chosen with trial and error but it can be changed.
    r = robots*5;
    
    %Calculate formation goal locations for each robot
    xi = r*cos(points)+x_coord;
    yi = r*sin(points)+y_coord;
    xi(end) = [];
    yi(end) = [];
    f_center = [x_coord y_coord];
    form_coord = [xi' yi'];
    
end
