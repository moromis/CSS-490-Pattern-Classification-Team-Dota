%preforms singular value decomposition 
%and graphs three types of plots for Principle Component Analysis
%assumes that all files are within directory

pkg load io

%clears the command history
clear all;

%loads flower observations into three matrices for each flower type: setosa, virginica, and versicolor
countryDataWithBadData = csvread('alleuropean.csv');

countryData = countryDataWithBadData(:, 3:10);

save hw3.mat countryData

%-------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%          CONSTANTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------------

%define constants

%this is the original number of columns representing original features, two for petal and two for sepal
nFeatures = columns(countryData);

nObservations = rows(countryData);


%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%      Covariance Matrix      %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

meanVector = mean(countryData);


for i = 1:nFeatures
  for j = 1:nFeatures
    covarianceMatrix(i,j) = cov(countryData(:,i), countryData(:,j));
    correlationMatrix(i,j) = corr(countryData(:,i), countryData(:,j));
  endfor
endfor

save -append hw3.mat meanVector covarianceMatrix correlationMatrix

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%      2D SCATTER PLOTS       %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------



%plot and save 2D scatter plots for each possible unique combination of 2 features 
i = 1;
while(i != 5)
  j = i + 1;
  
  switch (i)
  case 1
    xFeatureName = "Liquor Consumtion";
  case 2
     xFeatureName = "Wine Consumption";
  case 3
     xFeatureName = "Beer Consumption";
  case 4
     xFeatureName = "Life Expectancy";
  case 5
     xFeatureName = "Heart Disease Rate";
  endswitch
  while(j != 6)
  
  switch (j)
  case 1
    yFeatureName = "Liquor Consumtion";
  case 2
     yFeatureName = "Wine Consumption";
  case 3
     yFeatureName = "Beer Consumption";
  case 4
     yFeatureName = "Life Expectancy";
  case 5
     yFeatureName = "Heart Disease Rate";
  endswitch
 
    plotName = [xFeatureName " vs " yFeatureName];
    p = plot(countryData(:,i), countryData(:,j), 'o');
    xlabel (xFeatureName);
    ylabel (yFeatureName);
    title(plotName);
    print(plotName, "-dpng");
    j++;
  endwhile
  i++;
endwhile



%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%        PREPARE DATA         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%prepares the data by centering and scaling data
X = prepareData(countryData, nFeatures, nObservations);

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%            SVD              %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------
  
%run svd to calculate scores matrix U, covariance matrix (diagonal) S, and loading matrix V
[U, S, V] = svd(X, 0);


%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%         NORMALIZE S         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------
%normalize S so that total the wieght of all priniciple components in S culminate to 1

%variable for sum of all values in covariance matrix s (after each element in S has been squared)
Ssum = 0;

%square each element in the matrix and concurrently add it to the sum of S
for i = 1:nFeatures
  
  S(i,i) = S(i,i)^2;
  Ssum += S(i,i);
  
endfor

%now that the sum has of S has been calculated, 
%normalize each element in S by divideding it by the sum of S, 
%so that each element is a fraction of the sum total sum add they culminate to 1 
for i = 1:nFeatures
  
  S(i,i) = S(i,i) / Ssum;
  
endfor

%calculates Ur after normalizing S
Ur = U * S;

save -append hw3.mat U V S

%makes S a row vector with all diagonal values, and transposes it into a column vector
S = sum(S);
S = transpose(S);

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%        SCREE PLOTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%variable to track the culmination of the values in S, starting with the greatest value of S
CumSSum = 0;

%for each priniciple component wieght in S, starting with the greatest, culminate and track 
for i = 1:nFeatures
  
  CumSSum += S(i);
  CumulativeS(i) = CumSSum;
  
endfor

%graphing scree plots 
%scree plot from S
figure; 
plot(S,'x:b'); 
grid; 
title('Scree Plot');
print('Scree Plot', "-dpng");

