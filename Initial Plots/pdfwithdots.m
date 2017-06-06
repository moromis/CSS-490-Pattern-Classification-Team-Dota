
function pdfwithdots (data, nregions, nfeatures, typenames, featurenames, featureunits)

  exclusions = {'densityplotwithdotdiagram'};
  
  colors = {'r', 'g', 'c'};
 
    for i = 2:nfeatures + 1
      
      for j = 1:nregions
        
        type = data{j};
        
        mu = mean(type(:,i)); 
        st = std(type(:,i)); 
        x = linspace(mu-3*st,mu+3*st,100);
        y = normpdf(x,mu,st);

        hold on;
        
        plot(x,y,colors{j});
        
        zs = zeros(size(type,1), 1);
        
        scatter(type(:,i),zs,50,'.',colors{j});
        
        hold off;
        
        [x_label, ~] = sprintf('%s (%s)',featurenames{i - 1},featureunits{i - 1}); 
        xlabel(x_label);
        ylabel('Probability Density'); 
        
        [printtitle, ~] = sprintf('%s - %s',featurenames{i - 1},typenames{j});
        title(printtitle);
        
        plotname = genvarname('densityplotwithdotdiagram', exclusions);
        exclusions{i} = plotname;
        print(plotname, '-dpng');
        
        close;
        
      end
      
    end  
        

end
