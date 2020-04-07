%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                              %
%%    Skrypt ilustruj�cy dyskretyzacj� transmitancji opisuj�cej zbiornik        %
%%  (ci�g dalszy przyk�adu II z wprowadzenia; najpierw nale�y uruchomi�         %
%%  przyklad2.m).                                                               %
%%    Tp - stopniowo zmieniany okres pr�bkowania                                %
%%         (kolejne zmiany po naci�ni�ciu dowolnego klawisza)                   %
%%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Autor: Piotr Marusak; 2013-2020
%   Wersja przeznaczona dla s�uchaczy wyk�adu Technika Automatyzacji Proces�w.

Tp=200; % pocz�tkowa warto�� okresu pr�bkowania (wyra�nie zbyt du�a)
metoda='zoh';
sys=tf(1,[P alfa/(2*sqrt(h0))]) % transmitancja ci�g�a
sysd=c2d(sys,Tp,metoda) % transmitancja dyskretna
step(sys); hold on; step(sysd)

pause;
Tp=Tp/2
sysd1=c2d(sys,Tp,metoda); step(sysd1);

pause;
Tp=Tp/2
sysd2=c2d(sys,Tp,metoda); step(sysd2);

pause;
Tp=Tp/2.5
sysd3=c2d(sys,Tp,metoda); step(sysd3);

pause;
Tp=Tp/2
sysd4=c2d(sys,Tp,metoda); step(sysd4);

pause;
Tp=Tp/10
sysd5=c2d(sys,Tp,metoda); step(sysd5);
