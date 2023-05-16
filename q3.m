clear all;
close all;

%import gas properties
gasProperties

%input
phi_list = [0.4 0.6 0.8 0.9];
Y_NO_list = [];

%% calculate the mass fraction of NO for the values of phi above
for phi = phi_list

[T,Y_NO_listCEA] = getT(phi);
%Uncommend for the results at 10 bar
%[T,Y_NO_listCEA] = getT10(phi);


deltaH = 2*Hf_NO;
deltaS = 2*S_NO-S_O2-S_N2;

deltaG = deltaH - T*deltaS/1000;

Kp = exp(-deltaG*1000/T/R_0);

%% find z for the calculated Kp and given phi

%Solve for z
syms z
getz = Kp == (2*z)^2/((3/phi-3-z)*(3.76*3/phi-z));
%z = double(min(solve(getz,z)));
z_all = double(solve(getz,z));
z = max(z_all);

%% Find results for the solved system above 
%Calculate amount of moles per species
n_NO = 2*z;
n_N2 = 3.76*3/phi-z;
n_O2 = 3/phi-3-z;
n_CO2 = 2;
n_H2O = 2;

%total mol for 1 mol of fuel
n_tot = n_H2O+n_CO2+n_N2+n_O2+n_NO;

%Calculate molar fractions
X_NO = n_NO/n_tot
X_N2 = n_N2/n_tot
X_O2 = n_O2/n_tot
X_CO2 = n_CO2/n_tot
X_H2O = n_H2O/n_tot

%total mass for 1 mole of fuel
W_tot = n_H2O*W_H2O+  n_CO2*W_CO2+  n_N2*W_N2  +n_O2*W_O2  +n_NO*W_NO;

%Calculate mass fractions
Y_NO = n_NO*W_NO/W_tot
Y_N2 = n_N2*W_N2/W_tot
Y_O2 = n_O2*W_O2/W_tot
Y_CO2 = n_CO2*W_CO2/W_tot
Y_H2O = n_H2O*W_H2O/W_tot

%append NO mass fractions to list for plotting
Y_NO_list(1,end+1) = Y_NO;

end

%% plot results
hold on

%plot results for 0D calculations
plot(phi_list, Y_NO_list)

%plot CEA results
plot(phi_list,Y_NO_listCEA)
%sum([X_H2O,X_CO2,X_NO,X_O2,X_N2]) check

title('Molar fraction of NO/ equivalence ratio @1 bar of pressure');
%Uncommend for the results at 10 bar
%title('Molar fraction of NO against equivalence ratio @10 bar of pressure');
xlabel("Equivalence ratio [-]");
ylabel("Mass fraction of NO [-]");
legend(["0D calculations","CEA results"],'Location' ,'northwest')

%% define functions for obtaining T with phi from CEA the results for Y_NO
function [T,Y_list] = getT(phi)
    %Phi, temperature results from CEA for 1 bar of pressure
    Tphi = [0.4,   1623.8;
            0.6,   2028.8;
            0.8,   2331.7;
            0.99,  2482.9;];

    %mass fraction results from CEA to plot directly at the end
    Y_list = [1.5971E-03, 4.8941E-03, 6.8783E-03, 5.4125E-03];

    %get values for the temperature from CEA 
    T = interp1(Tphi(:,1),Tphi(:,2),phi);
end


function [T,Y_list] = getT10(phi)
    %Phi, temperature results from CEA for 10 bar of pressure
    Tphi = [0.4,   1.6241E+03;
            0.6,   2.0351E+03;
            0.8,   2.3773E+03;
            0.99,  2.5795E+03;];
    %mass fraction results from CEA to plot directly at the end
    Y_list = [1.5995E-03, 4.9858E-03, 7.3735E-03, 5.2720E-03];

    %get values for the temperature from CEA 
    T = interp1(Tphi(:,1),Tphi(:,2),phi);


end