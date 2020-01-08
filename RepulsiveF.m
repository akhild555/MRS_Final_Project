function F_rep = RepulsiveF(coord,obst,R_XData,R_YData,O_XData,O_YData,rho,eta)
%This code calculates the repulsive force between objects based on the 
%location of their centers.
    for i = 1:size(obst,1)
        distx = coord(i,1)-obst(i,1);
        disty = coord(i,2)-obst(i,2);
        distr = sqrt((distx^2)+(disty^2));
        if distr < rho
            P = (coord(i,:)-obst(i,:))/norm((coord(i,:)-obst(i,:)));
            F_rep = eta*(((1/distr)-(1/rho))*(1/(distr)^2))*P;
        else
            %If obstacle is further away than the region of influence,
            %repulsive force is zero.
            F_rep = [0 0];
        end
    end     
end

