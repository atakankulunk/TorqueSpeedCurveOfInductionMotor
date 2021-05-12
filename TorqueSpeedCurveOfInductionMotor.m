f=60;                       % frequence
r1 = 0.03957;               % Stator resistance
x1 = 2*pi*f*0.000389;       % Stator reactance
r2 = 0.02215;               % Rotor resistance
x2 = 2*pi*f*0.000389;       % Rotor reactance
xm = 2*pi*f*0.01664;        % Magnetization branch reactance
v_phase = 460 / sqrt(3);    % Phase voltage
n_sync = 1800;              % Synchronous speed (r/min)
w_sync = 188.5;             % Synchronous speed (rad/s)

v_th = v_phase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((j*xm) * (r1 + j*x1)) / (r1 + j*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

s = (0:1:50) / 50;           % Slip
s(1) = 0.001;
nm = (1 - s) * n_sync;       % Mechanical speed
% Calculate torque for original rotor resistance
for ii = 1:51
   t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
end
% Calculate torque for doubled rotor resistance
for ii = 1:51
   t_ind2(ii) = (3 * v_th^2 * (2*r2) / s(ii)) / ...
            (w_sync * ((r_th + (2*r2)/s(ii))^2 + (x_th + x2)^2) );
end
% Plot the torque-speed curve
plot(nm,t_ind1,'Color','k','LineWidth',2.0);
hold on;
plot(nm,t_ind2,'Color','k','LineWidth',2.0,'LineStyle','-.');
xlabel('\itn_{m}','Fontweight','Bold');
ylabel('\tau_{ind}','Fontweight','Bold');
title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
grid on;
hold off;