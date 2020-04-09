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

F = F_ciep + F_zimn + F_zakl; %suma dop�yw�w

%Temperatury doplywow
T_ciep = 70;
T_zimn = 30;
T_zakl = 43;

A = F_ciep*T_ciep + F_zimn*T_zimn + F_zakl*T_zakl;%rownanie doplywow

%Punkty poczatkowe
h = (F/alfa)^2;
h0 = h;
h_lin = h;

T = A/F;
T0 = T;
T_lin = T;

V = C*h^2;
V_lin = C*h_lin^2;

%Okres probkowania

Tp = 1;

%Skokowe zmiany sterowania

F_dop = F +30;

%Symulacja

for i = 1:n
    
    %Rozwiazanie rownan roznicowych zmodyfikowan� metod� Eulera (MidPoint)
    
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
    
    dV_lin = Tp*(F_dop - alfa*(sqrt(h0)+(1/(2*sqrt(h0))*(h_lin_pom - h0))));
    V_lin = V_lin + dV_lin;
    
    %Dane do wykresu oraz aktualizacja danych
    
    V_vector(i) = V;
    V_lin_vector(i) = V_lin;
    
    h = sqrt(V/C);
    h_lin = sqrt(V_lin/C);
    h_vector(i) = h;
    h_lin_vector(i) = h_lin;
    
    T_vector(i) = T;
    
end

%Rysowanie wykresow

plot(0:n-1,h_vector,'b')
hold on
plot(0:n-1,h_lin_vector,'m')
xlabel('t');
ylabel('h');
legend('h-zwykle','h-lin','Location','South')
title('Wykres wysoko�ci rzeczywistego oraz zlinearyzowanego poziomu cieczy')

figure;
plot(0:n-1,T_vector,'b')
hold on
xlabel('t');
ylabel('T');
legend('T-zwykle','Location','South')

title('Wykres temperatury poziomu cieczy')
figure;
plot(h_lin_vector,V_lin_vector,'r')
hold on
plot([67.24 104.6013],[18084.8704 42442.1264],'g')
%plot(h_vector,V_vector,'g')
plot(h0,C*h0^2,'or')
xlabel('h');
ylabel('V');
legend('V-lin','V-zwykle','Punkt pracy','Location','South')
title('V(h)')