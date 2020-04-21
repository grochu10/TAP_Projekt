%Skrypt realizuj¹cy tworzenie modelu w postaci transmitancji ciaglej,
%dyskretyzacje modelu oraz implementacje modelu dyskretnego w postaci 
%rownan stanu(konieczne jest uruchomienie skryptu po skrypcie zad1_1.m)

%Macierze rownan stanu modelu ciaglego

A1 = [ -alfa/4*power(V_lin0/C,-3/4) 0; -(F_ciep*(T_ciep - T0) + F_zimn*(T_zimn - T0) + F_zakl*(T_zakl - T0))/V_lin0^2 -(F_ciep + F_zimn + F_zakl)/V_lin0;];
B1 = [1 1; (T_ciep - T0)/V_lin0 (T_zimn - T0)/V_lin0;];
C1 = [0.5*sqrt(1/(C*V_lin0)) 0;0 1;];
D1 = [0 0; 0 0;];

%Transmitancja modelu
sys = tf(ss(A1,B1,C1,D1));

%Dyskretyzacja transmitancji
Ts = 10;
sys2 = c2d(sys,Ts(2),'zoh');
figure;
step(sys)
hold on
step(sys2)
legend('G(s)','G(z)')

%Tworzenie dyskretnego modelu w postaci rownan stanu
sys3 = ss(sys2,'minimal');

%Tworzenie wykresow dla roznych Ts    

%Ts = [5 10 20 50 100 200 500];
% for i = 1:7
%     sys2 = c2d(sys,Ts(i),'zoh')
%     figure;
%     step(sys)
%     hold on
%     step(sys2)
%     title(['Step response Ts =',num2str(Ts(i))])
%     legend('G(s)','G(z)')
%     %print(['zad1d_',num2str(Ts(i))],'-dpng','-r400')
% end