
function pdfwithdots (data, nregions, nfeatures, regionnames, featurenames, featureunits)

  clf;
  cla;

  exclusions = {"densityplotwithdotdiagram"};
  
  colors = {"r", "g", "c"};
  
  
  for i = 1:nfeatures
      
      for j = 1:nregions
        
        region = data{j};
        
        mu = mean(region(:,i)); 
        st = std(region(:,i)); 
        x = linspace(mu-3*st,mu+3*st,100);
        y = normpdf(x,mu,st);

        hold on;
        plot(x,y,colors{j});
        plot(region(:,i),0,colors{j}, "markersize", 10);
        hold off;
        
        [x_label, ERRMSG] = sprintf('%s (%s)',featurenames{i},featureunits{i}); 
        xlabel(x_label);
        ylabel('Probability Density'); 
        
        title(featurenames{i});
        
        plotname = genvarname("densityplotwithdotdiagram", exclusions);
        exclusions{i+1} = plotname;
        print(plotname, "-dpng");
        
        close;
        
      endfor
    endfor  
        

endfunction
