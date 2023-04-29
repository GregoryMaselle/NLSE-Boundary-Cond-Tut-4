% Tutorial 4
% NLS with boundary conditions
%
%% space variables
a = 0; % interval is 0 to 20
b = 20;
N = 100; % the number of sub-intervals.
j = 0:N;
h = (b-a)/N; % the space step size
x = a + j*h; % the array of x points.
%htest = 40/N;
%xtest = -20 + j*htest;
%% time variables
M = 100; % the number of time sub-intervals
k = 0:M;
t = 0.00009; % some arbitrary time step value
T = k*t;
n = 1; %A counter 
%% Set up matrix for first time step and final time steps.
main = (-4*1i*t/h^2)*ones(1,N-2);
super = (2*1i*t/h^2)*ones(1,N-3);
sub = (2*1i*t/h^2)*ones(1,N-3);
genericB = diag(main,0) + diag(sub,-1) + diag(super,1);
initialB = 0.5*genericB;
%% Set up initial conditions
A = 1; %arbitrary variable to set up initial condition (A =1, 4 , 8, ... ) 
u = A*sech(A*(x-10)).*exp(-2*1i*(x-10)); % initial condition, t=0, first column
u = u';
%% Set up the while loop and account for first iteration BCs.
s = 1i*t/h^2;
u(1,n+1) = u(1,1) + s*(u(end-1,n) - 2*u(1,n) + u(2,n)) + 2*1i*t*(abs(u(1,n))).^2.*(u(1,n));
u(2:N-1,n+1) = u(2:N-1,1) + initialB*u(2:N-1,1) + 2*1i*t*(abs(u(2:N-1,1)).^2).*(u(2:N-1,1));

u(end-1,n+1) = u(end-1,n) + s*(u(end-2,n) - 2*u(end-1,n) + u(1,n)) + 2*1i*t*(abs(u(end-1,n))).^2.*(u(end-1,n));
u(end,n+1) = u(end,n) + s*(u(end-1,n) - 2*u(1,n) + u(2,n)) + 2*1i*t*(abs(u(1,n))).^2*(u(1,n));
n = n+1;
s=2*s;
while (n<= M)
    u(1,n+1) = u(1,n-1) + s*(u(end-1,n) - 2*u(1,n) + u(2,n)) + 4*1i*t*(abs(u(1,n))).^2.*(u(1,n));
    u(2:N-1,n+1) = u(2:N-1,n-1) + genericB*u(2:N-1,n) + 4*1i*t*(abs(u(2:N-1,n)).^2).*(u(2:N-1,n));
    
    u(end-1,n+1) = u(end-1,n-1) + s*(u(end-2,n) - 2*u(end-1,n) + u(1,n)) + 4*1i*t*(abs(u(end-1,n))).^2.*(u(end-1,n));
    u(end,n+1) = u(end,n-1) + s*(u(end-1,n) - 2*u(1,n) + u(2,n)) + 4*1i*t*(abs(u(1,n))).^2.*(u(1,n));
    n=n+1;
end
%% Let us define the actual solution
for p = 1:N+1
    for q = 1:M+1
        %v(p,q) = A*sech(A*(xtest(p)+10 + 4*T(q)))*exp(-1i*(2*(xtest(p)+10) + (4-A^2)*T(q)));
        v(p,q) = A*sech(A*(x(p)+10 + 4*T(q)))*exp(-1i*(2*(x(p)+10) + (4-A^2)*T(q)));
    end
end

%% Let us plot our solutions compared to actual solution.
realU = real(u);
imaginaryU = imag(u);
absU = abs(u);

figure(1), surf(x,T,realU)
figure(2), surf(x,T,imaginaryU)
figure(3), surf(x,T,absU)
figure(4), surf(x,T,abs(v))
%figure(4), surf(x,T,imag(v))
%figure(2), surf(x,T,real(v))

    




