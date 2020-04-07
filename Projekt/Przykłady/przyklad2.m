%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                              %
%%    Skrypt ilustruj�cy linearyzacj� modelu zbiornika                          %
%%  (przyk�ad II z wprowadzenia).                                               %
%%    h - wysoko�� s�upa cieczy w zbiorniku                                     %
%%    hL - wyj�cie zlinearyzowanego modelu zbiornika                            %
%%    F - dop�yw cieczy do zbiornika (mo�na zmienia� w linii 36.)               %
%%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Autor: Piotr Marusak; 2002-2020
%   Wersja przeznaczona dla s�uchaczy wyk�adu Technika Automatyzacji Proces�w.

clear all;

% parametry zbiornika

P=530;
alfa=27;

% warunki pocz�tkowe

F=111;
h=(F/alfa)^2;
h0=h;
hL=h;
V=P*h;
VL=P*hL;

% okres pr�bkowania

Tp=1;

% skokowe zmiany sterowania

F=F-30; %%%%% warto pozmienia� (np. o -30, -20, -10, 10, 20, 30)

for i=1:2000
   
   % rozwi�zywanie r�wna� r�niczkowych zmodyfikowan� metod� Eulera
   
   pomV=V+0.5*Tp*(F-(alfa*sqrt(h)));
   pomh=pomV/P;
   
   dV=Tp*(F-(alfa*sqrt(pomh)));
   V=V+dV;
   
   pomVL=VL+0.5*Tp*(F-(alfa*(sqrt(h0)+(1/(2*sqrt(h0)))*(hL-h0))));
   pomhL=pomVL/P;
   
   dVL=Tp*(F-(alfa*(sqrt(h0)+(1/(2*sqrt(h0)))*(hL-h0))));      
   VL=VL+dVL;
   
   % przygotowanie zmiennych do rysowania
   
   wyV(i)=V;
   wyVL(i)=VL;
   
   h=V/P;
   hL=VL/P;
   wyh(i)=h;
   wyhL(i)=hL;
   
   czas(i)=(i-1)*Tp;
end

% rysowanie przebieg�w zmiennych

plot(czas,wyh,'b');hold on;plot(czas,wyhL,'m');
xlabel('czas');
ylabel('h');
