function void = histogram_maker(region, feature)


  if(region == 1)
    featureMatrix = csvread('allamerican.csv');
  elseif(region == 2)
    featureMatrix = csvread('allasian.csv');
  else
    featureMatrix = csvread('alleuropean.csv');
  endif
  
  featureColumn = featureMatrix(:, feature + 2);
  
  minFeatureValue = min(featureColumn);
  maxFeatureValue = max(featureColumn);
  range = maxFeatureValue - minFeatureValue;

#calculates the interval and x limits
intervels = range / sqrt(length(featureColumn));
startmid = minFeatureValue + intervels / 2;
endmid = maxFeatureValue - intervels / 2;


switch (region)
  case 1
    regionName = "American";
  case 2
     regionName = "Asian";
  otherwise
     regionName = "European";
endswitch

switch (feature)
  case 1
    featureName = "Maximum Horsepower";
    unit = "Brake Horse Power";
  case 2
     featureName = "Maximum Torque";
     unit = "lb/ft";
  case 3
     featureName = "Fuel Tank Capacity";
     unit = "Gallons";
  case 4
     featureName = "Curb Weight";
     unit = "lbs";
  case 5
     featureName = "Top Speed";
     unit = "MPH";
  case 6
     featureName = "Length";
     unit = "Inches";
  case 7
     featureName = "Width";    
     unit = "Inches";
  otherwise
     featureName = "Height";
     unit = "Inches";
endswitch

histogramTitle = [regionName, " ", featureName, " Histogram"];
#displays and saves histogram
hist(featureColumn, startmid:intervels:endmid)
xlim([minFeatureValue maxFeatureValue])
title (histogramTitle);
xlabel (unit);
ylabel ("Frequency");
print(histogramTitle, 'jpeg');

endfunction
