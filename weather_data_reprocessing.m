function [daystruct] = weather_data_reprocessing()
%WEATHER_DATA_REPROCESSING Wetterdaten verarbeiten struct
%   WEATHER_DATA_REPROCESSING() = WEATHER_DATA_REPROCESSING(in_param)
% Input Parameter:
%	 in_param: 		 Explain the parameter, default values, and units
% Output Parameter:
%	 out_param: 	 Explain the parameter, default values, and units
%------------------------------------------------------------------------ 
% Example: Provide example here if applicable (one or two lines) 

% Author: Laura Hartog, Franz Wichert (c) TGM @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 28-Apr-2014  Initials (eg. JB)

%------------Your function implementation here--------------------------- 

% Wetter-URL in xml-Format als 'weather_met.xml' downloaden und einlesen;
% mit parse_xml wird die xml_datei in ein leichter zu verarbeitendes struct
% umgewandelt

path_met_xml = urlwrite('http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889', 'weather_met.xml');
xml = xmlread('weather_met.xml');
data = parse_xml(xml);


product = data.children{1}.children{2};

% Variablen bzw. Konstanten deklarieren

morning_str = '06:00:00';
midday_str = '12:00:00';
evening_str = '18:00:00';
midnight_str = '00:00:00';

midnight_prec = 'N/A';
morning_prec = 'N/A';
midday_prec = 'N/A';
evening_prec = 'N/A';

midnight_temp = NaN;
morning_temp = NaN;
midday_temp = NaN;
evening_temp = NaN;

midnight_winddir = 'N/A';
morning_winddir = 'N/A';
midday_winddir = 'N/A';
evening_winddir = 'N/A';

midnight_windspeed = 'N/A';
morning_windspeed = 'N/A';
midday_windspeed = 'N/A';
evening_windspeed = 'N/A';

midnight_humidity = 'N/A';
morning_humidity = 'N/A';
midday_humidity = 'N/A';
evening_humidity = 'N/A';

midnight_pressure = 'N/A';
morning_pressure = 'N/A';
midday_pressure = 'N/A';
evening_pressure = 'N/A';

midnight_cloudiness = 'N/A';
morning_cloudiness = 'N/A';
midday_cloudiness = 'N/A';
evening_cloudiness = 'N/A';

midnight_fog = 'N/A';
morning_fog = 'N/A';
midday_fog = 'N/A';
evening_fog = 'N/A';

midnight_lowclouds = 'N/A';
morning_lowclouds = 'N/A';
midday_lowclouds = 'N/A';
evening_lowclouds = 'N/A';

midnight_medclouds = 'N/A';
morning_medclouds = 'N/A';
midday_medclouds = 'N/A';
evening_medclouds = 'N/A';

midnight_highclouds = 'N/A';
morning_highclouds = 'N/A';
midday_highclouds = 'N/A';
evening_highclouds = 'N/A';

midnight_dptemp = 'N/A';
morning_dptemp = 'N/A';
midday_dptemp = 'N/A';
evening_dptemp = 'N/A';

midnight_cloud_percentage = NaN;
morning_cloud_percentage = NaN;
midday_cloud_percentage = NaN;
evening_cloud_percentage = NaN;

midnight_prec_value = NaN;
morning_prec_value = NaN;
midday_prec_value = NaN;
evening_prec_value = NaN;

midnight_pic = NaN;
morning_pic = NaN;
midday_pic = NaN;
evening_pic = NaN;


idx_length = length(product.children);

