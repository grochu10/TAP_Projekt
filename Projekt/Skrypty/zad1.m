%Skrypt realizujacy inicjalizacje modelu zbiornika z mieszaniem(Zadanie 3)

%Dlugosc eksperymentu

n = 2000;

%Stale

C = 4;
alfa = 10;

%Warunki poczatkowe

%Doplywy
F_ciep = 25;
F_zimn = 40;
F_zakl = 17;

F_dop = F_ciep + F_zimn + F_zakl; %suma dop³ywów

%Temperatury doplywow
T_ciep = 70;
T_zimn = 30;
T_zakl = 43;

A = F_ciep*T_ciep + F_zmin*T_zimn + F_zakl*T_zakl;%rownanie doplywow

%Punkty poczatkowe
h = (F_dop/alfa)^2;
h0 = h;
h_lin = h;

T = A/F_dop;
T0 = T;
T_lin = T;

V = C*h;
V_lin = C*h_lin;

%Okres probkowania

Tp = 1;

%Skokowe zmiany sterowania

%F_dop = F_dop - 30;

%Symulacja

for i = 1:n
    
    %Rozwiazanie rownan roznicowych zmodyfikowan¹ metod¹ Eulera (MidPoint)
    
    %Objetosc cieczy w zbiorniku
    
    V_pom = V + 0.5*Tp*(F_dop - alfa*sqrt(h));
    h_pom = sqrt(V_pom/C);
    
    dV = F_dop - alfa*sqrt(h_pom);
    V = V + dV;
    
    %Temperatura cieczy w zbiorniku
    
    T_pom = T + 0.5*Tp*((A - F_dop*T)/V);
    dT = (A - F_dop*T_pom)/V;
    T = T + dT;
    
    %Linearyzacja
    
    %Objetosc cieczy w zbiorniku
    
    V_lin_pom = V_lin + 0.5*Tp*(F_dop - alfa*(sqrt(h0)+(1/(2*sqrt(h0))*(h_lin - h0))));
    h_lin_pom = sqrt(V_lin_pom/C);
    
    dV_lin = Tp*(F_dop - alfa*sqrt(h_lin_pom));
    V_lin = V_lin + dV_lin;
    
    %Temperatura cieczy w zbiorniku
    
    %%%%%%dopisac linearyzacje temperatury cieczy w zbiorniku%%%%%%
    
    %Dane do wykresu oraz aktualizacja danych
    
    V_vector(i) = V;
    V_lin_vector(i) = V_lin;
    
    h = V/C;
    h_lin = V_lin/C;
    h_vector(i) = h;
    h_lin_vector(i) = h_lin;
    
    T_vector(i) = T;
    T_lin_vector(i) = T_lin;
    
end

%Rysowanie wykresow

plot(0:n-1,h_vector,'b')
hold on
plot(0:n-1,h_lin_vector,'m')
xlabel('t');
ylabel('h');
legend('h-zwykle','h-lin','Location','South')
title('Wykres wysokoœci rzeczywistego oraz zlinearyzowanego poziomu cieczy')