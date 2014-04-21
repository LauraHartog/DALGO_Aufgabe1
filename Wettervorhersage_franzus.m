% Skript mit welchem eine xml-Datei von der Seite 
% http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889
% heruntergeladen werden kann und Indizes zurückgibt, mit welchen man auf
% die Wetterdaten zu den Tageszeiten mitternachts, morgens, mittags und
% abends zugreifen kann. Ausgabewert ist ein struct namens
% 'daystruct', mit dem man durch die Form
% 'daystruct(Tagesnummer).condition(Tageszeit)' auf die entsprechenden
% xml_Indizes zugreifen kann.
%
% Author: L. Hartog, F. Wichert (c) IHA @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 18-Apr-2014 			 Initials (eg. JB)

clear;
close all;
clc;



%------------Your script starts here-------- 

% Websites
% met.no: http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889
%
% wonderground.com: http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.json
% API-Key-Franzus: a6e1ba8ffec4fb4a


%path_met_xml = urlwrite('http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889', 'weather_met.xml');

%path_wg_xml = urlwrite('http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.xml','weather_wg.xml');
%path_wg_json = urlwrite('http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.json','weather_wg.json');

path_met_xml = urlwrite('http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889', 'weather_met.xml');

xml = xmlread('weather_met.xml');
data = parse_xml(xml);


product = data.children{1}.children{2};

% Indizes detektieren, in welchen das Wetter für die Zeitpunkte früh,
% mittags, abends und mitternachts beschrieben wird.

morning_str = '06:00:00';
midday_str = '12:00:00';
evening_str = '18:00:00';
midnight_str = '00:00:00';

midnight_cond_idx = NaN;
morning_cond_idx = NaN;
midday_cond_idx = NaN;
evening_cond_idx = NaN;

midnight_prec_idx = NaN;
morning_prec_idx = NaN;
midday_prec_idx = NaN;
evening_prec_idx = NaN;


idx_length = length(product.children);




day_number = 1;

for idx = 1:idx_length

    
    time = product.children{idx}.attributes;
    
    clocktime_str_from = regexp(time.from,'[0-9]{2}\:[0-9]{2}\:[0-9]{2}','match');
    clocktime_str_to = regexp(time.to,'[0-9]{2}\:[0-9]{2}\:[0-9]{2}','match');

    date_str_from = regexp(time.from,'[0-9]{4}\-[0-9]{2}\-[0-9]{2}','match');
    date_str_to = regexp(time.to,'[0-9]{4}\-[0-9]{2}\-[0-9]{2}','match');
    
    
    if idx > 1
    
        prev_date_str_from = regexp(product.children{idx-1}.attributes.from,'[0-9]{4}\-[0-9]{2}\-[0-9]{2}','match');
        
    else
        
        prev_date_str_from = date_str_from;
        
    end
    
    
    % if-Bedingung, welche ab Anbruch eines neuen Tages ('00:00:00') alle
    % vergangenen Variablen in die structnummer des vorherigen Datums schreibt,
    % und einen neuen Tag im daystruct öffnet
    % Problem: Der letzte Tag wird nicht mehr in das Day-struct
    % geschrieben; Dies ist jedoch nicht weiter schlimm, da am Ende eh nur
    % 6 Tage ausgewertet werden.
 
    
    if strcmp(clocktime_str_from, midnight_str) && strcmp(clocktime_str_to,...
            midnight_str) && (strcmp(date_str_from, prev_date_str_from) == 0)
        
        daystruct(day_number) = struct('date', prev_date_str_from,...
                               'condition',[midnight_cond_idx, morning_cond_idx, midday_cond_idx, evening_cond_idx],...
                               'precipitation', [midnight_prec_idx, morning_prec_idx, midday_prec_idx, evening_prec_idx]);
        
        day_number = day_number + 1;
    
    end
    
    
    % Wetterkondition-Indizes ausfindig machen, welche für die Tageszeiten
    % mitternachts, morgens, mittags und abends stehen

    if strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, midnight_str)
        
        midnight_cond_idx = idx;
        
    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, morning_str)
        
        morning_cond_idx = idx;
        
    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, midday_str)
        
        midday_cond_idx = idx;
        
    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, evening_str)
        
        evening_cond_idx = idx;
       
    end
    
    % Niederschlag-Indizes ausfindig machen, welche für die Tageszeiten
    % mitternachts, morgens, mittags und abends stehen    
    
    if strcmp(clocktime_str_from, evening_str) == 1 && strcmp(clocktime_str_to, midnight_str) == 1
        
        midnight_prec_idx = idx;
        
    elseif strcmp(clocktime_str_from, midnight_str) == 1 && strcmp(clocktime_str_to, morning_str) == 1
        
        morning_prec_idx = idx;
        
    elseif strcmp(clocktime_str_from, morning_str) == 1 && strcmp(clocktime_str_to, midday_str) == 1
        
        midday_prec_idx = idx;

    elseif strcmp(clocktime_str_from, midday_str) == 1 && strcmp(clocktime_str_to, evening_str) == 1
        
        evening_prec_idx = idx;
    
    end
    
end

%--------------------Licence ---------------------------------------------
% Copyright (c) <2014> L. Hartog, F. Wichert
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