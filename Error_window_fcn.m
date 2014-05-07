function Error_window_fcn(handle, event)
    data = guidata(handle);
    value_start = get(data.startdate_popup, 'value');
    value_end = get(data.enddate_popup, 'value');
    
    if value_start > value_end
        
        warndlg('Obacht! Enddate can not be smaller than startdate','Obacht!');
        set(data.weatherupdate_push, 'enable', 'off');
    
    else
        
        set(data.weatherupdate_push, 'enable', 'on');
    
    end
    
end