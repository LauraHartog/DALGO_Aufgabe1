% Skript mit welchem eine xml-Datei von der Seite 
% http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889
% heruntergeladen, verarbeitet und geplottet werden kann.
%
% Author: L. Hartog, F. Wichert (c) IHA @ Jade Hochschule applied licence see EOF 
% Version History:
% Ver. 0.01 initial create (empty) 18-Apr-2014 			 Initials (eg. JB)

clear;
close all;
clc;

%%%%%%%%%%%%%%----Nicht-so-wichtig----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Websites
% met.no: http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889
%
% wonderground.com: http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.json
% API-Key-Franzus: a6e1ba8ffec4fb4a
%
% path_met_xml = urlwrite('http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889', 'weather_met.xml');
%
% path_wg_xml = urlwrite('http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.xml','weather_wg.xml');
% path_wg_json = urlwrite('http://api.wunderground.com/api/a6e1ba8ffec4fb4a/forecast10day/q/Germany/Oldenburg.json','weather_wg.json');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







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

midnight_prec = NaN;
morning_prec = NaN;
midday_prec = NaN;
evening_prec = NaN;

midnight_temp = NaN;
morning_temp = NaN;
midday_temp = NaN;
evening_temp = NaN;

midnight_winddir = NaN;
morning_winddir = NaN;
midday_winddir = NaN;
evening_winddir = NaN;

midnight_windspeed = NaN;
morning_windspeed = NaN;
midday_windspeed = NaN;
evening_windspeed = NaN;

midnight_humidity = NaN;
morning_humidity = NaN;
midday_humidity = NaN;
evening_humidity = NaN;

midnight_pressure = NaN;
morning_pressure = NaN;
midday_pressure = NaN;
evening_pressure = NaN;

midnight_cloudiness = NaN;
morning_cloudiness = NaN;
midday_cloudiness = NaN;
evening_cloudiness = NaN;

midnight_fog = NaN;
morning_fog = NaN;
midday_fog = NaN;
evening_fog = NaN;

midnight_lowclouds = NaN;
morning_lowclouds = NaN;
midday_lowclouds = NaN;
evening_lowclouds = NaN;

midnight_medclouds = NaN;
morning_medclouds = NaN;
midday_medclouds = NaN;
evening_medclouds = NaN;

midnight_highclouds = NaN;
morning_highclouds = NaN;
midday_highclouds = NaN;
evening_highclouds = NaN;

midnight_dptemp = NaN;
morning_dptemp = NaN;
midday_dptemp = NaN;
evening_dptemp = NaN;


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
    % und einen neuen Tag im daystruct �ffnet
    % Problem: Der letzte Tag wird nicht mehr in das Day-struct
    % geschrieben; Dies ist jedoch nicht weiter schlimm, da am Ende eh nur
    % 7 Tage ausgewertet werden.
 
    
    if strcmp(clocktime_str_from, midnight_str) && strcmp(clocktime_str_to,...
            midnight_str) && (strcmp(date_str_from, prev_date_str_from) == 0)
        
        daystruct(day_nr) = struct('date', prev_date_str_from,...
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
    
    
    % Verschiedene Wettereigenschaften-attribute detektieren f�r die
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
  
    end
    
    
    % Niederschlag-attribute detektieren f�r die Tageszeiten
    % mitternachts, morgens, mittags und abends stehen    
    
    if strcmp(clocktime_str_from, evening_str) == 1 && strcmp(clocktime_str_to, midnight_str) == 1
        
        midnight_prec = product.children{idx}.children{1}.children{1}.attributes;
        
    elseif strcmp(clocktime_str_from, midnight_str) == 1 && strcmp(clocktime_str_to, morning_str) == 1
        
        morning_prec = product.children{idx}.children{1}.children{1}.attributes;
        
    elseif strcmp(clocktime_str_from, morning_str) == 1 && strcmp(clocktime_str_to, midday_str) == 1
        
        midday_prec = product.children{idx}.children{1}.children{1}.attributes;

    elseif strcmp(clocktime_str_from, midday_str) == 1 && strcmp(clocktime_str_to, evening_str) == 1
        
        evening_prec = product.children{idx}.children{1}.children{1}.attributes;
    
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUIGUI %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hfig = figure();

set(hfig,'units','normalized','position', [0 0 1 1]);

weatherupdate_control = uicontrol(hfig,'style', 'pushbutton',...
                                'units','normalized',...
                                'position',[0.1 0.1 0.3 0.1],...
                                'string','update weatherdata');
                            

% Einbinden des Startdatums sowie Enddatums der Wettervorhersage
                            
x_pos_date = 0.02;
y_pos_date = 0.9;
x_size_date = 0.2;
y_size_date = 0.03;
x_distance_date = 0.01;
y_distance_date = 0.01;
                            
startdate_text_control = uicontrol(hfig,'style', 'text',...
                                'units','normalized',...
                                'position',[x_pos_date (y_pos_date + (y_size_date + y_distance_date)) x_size_date y_size_date],...
                                'string','startdate:');              


enddate_text_control = uicontrol(hfig,'style', 'text',...
                                'units','normalized',...
                                'position',[x_pos_date + (x_size_date + x_distance_date) y_pos_date + (y_size_date + y_distance_date), x_size_date y_size_date],...
                                'string','enddate:'); 
                            
startdate_popup_control = uicontrol(hfig,'style', 'popupmenu',...
                                'units','normalized',...
                                'position',[x_pos_date y_pos_date x_size_date y_size_date],...
                                'string',{daystruct(1).date,...
                                daystruct(2).date, daystruct(3).date, daystruct(4).date...
                                daystruct(5).date, daystruct(6).date, daystruct(7).date});
                           
enddate_popup_control = uicontrol(hfig, 'style', 'popupmenu',...
                                'units', 'normalized',...
                                'position', [x_pos_date + (x_size_date + x_distance_date) y_pos_date x_size_date y_size_date],...
                                'string', {daystruct(1).date,...
                                daystruct(2).date, daystruct(3).date,daystruct(4).date...
                                daystruct(5).date, daystruct(6).date,daystruct(7).date});
                            
% Einbinden der Checkboxen  

weather_components = fieldnames(daystruct);

x_pos_checkbox = 0.8;
y_pos_checkbox = 0.8;
x_size_checkbox = 0.2;
y_size_checkbox = 0.02;

y_distance_checkbox = 0.01;

 
weathercomponents_text_control = uicontrol(hfig,'style', 'text',...
                                'units','normalized',...
                                'position',[x_pos_checkbox (y_pos_checkbox+(y_size_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string','weather components:'); 

precipitation_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox y_pos_checkbox x_size_checkbox y_size_checkbox],...
                                'string', weather_components{2});


temp_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{3});
                            

winddir_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-2*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{4});
                            

                            
windspeed_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-3*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{5});
                            

humidity_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-4*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{6});
                            

pressure_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-5*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{7});
                            

cloudiness_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-6*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{8});
                            

fog_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-7*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{9});
                            

lowclouds_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-8*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{10});
                            

medclouds_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-9*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{11});
                            

highclouds_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-10*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{12});
                            

dptemp_checkbox_control = uicontrol(hfig, 'style', 'checkbox',...
                                'units', 'normalized',...
                                'position', [x_pos_checkbox (y_pos_checkbox-11*(y_distance_checkbox + y_size_checkbox))...
                                x_size_checkbox y_size_checkbox],...
                                'string', weather_components{13});
                            
                            
                            
                            
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