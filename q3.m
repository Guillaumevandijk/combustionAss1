syms z

gasProperties

%input
phi = 0.99 

T = getT(phi);



deltaH = 2*Hf_NO;
deltaS = 2*S_NO-S_O2-S_N2;

deltaG = deltaH - T*deltaS/1000;

Kp = exp(-deltaG*1000/T/R_0);

%find Kp with H and S
%Solve for z
getz = Kp == (2*z)^2/((3/phi-3-z)*(3.76*3/phi-z));
%z = double(min(solve(getz,z)));
z_all = double(solve(getz,z));
z = max(z_all);

n_NO = 2*z;
n_N2 = 3.76*3/phi-z;
n_O2 = 3/phi-3-z;
n_CO2 = 2;
n_H2O = 2;

n_tot = n_H2O+n_CO2+n_N2+n_O2+n_NO;

X_NO = n_NO/n_tot
X_N2 = n_N2/n_tot
X_O2 = n_O2/n_tot
X_CO2 = n_CO2/n_tot
X_H2O = n_H2O/n_tot

W_tot = n_H2O*W_H2O+  n_CO2*W_CO2+  n_N2*W_N2  +n_O2*W_O2  +n_NO*W_NO;

Y_NO = n_NO*W_NO/W_tot
Y_N2 = n_N2*W_N2/W_tot
Y_O2 = n_O2*W_O2/W_tot
Y_CO2 = n_CO2*W_CO2/W_tot
Y_H2O = n_H2O*W_H2O/W_tot



%sum([X_H2O,X_CO2,X_NO,X_O2,X_N2]) check


function T = getT(phi)
    Tphi = [0.4,   1623.8;
            0.6,   2028.8;
            0.8,   2331.7;
            0.99,  2482.9;];

    T = interp1(Tphi(:,1),Tphi(:,2),phi);


end

