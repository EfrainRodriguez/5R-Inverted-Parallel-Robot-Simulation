%%
% inverse kinematics of the hybrid parallel-cartesian robot

%%
function robot = invk_5brobot(position)

    %initializing robot
    robot = init_5brobot();

    %points
    Px = position(1);
    Py = position(2);
    Pz = position(3);
    
    %fixed pivots
    for i = 1: 2
        A(i,:) = [robot.R * cos(robot.phi(i)), 0, 0];
    end
    
    %end-effector pivot
    for i = 1: 2
        C(i,:) = [Px + robot.r * cos(robot.phi(i)), 0, Pz];
    end
    
    %imaginary line h
    for i = 1: 2
        h(i) = sqrt((C(i,1) - A(i,1))^2 + (C(i,3) - A(i,3))^2);
    end
    
    %solving for omega
    for i = 1: 2
        cos_omega = (h(i)^2 - robot.L1^2 - robot.L2^2) / (2 * robot.L1 * robot.L2);
        sin_omega = sqrt(1 - cos_omega);
        omega(i) = atan2(sin_omega, cos_omega);
    end
    
    %soliving for theta - actuated joints
    for i =1: 2
        beta(i) = atan2(robot.L2 * sin(omega(i)), robot.L1 + robot.L2 * cos(omega(i)));
        alpha(i) = atan2(C(i,3) - A(i,3), C(i,1) - A(i,1));     
    end    
    theta(1) = omega(1) + alpha(1) - beta(1);
    theta(2) = alpha(2) + beta(2) - omega(2);
    
    %elbow joint position
    B(1,:) = [A(1,1) + robot.L1 * cos(alpha(1) - beta(1)), A(1,2), A(1,3) + robot.L1 * sin(alpha(1) - beta(1))];
    B(2,:) = [A(2,1) + robot.L1 * cos(alpha(2) + beta(2)), A(2,2), A(2,3) + robot.L1 * sin(alpha(2) + beta(2))];
    
    %joint positions
    robot.rotational = theta; %rotational joints
    robot.linear = -Py; %linear joint
    robot.A = A;
    robot.B = B;
    robot.C = C;

end