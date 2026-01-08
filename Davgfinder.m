D1=-0.0127;
D2=0.0609;
D3=0.0266;
Derr1=0.6774;
Derr2=0.4606;
Derr3=0.7428;
Davg=(D1+D2+D3)/3
Derravg=(Derr1+Derr2+Derr2)/3

s1=5.5831;
theta1=-0.1083;
s2=4.9892;
theta2=-0.2402;
s3=5.5831;
theta3=-0.1083;
savg=(s1+s2+s3)/3
thetaavg=(theta1+theta2+theta3)/3

y0=[thetaavg;savg];
tspan=[0 20];
f=@(t,y) [(y(2)^2-cos(y(1)))/y(2);-sin(y(1))-Davg*y(2)^2];
[t,y]=ode45(f,tspan,y0);
theta1=(y(:,1));
s1=y(:,2);
figure
plot(theta1,s1)
xlabel("Theta (Radians)")
ylabel("Speed")

fontsize(18,"points")
