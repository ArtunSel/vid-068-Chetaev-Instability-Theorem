%%
clear all,close all,clc;
syms x1 x2
x1_dot = -x1 + x2^6;        x2_dot = x2^3 + x1^6;
V=(x1+x2)^2+x2^2;
gradV = gradient(V, [x1, x2]);
V_dot = gradV(1) * x1_dot + gradV(2) * x2_dot;
%=======================================================================
% Convert character array to string for easier manipulation
% Original character array
charArray = char(V_dot);
% Convert character array to string for easier manipulation
str = string(charArray);
% Regular expression to find "x{number}^{number}" and enclose it in parentheses
str = regexprep(str, '(x\d+\^\d+)', '($1)');
% Replace "*" and "^" with ".*" and ".^" respectively
str = replace(str, '*', '.*');
str = replace(str, '^', '.^');
% Convert back to character array if needed
V_dot_str = char(str);
V_dot_str=['Vdot=',V_dot_str,';'];
clearvars -except V_dot_str
%=======================================================================
% Define the range for x1 and x2
x1_min = -.1;    x1_max = .1;       x2_min = -.1;    x2_max = .1;
% Generate mesh grid for the ranges of x1 and x2
% [x1, x2] = meshgrid(x1_min:0.05:x1_max, x2_min:0.05:x2_max);
[x1, x2] = meshgrid(linspace(x1_min,x1_max,200), linspace(x2_min,x2_max,200));
eval(V_dot_str);
x1 = x1(:);x2 = x2(:);Vdot = Vdot(:);% Flatten arrays for plotting
fig_1=figure(1); fig_1.Color=[1,1,1];
plot(x1(Vdot > 0), x2(Vdot > 0), 'r.'); hold on;% Plot points where V(x1, x2) is positive in red
plot(x1(Vdot < 0), x2(Vdot < 0), 'b.'); hold on;% Plot points where V(x1, x2) is negative in blue
xlabel('x1');   ylabel('x2');
title('2D Plot of Vdot(x1, x2) with Color Coding');
legend('Vdot > 0', 'Vdot < 0');
grid on; axis equal;