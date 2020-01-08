function [x_ob,y_ob,r_ob] = obstacle(obstacles)
%This code randomly generates obstacles of a certain radius at a random
%location
    for i = 1:obstacles
        %x,y range in the map where obstacles should be randomly generated
        x_ob(i) = randi([15 180]);
        y_ob(i) = randi([0 200]);
        r_ob(i) = randi([7 12]);    %random radius between 7 and 12

        
    end
    %Check to make sure that an obstacle does not initially intersect
    %all other obstacles. If it does, regenerate the obstacle.
    for i = 1:obstacles
        for k = 1:obstacles
            if k == i
                continue
            else
                while sqrt((x_ob(k)-x_ob(i))^2+(y_ob(k)-y_ob(i))^2)<(r_ob(k)+r_ob(i)+15)
                    x_ob(k) = randi([15 180]);
                    y_ob(k) = randi([0 200]);
                    r_ob(k) = randi([7 12]);
                end
            end
        end
    end
end