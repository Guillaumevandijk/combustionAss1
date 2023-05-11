syms z


%input
phi = 0.8;

%find Kp with H and S
Kp = 0.012;

%Solve for z
getz = Kp == 3*z/(3.76*3/phi - z)/(3/phi-3-z);
z = double(min(solve(getz,z)));
