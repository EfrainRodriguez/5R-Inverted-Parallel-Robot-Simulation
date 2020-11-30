%%draw robot

%robot:
%              R: 
%              r: 
%             L1: 
%             L2: 
%            phi: []
%     rotational: []
%         linear: 
%              A: [2×3 double]
%              B: [2×3 double]
%              C: [2×3 double]

%%
function draw_5brobot(robot)

    %-------fixed pivots
    for i = 1: 2
        patch([robot.A(i,1)-20, robot.A(i,1)+20, robot.A(i,1)], [0,0,0], [robot.A(i,3)-50, robot.A(i,3)-50, robot.A(i,3)], 'c');
        hold on
    end
    %-------joints
    for i = 1: 2
        plot3(robot.A(i,1), robot.A(i,2), robot.A(i,3), 'ob');% A
        hold on
        plot3(robot.B(i,1), robot.B(i,2), robot.B(i,3), 'ob');% B
        hold on
        plot3(robot.C(i,1), robot.C(i,2), robot.C(i,3), 'ob');% C
        hold on
    end
    %-------links
    for i = 1: 2
        plot3([robot.A(i,1),robot.B(i,1)], [robot.A(i,2),robot.B(i,2)], [robot.A(i,3),robot.B(i,3)], '-k');% L1
        plot3([robot.B(i,1),robot.C(i,1)], [robot.B(i,2),robot.C(i,2)], [robot.B(i,3),robot.C(i,3)], '-k');% L2
        hold on
    end
    plot3([robot.C(1,1),robot.C(2,1)], [robot.C(1,2),robot.C(2,2)], [robot.C(1,3),robot.C(2,3)], '-k');% end-effector pivot
    
    %-------bed
    bed_x = [-110, -110, 110, 110];
    bed_y = [robot.linear, robot.linear + 220, robot.linear + 220, robot.linear];
    bed_z = [0,0,0,0];
    patch(bed_x, bed_y, bed_z, 'r');
    
    %axis tight
    view(45,20);
    axis([-300 300 -300 300 -200 400]);
end