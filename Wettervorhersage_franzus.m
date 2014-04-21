% Script to do something usefull (fill out)
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

xml = xmlread('weather_met_180414_1519Uhr.xml');
data = parse_xml(xml);


product = data.children{1}.children{2};

% Indizes detektieren, in welchen das Wetter für die Zeitpunkte früh,
% mittags, abends und mitternachts beschrieben wird.

morning_str = '06:00:00';
midday_str = '12:00:00';
evening_str = '18:00:00';
midnight_str = '00:00:00';


idx_length = length(product.children);

m = 0;
n = 0;


for idx = 1:idx_length

    time = product.children{idx}.attributes;

    clocktime_str_from = regexp(time.from,'[0-9]{2}\:[0-9]{2}\:[0-9]{2}','match');
    clocktime_str_to = regexp(time.to,'[0-9]{2}\:[0-9]{2}\:[0-9]{2}','match');

    if strcmp(clocktime_str_from,clocktime_str_to) == 1 &&...
            (sum(strcmp(clocktime_str_from, {morning_str, midday_str, evening_str, midnight_str})) == 1)
    
        m = m + 1;
        
        condition_block(m) = idx;
    
    end
    
    if (strcmp(clocktime_str_from, midnight_str) == 1 && strcmp(clocktime_str_to, morning_str) == 1) ||...
        (strcmp(clocktime_str_from, morning_str) == 1 && strcmp(clocktime_str_to, midday_str) == 1) ||...
        (strcmp(clocktime_str_from, midday_str) == 1 && strcmp(clocktime_str_to, evening_str) == 1)||...
        (strcmp(clocktime_str_from, evening_str) == 1 && strcmp(clocktime_str_to, midnight_str) == 1)
    
    n = n + 1;
    
    precipitation_block(n) = idx;
    
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