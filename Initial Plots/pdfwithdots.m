
function pdfwithdots (data, nregions, nfeatures, regionnames, featurenames, featureunits)

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
        
        plot(type(:,i),0,colors{j});
        
        hold off;
        
        [x_label, ERRMSG] = sprintf('%s (%s)',featurenames{i + 1},featureunits{i + 1}); 
        xlabel(x_label);
        ylabel('Probability Density'); 
        
        title(featurenames{i - 1});
        
        legend(regionnames, 'location', 'northoutside', 'orientation', 'horizontal');
        
        plotname = genvarname('densityplotwithdotdiagram', exclusions);
        exclusions{i} = plotname;
        print(plotname, '-dpng');
        
        close;
        
      end
    end  
        

end