%culminative scree plot from culmination tracking
figure; 
plot(CumulativeS,'x:r'); 
grid; 
title('Scree Plot Cummulative');
print('Scree Plot Cummulative', "-dpng");

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%      LOADING VECTORS        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%square each element in V and assigns each element to the absolute value of itself
for i=1:nFeatures 
    for j=1:nFeatures 
        Vsquare(i,j) = V(i,j)^2; 
        if V(i,j)<0 
            Vsquare(i,j) = Vsquare(i,j)*-1; 
        else  
            Vsquare(i,j) = Vsquare(i,j)*1; 
        end 
    end 
end

%graph loading vectors from V
for i = 1:nFeatures
  figure; 
  bar(Vsquare(:,i),0.5); 
  grid; 
  ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
  ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
  axis([0 nFeatures ymin ymax]); 
  xlabel('Feature index'); 
  ylabel('Importance of feature'); 
  [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
  title(chart_title);
  print(chart_title, "-dpng");
endfor


%{



%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------


%starting unique combination values for three of the four possible principle components  
x = 1;
y = 2;
z = 3;

%loops through each unique combination of three of the four possible priniciple components 
%for plotting observations using three of the principle components for each unique combination
%principle component combinations used for plotting are in the order (principle componets numbered by column number of U)
%1st, 2nd, and 3rd principle components
%1st, 2nd, and 4th principle components
%1st, 3rd, and 4th principle components
%2nd, 3rd, and 4th principle componets


while(x < nFeatures - 1)

  switch (x)
  case 1
    xPC = "PC1";
    xFeatureName = "Liquor Consumtion";
  case 2
    xPC = "PC2";
    xFeatureName = "Wine Consumption";

  case 3
    xPC = "PC3";
    xFeatureName = "Beer Consumption";

  case 4
    xPC = "PC4";
    xFeatureName = "Life Expectancy";

  case 5
    xPC = "PC5";
    xFeatureName = "Heart Disease Rate";

  endswitch
  
  switch (y)
  case 1
    yPC = "PC1";
    yFeatureName = "Liquor Consumtion";
  case 2
    yPC = "PC2";
    yFeatureName = "Wine Consumption";

  case 3
    yPC = "PC3";
    yFeatureName = "Beer Consumption";

  case 4
    yPC = "PC4";
    yFeatureName = "Life Expectancy";

  case 5
    yPC = "PC5";
    yFeatureName = "Heart Disease Rate";

  endswitch
  
  switch (z)
  case 1
    zPC = "PC1";
    zFeatureName = "Liquor Consumtion";
  case 2
    zPC = "PC2";
    zFeatureName = "Wine Consumption";

  case 3
    zPC = "PC3";
    zFeatureName = "Beer Consumption";

  case 4
    zPC = "PC4";
    zFeatureName = "Life Expectancy";

  case 5
    zPC = "PC5";
    zFeatureName = "Heart Disease Rate";

  endswitch
      
  
  %plot observations for principle component combination at this point for U
  figure; 
  plotName = ["U " xPC " vs " yPC " vs " zPC];
  scatter3(U(:,x), U(:,y), U(:,z), 'x'); 
  axis([-1 1 -1 1 -1 1]);
  hold on; 
  xlabel(xPC);
  ylabel(yPC);
  zlabel(zPC);
  title(plotName);
  print(plotName, "-dpng");
  
  %plot observations for principle component combination at this point for Ur
  figure; 
  plotName = ["Ur " xPC " vs " yPC " vs " zPC];
  scatter3(Ur(:,x), Ur(:,y), Ur(:,z), "x"); 
  axis([-1 1 -1 1 -1 1]);
  hold on; 
  xlabel(xPC);
  ylabel(yPC);
  zlabel(zPC);
  title(plotName);
  print(plotName, "-dpng");
  
   %plot observations for principle component combination at this point for U
  figure; 
  plotName = [ xFeatureName " vs " yFeatureName " vs " zFeatureName];
  scatter3(countryData(:,x), countryData(:,y), countryData(:,z), 'x'); 
  hold on; 
  xlabel(xFeatureName);
  ylabel(yFeatureName);
  zlabel(zFeatureName);
  title(plotName);
  print(plotName, "-dpng");
  
  
  if(z == nFeatures)
    if(y == nFeatures - 1)
      x++;
      y = x + 1;
      z = y + 1;
    else 
       y++;
       z = y + 1;
       
    endif
  else
    z++;
    
  endif
  
endwhile


%}

