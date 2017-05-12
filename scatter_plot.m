

function scatter_plot(file_name)
    v_data = csvread(file_name,0,2);
    [v_row, v_col] = size(v_data);
    
    v_row,v_col
    
    %get the feature colums
    
    max_hp = v_data(:,1)
    max_trq = v_data(:,2)
    fuel_t = v_data(:,3)
    curb_w = v_data(:,4)
    top_sp = v_data(:,5)
    length = v_data(:,6)
    width = v_data(:,7);
    height = v_data(:,8);
    

    
 
    
end


