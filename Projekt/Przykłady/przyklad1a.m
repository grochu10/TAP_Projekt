%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                              %
%%    Skrypt ilustruj�cy linearyzacj� przyk�adowej funkcji                      %
%%  (przyk�ad Ia z wprowadzenia).                                               %
%%    x0 - punkt wzgl�dem kt�rego jest wykonywana linearyzacja (linia 12.)      %
%%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Autor: Piotr Marusak; 2013-2020
%   Wersja przeznaczona dla s�uchaczy wyk�adu Technika Automatyzacji Proces�w.

clear all;

x0=0.5 %%%%% warto pozmienia�
x=-2:0.01:2;
y=2.*(x.^2)+4;
yL=2.*x0.^2+4+4.*x0.*(x-x0);

plot(x,y,'b'); hold on; xlabel('x'); ylabel('y'); % rysunek funkcji nieliniowej
plot(x0,2.*(x0.^2)+4,'og') % punkt, w kt�rym funkcja by�a linearyzowana
plot(x,yL,'g'); % rysunek funkcji liniowej