day_nr = 1;

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
    % 7 Tage ausgewertet werden.
 
    
    if strcmp(clocktime_str_from, midnight_str) && strcmp(clocktime_str_to,...
            midnight_str) && (strcmp(date_str_from, prev_date_str_from) == 0)
        
        
        % Vier if Schleifen welche ein passendes Wetterbild zu den
        % vier Tageszeiten durch analysieren der Wolkigkeit in Prozent und
        % des Niederschlags in mm zuordnen


        if isnan(midnight_cloud_percentage) == 0 && isnan(midnight_prec_value) == 0
            
            if (midnight_cloud_percentage <= 33) && (midnight_prec_value <= 0.2)
                
                midnight_pic = 'night_moony';
                
            elseif (midnight_cloud_percentage > 33) && (midnight_cloud_percentage <= 66) && (midnight_prec_value <= 0.2)
            
                midnight_pic = 'night_partly_cloudy';
                
            elseif (midnight_cloud_percentage > 66) && (midnight_prec_value <= 0.2)
    
                midnight_pic = 'night_cloudy';
            
            elseif (midnight_cloud_percentage <= 50) && (midnight_prec_value > 0.2)
            
                midnight_pic = 'night_moony_rainy';
            
            elseif (midnight_cloud_percentage > 50) && (midnight_prec_value > 0.2)
            
                midnight_pic = 'night_rainy';
            end
            
        end
        
        
        if isnan(morning_cloud_percentage) == 0 && isnan(morning_prec_value) == 0
            
            if (morning_cloud_percentage <= 20) && (morning_prec_value <= 0.2)
                
                morning_pic = imread('day_sunny','png');
                
            elseif (morning_cloud_percentage > 25) && (morning_cloud_percentage <= 50) && (morning_prec_value <= 0.2)
            
                morning_pic = imread('day_slightly_cloudy','png');
                
            elseif (morning_cloud_percentage > 50) && (morning_cloud_percentage <= 75) && (morning_prec_value <= 0.2)
    
                morning_pic = imread('day_partly_cloudy','png');
                
            elseif (morning_cloud_percentage > 75) && (morning_prec_value <= 0.2)
    
                morning_pic = imread('day_cloudy','png');
            
            elseif (morning_cloud_percentage <= 50) && (morning_prec_value > 0.2)
            
                morning_pic = imread('day_sunny_rainy','png');
            
            elseif (morning_cloud_percentage > 50) && (morning_prec_value > 0.2)
            
                morning_pic = imread('day_rainy','png');
            end
            
        end
        
        
        if isnan(midday_cloud_percentage) == 0 && isnan(midday_prec_value) == 0
            
            if (midday_cloud_percentage <= 25) && (midday_prec_value <= 0.2)
                
                midday_pic = imread('day_sunny','png');
                
            elseif (midday_cloud_percentage > 25) && (midday_cloud_percentage <= 50) && (midday_prec_value <= 0.2)
            
                midday_pic = imread('day_slightly_cloudy','png');
                
            elseif (midday_cloud_percentage > 50) && (midday_cloud_percentage <= 75) && (midday_prec_value <= 0.2)
    
                midday_pic = imread('day_partly_cloudy','png');
            
            elseif (midday_cloud_percentage > 75) && (midday_prec_value <= 0.2)
    
                midday_pic = imread('day_cloudy','png');    
                
            elseif (midday_cloud_percentage <= 50) && (midday_prec_value > 0.2)
            
                midday_pic = imread('day_sunny_rainy','png');
            
            elseif (midday_cloud_percentage > 50) && (midday_prec_value > 0.2)
            
                midday_pic = imread('day_rainy','png');
            end
            
        end
        
        
        if isnan(evening_cloud_percentage) == 0 && isnan(evening_prec_value) == 0
            
            if (evening_cloud_percentage <= 25) && (evening_prec_value <= 0.2)
                
                evening_pic = imread('day_sunny','png');
                
            elseif (evening_cloud_percentage > 25) && (evening_cloud_percentage <= 50) && (evening_prec_value <= 0.2)
            
                evening_pic = imread('day_slightly_cloudy','png');
                
            elseif (evening_cloud_percentage > 50) && (evening_cloud_percentage <= 75) && (evening_prec_value <= 0.2)
    
                evening_pic = imread('day_partly_cloudy','png');
                
            elseif (evening_cloud_percentage > 75) && (evening_prec_value <= 0.2)
    
                evening_pic = imread('day_cloudy','png');    
            
            elseif (evening_cloud_percentage <= 50) && (evening_prec_value > 0.2)
            
                evening_pic = imread('day_sunny_rainy','png');
            
            elseif (evening_cloud_percentage > 50) && (evening_prec_value > 0.2)
            
                evening_pic = imread('day_rainy','png');
            end
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
            
        
        
        daystruct(day_nr) = struct('date', prev_date_str_from,...
                            'picture', struct('midnight', midnight_pic, 'morning', morning_pic, 'midday', midday_pic, 'evening', evening_pic),...
                            'precipitation', struct('midnight', midnight_prec, 'morning', morning_prec, 'midday', midday_prec, 'evening', evening_prec),...
                            'temperature', struct('midnight', midnight_temp, 'morning', morning_temp, 'midday', midday_temp, 'evening', evening_temp),...
                            'winddirection', struct('midnight', midnight_winddir, 'morning', morning_winddir, 'midday', midday_winddir, 'evening', evening_winddir),...
                            'windspeed', struct('midnight', midnight_windspeed, 'morning', morning_windspeed, 'midday', midday_windspeed, 'evening', evening_windspeed),...
                            'humidity', struct('midnight', midnight_humidity, 'morning', morning_humidity, 'midday', midday_humidity, 'evening', evening_humidity),...
                            'pressure', struct('midnight', midnight_pressure, 'morning', morning_pressure, 'midday', midday_pressure, 'evening', evening_pressure),...
                            'cloudiness', struct('midnight', midnight_cloudiness, 'morning', morning_cloudiness, 'midday', midday_cloudiness, 'evening', evening_cloudiness),...
                            'fog', struct('midnight', midnight_fog, 'morning', morning_fog, 'midday', midday_fog, 'evening', evening_fog),...
                            'lowclouds', struct('midnight', midnight_lowclouds, 'morning', morning_lowclouds, 'midday', midday_lowclouds, 'evening', evening_lowclouds),...
                            'mediumclouds', struct('midnight', midnight_medclouds, 'morning', morning_medclouds, 'midday', midday_medclouds, 'evening', evening_medclouds),...
                            'highclouds', struct('midnight', midnight_highclouds, 'morning', morning_highclouds, 'midday', midday_highclouds, 'evening', evening_highclouds),...
                            'dewpointtemperature', struct('midnight', midnight_dptemp, 'morning', morning_dptemp, 'midday', midday_dptemp, 'evening', evening_dptemp));
                            
        
        day_nr = day_nr + 1;
    
    end
    
    
    % Verschiedene Wettereigenschaften-attribute detektieren für die
    % Tageszeiten mitternachts, morgens, mittags und abends

    if strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, midnight_str)
        
        midnight_temp = product.children{idx}.children{1}.children{1}.attributes;
        midnight_winddir = product.children{idx}.children{1}.children{2}.attributes;
        midnight_windspeed = product.children{idx}.children{1}.children{3}.attributes;
        midnight_humidity = product.children{idx}.children{1}.children{4}.attributes;
        midnight_pressure = product.children{idx}.children{1}.children{5}.attributes;
        midnight_cloudiness = product.children{idx}.children{1}.children{6}.attributes;
        midnight_fog = product.children{idx}.children{1}.children{7}.attributes;
        midnight_lowclouds = product.children{idx}.children{1}.children{8}.attributes;
        midnight_medclouds = product.children{idx}.children{1}.children{9}.attributes;
        midnight_highclouds = product.children{idx}.children{1}.children{10}.attributes;
        midnight_dptemp = product.children{idx}.children{1}.children{11}.attributes;
        
        midnight_cloud_percentage = str2num(product.children{idx}.children{1}.children{6}.attributes.percent);
        



    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, morning_str)
        
        morning_temp = product.children{idx}.children{1}.children{1}.attributes;
        morning_winddir = product.children{idx}.children{1}.children{2}.attributes;
        morning_windspeed = product.children{idx}.children{1}.children{3}.attributes;
        morning_humidity = product.children{idx}.children{1}.children{4}.attributes;
        morning_pressure = product.children{idx}.children{1}.children{5}.attributes;
        morning_cloudiness = product.children{idx}.children{1}.children{6}.attributes;
        morning_fog = product.children{idx}.children{1}.children{7}.attributes;
        morning_lowclouds = product.children{idx}.children{1}.children{8}.attributes;
        morning_medclouds = product.children{idx}.children{1}.children{9}.attributes;
        morning_highclouds = product.children{idx}.children{1}.children{10}.attributes;
        morning_dptemp = product.children{idx}.children{1}.children{11}.attributes;
        
        morning_cloud_percentage = str2num(product.children{idx}.children{1}.children{6}.attributes.percent);
        
    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, midday_str)
        
        midday_temp = product.children{idx}.children{1}.children{1}.attributes;
        midday_winddir = product.children{idx}.children{1}.children{2}.attributes;
        midday_windspeed = product.children{idx}.children{1}.children{3}.attributes;
        midday_humidity = product.children{idx}.children{1}.children{4}.attributes;
        midday_pressure = product.children{idx}.children{1}.children{5}.attributes;
        midday_cloudiness = product.children{idx}.children{1}.children{6}.attributes;
        midday_fog = product.children{idx}.children{1}.children{7}.attributes;
        midday_lowclouds = product.children{idx}.children{1}.children{8}.attributes;
        midday_medclouds = product.children{idx}.children{1}.children{9}.attributes;
        midday_highclouds = product.children{idx}.children{1}.children{10}.attributes;
        midday_dptemp = product.children{idx}.children{1}.children{11}.attributes;        

        midday_cloud_percentage = str2num(product.children{idx}.children{1}.children{6}.attributes.percent);
        
    elseif strcmp(clocktime_str_from, clocktime_str_to) == 1 && strcmp(clocktime_str_from, evening_str)
        
        evening_temp = product.children{idx}.children{1}.children{1}.attributes;
        evening_winddir = product.children{idx}.children{1}.children{2}.attributes;
        evening_windspeed = product.children{idx}.children{1}.children{3}.attributes;
        evening_humidity = product.children{idx}.children{1}.children{4}.attributes;
        evening_pressure = product.children{idx}.children{1}.children{5}.attributes;
        evening_cloudiness = product.children{idx}.children{1}.children{6}.attributes;
        evening_fog = product.children{idx}.children{1}.children{7}.attributes;
        evening_lowclouds = product.children{idx}.children{1}.children{8}.attributes;
        evening_medclouds = product.children{idx}.children{1}.children{9}.attributes;
        evening_highclouds = product.children{idx}.children{1}.children{10}.attributes;
        evening_dptemp = product.children{idx}.children{1}.children{11}.attributes;   
        
        evening_cloud_percentage = str2num(product.children{idx}.children{1}.children{6}.attributes.percent);
  
    end
    
    
    % Niederschlag-attribute detektieren für die Tageszeiten
    % mitternachts, morgens, mittags und abends stehen    
    
    if strcmp(clocktime_str_from, evening_str) == 1 && strcmp(clocktime_str_to, midnight_str) == 1
        
        midnight_prec = product.children{idx}.children{1}.children{1}.attributes;
        midnight_prec_value = str2num(product.children{idx}.children{1}.children{1}.attributes.value);
        
    elseif strcmp(clocktime_str_from, midnight_str) == 1 && strcmp(clocktime_str_to, morning_str) == 1
        
        morning_prec = product.children{idx}.children{1}.children{1}.attributes;
        morning_prec_value = str2num(product.children{idx}.children{1}.children{1}.attributes.value);

        
    elseif strcmp(clocktime_str_from, morning_str) == 1 && strcmp(clocktime_str_to, midday_str) == 1
        
        midday_prec = product.children{idx}.children{1}.children{1}.attributes;
        midday_prec_value = str2num(product.children{idx}.children{1}.children{1}.attributes.value);
        

    elseif strcmp(clocktime_str_from, midday_str) == 1 && strcmp(clocktime_str_to, evening_str) == 1
        
        evening_prec = product.children{idx}.children{1}.children{1}.attributes;
        evening_prec_value = str2num(product.children{idx}.children{1}.children{1}.attributes.value);
        
    
    end
    
    
end



%--------------------Licence ---------------------------------------------
% Copyright (c) <2014> Laura Hartog, Franz Wichert
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