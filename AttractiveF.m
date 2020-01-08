function F_att = AttractiveF(coord,goal,zeta)
    %Calculate attractive force between an object and its goal
    for i = 1:size(coord,1)
      F_att(1) = -zeta*(coord(i,1)-goal(1,1));
      F_att(2) = -zeta*(coord(i,2)-goal(1,2));
    end
end