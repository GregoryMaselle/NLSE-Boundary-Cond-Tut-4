# NLSE-Boundary-Cond-Tut-4
This is matlab code to get the solution of the Non-linear Schrodinger Equation using Finite differences with an explicit scheme.
The problem being solved is the Following:

Provided the equation: u = u(x,t)
            i*(∂u/∂t) + (∂^2u/
            ∂x^2) + 2|u|^2 * u = 0
with periodic boundary conditions: 
            u(0,t) = u(20,t)
            ∂u/∂x(0,t) = ∂u/∂x(20,t).
            
The initial condition is:
            u(x,0) = Asech(A(x-10))e^(-2i(x-10)), A = 1, 4, 8,...
            
Currently the solution is only coherent for A =1.
            
            
The solution is obtained numerically using finite differences. I make use of centered differences for the approximation of ∂u/∂t to create an explicit scheme.
This is easier to implement than an implicit scheme (Crank-nicolson) but it has the issue that there is a stability condition on the solution. 
The solution is only stable if τ < h^2/4   where τ = time step and h = space step. This can make it hard to plot for larger time intervals in matlab using the surf function. Solutions are visualised using the imaginary and real portions of the solution matrix and the modulus of the solution array.
