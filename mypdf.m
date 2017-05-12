
function mypdf (data, nregions, nfeatures, featurenames)
  
  datasize = columns(data);
  
  for i = 1:columns
    for j = 1:nfeatures
    
    mu = mean(data{i(:,j)}); 
    st = std(data{i(:,j)}); 
    x = linspace(mu-3*st,mu+3*st,100);
    
    subplot(j,nfeatures);
    
    plot(x, normpdf(x,mu,st));
    
    [x_label, ERRMSG] = sprintf('Feature %d',i); 
    xlabel(x_label); 
    
    ylabel('Probability Density'); 
    
    [chart_title, ERRMSG] = sprintf('Feature %d',i); 
    title(chart_title);
    
    legend(featurenames, "location", "northoutside", "orientation", "horizontal");
  
    endfor
  endfor  

endfunction
