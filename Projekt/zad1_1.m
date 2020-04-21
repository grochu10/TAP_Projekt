%Skrypt realizujacy inicjalizacje modelu zbiornika z mieszaniem(Zadanie 3)

%Wlasciwosci eksperymentu

n = 10000;%dlugosc eksperymentu
opoznienia = 1;%czy opoznienia obiektu nieliniowego

%Stale

C = 4;
alfa = 10;

%Warunki poczatkowe

%Doplywy
F_ciep = 25;
F_zimn = 40;
F_zakl = 17;

F_dop = F_ciep + F_zimn + F_zakl; %suma doplywow

%Temperatury doplywow
T_ciep = 70;
T_zimn = 30;
T_zakl = 43;

A = F_ciep*T_ciep + F_zimn*T_zimn + F_zakl*T_zakl;%rownanie doplywow

%Punkty poczatkowe(w punkcie pracy)
h = (F_dop/alfa)^2;%wysokosc cieczy w zbiorniku w punkcie pracy

T = A/F_dop;%temperatura cieczy w zbiorniku w punkcie pracy
T0 = T;
T_lin = T;

V = C*h^2;%objetosc cieczy w zbiorniku w punkcie pracy
V_lin = V;
V_lin0 = V;

%Okres probkowania

Tp = 1;

%Skokowe zmiany sterowania dla obiektu liniowego

F_ciep2 = F_ciep -10;
F_zimn2 = F_zimn +20;
F_dop_lin =  F_ciep2 + F_zimn2 + F_zakl;

A_lin = F_ciep2*T_ciep + F_zimn2*T_zimn + F_zakl*T_zakl;

%Symulacja

for i = 1:n
    
    %Ustawienie doplywow w zaleznosci od obecnosci opoznien(dla modelu
    %nieliniowego)
    
    if opoznienia == 1
     if i == 400
        F_dop = F_ciep2 + F_zimn + F_zakl;
        A = F_ciep2*T_ciep + F_zimn*T_zimn + F_zakl*T_zakl;
     end
     if i == 500
        F_dop = F_ciep2 + F_zimn2 + F_zakl;
        A = F_ciep2*T_ciep + F_zimn2*T_zimn + F_zakl*T_zakl;
     end
    else
        F_dop = F_ciep2 + F_zimn2 + F_zakl;
        A = F_ciep2*T_ciep + F_zimn2*T_zimn + F_zakl*T_zakl;
    end
    
    %Rozwiazanie rownan roznicowych zmodyfikowan¹ metod¹ Eulera (MidPoint)
    
    %Objetosc cieczy w zbiorniku
    
    V_pom = V + 0.5*Tp*(F_dop - alfa*sqrt(h));
    h_pom = sqrt(V_pom/C);
    
    dV = Tp*(F_dop-(alfa*sqrt(h_pom)));
    V = V + dV;
    
    %Temperatura cieczy w zbiorniku
    
    T_pom = T + 0.5*Tp*((A - F_dop*T)/V);
    
    dT = (A - F_dop*T_pom)/V;
    T = T + dT;
    
    %Linearyzacja
    
    %Objetosc cieczy w zbiorniku
    
    V_lin_pom = V_lin + alfa*sqrt(sqrt(V_lin0/C)) + alfa/4 * power(V_lin0/C,-3/4) * (V_lin-V_lin0);
    h_lin_pom = sqrt(V_lin_pom/C);
    
    dV_lin = Tp*(F_dop_lin - (alfa*sqrt(sqrt(V_lin0/C)) + alfa/4 * power(V_lin0/C,-3/4) * (V_lin-V_lin0)) );
    V_lin = V_lin + dV_lin;
    
    %Temperatura cieczy w zbiorniku 
    
    dT_lin = Tp*( (A_lin - F_dop_lin*T0)/V_lin0 - (A_lin - F_dop_lin*T0)/V_lin0^2 * (V_lin-V_lin0) - F_dop_lin/V_lin0*(T_lin - T0) );
    T_lin = T_lin + dT_lin;
    
    %Dane do wykresow oraz aktualizacja danych
    
    V_vector(i) = V;
    V_lin_vector(i) = V_lin;
    
    h = sqrt(V/C);
    h_lin = sqrt(V_lin0/C) + sqrt(1/C)/(2*sqrt(V_lin0))*(V_lin-V_lin0);
    h_vector(i) = h;
    h_lin_vector(i) = h_lin;
    
    T_vector(i) = T;
    T_lin_vector(i) = T_lin;
    
    czas(i)=(i-1)*Tp;
end

%Rysowanie wykresow

%%  V  %%

figure;
plot(czas,V_lin_vector,'r')
hold on
plot(czas,V_vector,'g')
xlabel('czas');
ylabel('V');
legend('V-lin','V-zwykle','Location','South')
title({'Wykres objetosci cieczy w zbiorniku od czasu';'dla skokow F_H = F_H -10,F_C = F_C +20(bez opoznien)'})

%print('zad1b_krok_miesz3_V_op','-dpng','-r400')

%%% T %%

figure;
plot(czas,T_lin_vector,'r')
hold on
plot(czas,T_vector,'g')
xlabel('czas');
ylabel('T');
legend('T-lin','T-zwykle','Location','South')
title({'Wykres temperatury cieczy w zbiorniku od czasu';'dla skokow F_H = F_H -10,F_C = F_C +20(bez opoznien)'})

%print('zad1b_krok_miesz3_T_op','-dpng','-r400')