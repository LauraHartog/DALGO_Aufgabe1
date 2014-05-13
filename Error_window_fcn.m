function Error_window_fcn(handle, event)
  %ERROR_WINDOW_FCN displays warning window if enddate smaller startdate
  %   ERROR_WINDOW_FCN(HANDLE, EVENT) checks if the chosen enddate of the 
  %   popup window of the script weather_forecast_main_script is larger
  %   than the chosen startdate. If this is the case there will popup a
  %   warning window. If this is not the case nothing will happen. This
  %   function only works in combination with the script
  %   weather_forecast_main_script.
  
  % Copyright 2014 Laura Hartog, Franz Wichert
  
    data = guidata(handle);
    value_start = get(data.startdate_popup, 'value');
    value_end = get(data.enddate_popup, 'value');
    
    if value_start > value_end
        
        warndlg('enddate can not be smaller than startdate','Warning!');
        set(data.weatherupdate_push, 'enable', 'off');
    
    else
        
        set(data.weatherupdate_push, 'enable', 'on');
    
    end
    
end