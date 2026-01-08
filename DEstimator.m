%import data
px=vx
py=vy
ax=ax
ay=ay
%find speed
s=(px.^2+py.^2).^(1/2)
%find direction of velocity. Following the assumption of the
%model, use this as theta
theta=(atan(py./px))
%resize data to fit acceleration size
theta2=(theta(2:length(theta)-1))
s2=s(2:length(s)-1)
px2=px(2:length(px)-1)
py2=py(2:length(py)-1)

%find ds/dt
dsdt=(px2.*ax+py2.*ay)./s2

%ds/dt=-sin(theta)-Ds^2 so D=(ds/dt+sin(theta))/-s^2
Dvec=(dsdt+sin(theta2))./(-s2.^2)
Davg=sum(Dvec)/length(Dvec)
Derror=max([abs(Davg-max(Dvec)),abs(Davg-min(Dvec))])
%use model
y0=[theta2(1);s2(1)];
tspan=[0 20];
f=@(t,y) [(y(2)^2-cos(y(1)))/y(2);-sin(y(1))-Davg*y(2)^2];
[t,y]=ode45(f,tspan,y0);
theta1=(y(:,1));
s1=y(:,2);
figure
subplot(1,2,1)
plot(theta1,s1)
xlabel("Theta (Radians)")
ylabel("Speed")
fontsize(18,"points")

%compare with plot of data
figure
subplot(1,2,2)
plot(theta2,s2,Color="b",LineStyle=":")
xlabel("Theta (Radians)")
ylabel("Speed (m/s)")
fontsize(18,"points")

%smooth data to make any trend more visible
px3 = smoothdata(px2,'sgolay',13);
py3 = smoothdata(py2,'sgolay',13);
ax3 = smoothdata(ax,'sgolay',13);
ay3 = smoothdata(ay,'sgolay',13);
s3=(px3.^2+py3.^2).^(1/2);
a3 = (px3.*ax + py3.*ay)./s3;
theta3=(atan(py3./px3));
hold on
plot(theta3,s3,Color="r",LineStyle="-")
xlabel("Theta (Radians)")
ylabel("Speed (m/s)")
fontsize(18,"points")


