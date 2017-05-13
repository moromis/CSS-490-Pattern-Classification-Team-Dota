
function mypdf (data, nregions, nfeatures, regionnames, featurenames, featureunits)
  
  exclusions = {"densityplot"};
  
  for i = 1:nfeatures
    
    figure;
    
    for j = 1:nregions
      
      region = data{j};
      
      mu = mean(region(:,i)); 
      st = std(region(:,i)); 
      x = linspace(mu-3*st,mu+3*st,100);
      y = normpdf(x,mu,st);
      
      hold on;
      
      plot(x,y);
      
    endfor
    
    [x_label, ERRMSG] = sprintf('%s (%s)',featurenames{i},featureunits{i}); 
    xlabel(x_label);
    ylabel('Probability Density'); 
    
    title(featurenames{i});
    
    legend(regionnames, "location", "northoutside", "orientation", "horizontal");
    
    hold off;
    
    plotname = genvarname("densityplot", exclusions);
    exclusions{i+1} = plotname;
    print(plotname, "-dpng");
    
  endfor  

endfunction
