%% Spherical pendulum
clear, clc, clf;

% fontsize for plots
fs = 16;

% Parameters
g = -9.8;
L = 6;
time = [0 10];

% Initial conditions
y0 = [pi/2, -1, pi/1.5, 0.5]';

% Numerical integration
options = odeset('RelTol', 1e-11, 'AbsTol', 1e-11);
[t, y] = ode45(@(t,y) spherical(y, g, L), time, y0, options);

% convert to Cartesian coords
X = L*cos(y(:,1)).*sin(y(:,3));
Y = L*sin(y(:,1)).*sin(y(:,3));
Z = L*cos(y(:,3));

% Plot this pup
%figure (1)
%plot3(X, Y, Z)
%grid on

% for i = 1:10
%     plot(X(1:i), Y(1:i), '-o')
%     pause(0.1)
% end

for i = 1:100
    
    % Plot the trajectory
    plot3(X(1:i), Y(1:i), Z(1:i), '-',...
        X(i), Y(i), Z(i), 'or', 'MarkerFaceColor', 'r')
    hold on

    % Plot the origin
    plot3(0,0,0,'ok', 'MarkerFaceColor', 'k')
    hold on
    
    % Plot the string
    P1 = [0,0,0];
    P2 = [X(i), Y(i), Z(i)];
    pts = [P1; P2];
    plot3(pts(:,1), pts(:,2), pts(:,3),'-k')
    hold on

    % Plot the planar projections
    plot3(X(1:i), Y(1:i), 0*Z(1:i) - L, '--')

    % Stop plotting
    hold off
    
    % Plot formatting
    grid on
    axis equal
    xlim([-L L])
    xlabel('$x$','Interpreter','latex','FontSize',fs)
    ylim([-L L])
    ylabel('$y$','Interpreter','latex','FontSize',fs)
    zlim([-L L])
    zlabel('$z$','Interpreter','latex','FontSize',fs)
    title('The Spherical Pendulum','Interpreter','latex','FontSize',fs)
    subtitle({"String Length, $L=$ " + L,"$(\theta_0, \ \phi_0, \ \dot{\theta}_0, \ \dot{\phi}_0) = ($"...
        + y0(1) + ", " + y0(3) + ", " + y0(2) + " ," + y0(4) + ")"}, ...
        'Interpreter','latex','FontSize',fs-4)

    pause(0.001)
end


%% odes for sphorical pendulo
% y = [ theta,  theta', phi, phi' ]
% dydt = [ theta',  theta'', phi', phi'' ]

function dydt = spherical(y, g, L)

    % initialize the RHS
    dydt = zeros(4,1);
    
    % the ODE(s)
    dydt(1) = y(2);               % theta' = v
    dydt(2) = -2*cot(y(3)).*y(2).*y(4); % v' = -2*cot(phi)*theta'*phi'
    dydt(3) = y(4);               % phi' = w
    dydt(4) = sin(y(3)).*cos(y(3)).*(y(2)).^2 - (g/L)*sin(y(3));

end


