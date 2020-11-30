%%
%initializing inverted five-bar robot

%%
function robot = init_5brobot()

    %dimensions in mm
    robot.R = 150;
    robot.r = 20;
    robot.L1 = 250;
    robot.L2 = 250;
    
    %angle in rad
    robot.phi = [0,pi];

end