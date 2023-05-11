syms z

gasProperties

phi = 0.4;

T = getT(phi);

%input
phi = 0.8;

deltaH = -Hf_NO;
deltaS = -S_NO;

deltaG = deltaH - T*deltaS/1000;

Kp = exp(-deltaG*1000/T/R_0);

%find Kp with H and S
%Solve for z
getz = Kp == z^2/(1-z)^2;
%z = double(min(solve(getz,z)));
z = double(max(solve(getz,z)));


function T = getT(phi)
    Tphi = [0.4,   1623.8;
            0.6,   2028.8;
            0.8,   2331.7;
            0.99,  2482.9;];

    T = interp1(Tphi(:,1),Tphi(:,2),phi);


end

