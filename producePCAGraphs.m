function producePCAGraphs(Ur, U, S, V, nfeatures, nsamples, featurenames)
  
  %create an exclusions set to write unique filenames for the U scatter plots
  UScatterExclusions = {'UScatterPlot'};
  
  %create an exclusions set to write unique filenames for the Ur scatter plots
  UrScatterExclusions = {'UrScatterPlot'};
  
  %create an exclusions set to write unique filenames for the loading vector plots
  LoadingVectorExclusions = {'LoadingVector'};
  
  %create an exclusions set to write unique filenames for the absolute loading vector plots
  AbsLoadingVectorExclusions = {'AbsLoadingVector'};
  
  %define the size of the markers for the scatter plots
  ScatterMarkerSize = 225;
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%        SCREE PLOTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  %makes S a row vector with all diagonal values, and transposes it into a column vector
  S = sum(S);
  S = transpose(S);
  
  %variable to track the culmination of the values in S, starting with the greatest value of S
  CumSSum = 0;

  %for each priniciple component wieght in S, starting with the greatest, culminate and track 
  for i = 1:nfeatures
    
    CumSSum = CumSSum + S(i);
    CumulativeS(i) = CumSSum;
    
  end

  %graphing scree plots 
  %scree plot from S
  figure; 
  plot(S,'x:b'); 
  grid; 
  title('Scree Plot');
  xlabel('Principal Component');
  ylabel('Eigenvalue');
  
  print('Scree Plot', '-dpng');
  
  close;

  %culminative scree plot from culmination tracking
  figure; 
  plot(CumulativeS,'x:r'); 
  grid; 
  title('Scree Plot Cumulative');
  xlabel('Principal Component');
  ylabel('Eigenvalue');
  
  print('Cumulative Scree Plot', '-dpng');
  
  close;
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%      LOADING VECTORS        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  %square each element in V and assigns each element to the absolute value of itself
  for i=1:nfeatures 
      for j=1:nfeatures 
          Vsquare(i,j) = V(i,j)^2; 
          if V(i,j)<0 
              Vsquare(i,j) = Vsquare(i,j)*-1; 
          else  
              Vsquare(i,j) = Vsquare(i,j)*1; 
          end 
      end 
  end
  
  %graph loading vectors from V
  for i = 1:nfeatures
    
    figure; 
    bar(Vsquare(:,i),0.5); 
    grid; 
    ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
    ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title);
    
    plotname = genvarname('LoadingVector', LoadingVectorExclusions);
    LoadingVectorExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
  end

  %graph absolute loading vectors from V
  for i = 1:nfeatures
    
    figure; 
    bar(abs(Vsquare(:,i)),0.5); 
    grid; 
    ymin = 0; 
    ymax = max(abs(Vsquare(:,i))) + max(abs(Vsquare(:,i))/10); 
    axis([0 nfeatures ymin ymax]); 
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title);
    
    plotname = genvarname('AbsLoadingVector', AbsLoadingVectorExclusions);
    AbsLoadingVectorExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
  end
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  diminsionNames = {'PC1 ', 'PC2 ', 'PC3 ', 'PC4 ', 'PC5 '};
  titleNames = {'U ', 'Ur '};

  %starting unique combination values for three of the four possible principle components  
  x = 1;
  y = 2;
  z = 2;
  i = 1;

  %loops through each unique combination of three of the four possible priniciple components 
  %for plotting observations using three of the principle components for each unique combination
  %principle component combinations used for plotting are in the order (principle componets numbered by column number of U)
  %1st, 2nd, and 3rd principle components
  %1st, 2nd, and 4th principle components
  %1st, 3rd, and 4th principle components
  %2nd, 3rd, and 4th principle components
  %2nd, 3rd, and 5th
  %2nd, 4th, and 5th
  %3rd, 4th, and 5th
  while(x ~= nfeatures - 2)
    
    %increments through each unique principle component combination
    if(z ~= nfeatures)
      z = z + 1;
    elseif(y ~= nfeatures - 1)
      y = y + 1;
    else
      x = x +1;
    end  
    
    %plot observations for principle component combination at this point for U
    figure; 
    scatter3(U(:,x), U(:,y), U(:,z), ScatterMarkerSize, 'r', '.');
    xlabel(diminsionNames(1,x));
    ylabel(diminsionNames(1,y));
    zlabel(diminsionNames(1,z));
    title(strcat(titleNames(1,1), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
    axis ([-1 1 -1 1 -1 1]);
    
    plotname = genvarname('UScatterPlot', UScatterExclusions);
    UScatterExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
    %plot observations for principle component combination at this point for Ur
    figure; 
    scatter3(Ur(:,x), Ur(:,y), Ur(:,z), ScatterMarkerSize, 'r', '.');
    xlabel(diminsionNames(1,x));
    ylabel(diminsionNames(1,y));
    zlabel(diminsionNames(1,z));
    title(strcat(titleNames(1,2), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
    axis ([-1 1 -1 1 -1 1]);
    
    plotname = genvarname('UrScatterPlot', UrScatterExclusions);
    UrScatterExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
    i = i + 1;
    
  end
  
end  
