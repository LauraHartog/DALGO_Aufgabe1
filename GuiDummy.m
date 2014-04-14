% Script to do something usefull (fill out)
% Author: Wichert/Hartog (c) IHA @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 13-Apr-2014 			 Initials: FW, LH

clear;
close all;
clc;

%------------Your script starts here-------- 
DummyDay = ['Montag' 'Dienstag' 'Mittwoch' 'Donnerstag' 'Freitag'];
DummyTepreture = [ 20 19 17 15 15];
DummyRainRisk = [5 15 33 78 89];

hfig = figure;
set(gcf,'color','w');

htitle = uicontrol(hfig,'style','text',...
            'units', 'normalized',...
            'position',   [0.1 0.8 0.8 0.1],...
            'string', 'Wettervorhersage Oldenburg',...
            'BackgroundColor', 'white');
        
h2 = uipanel('Parent', hfig,...
             'units', 'normalized',...
             'position',   [0.15 0.25 0.3 0.5]);

h3 = uicontrol(h2,...
            'style','text',...
            'string', 'huhu');
         
         
              
              
           








%--------------------Licence ---------------------------------------------
% Copyright (c) <2014> Wichert/Hartog
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences 
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files 
% (the "Software"), to deal in the Software without restriction, including 
% without limitation the rights to use, copy, modify, merge, publish, 
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject
% to the following conditions:
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.