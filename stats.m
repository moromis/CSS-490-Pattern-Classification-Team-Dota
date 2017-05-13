clear all;

american = csvread('allamerican.csv');
asian = csvread('allasian.csv');
european = csvread('alleuropean.csv');

numamericancars = rows(american);
numasiancars = rows(asian);
numeuropeancars = rows(european);

nfeatures = 8;
nregions = 3;
regionnames = { "American Cars", "Asian Cars", "European Cars" };
featurenames = { "Horsepower", "Maximum Torque", "Fuel Tank Capacity", "Curb Weight", "Top Speed", "Length", "Width", "Height" };
featureunits = { "BHP", "lb/ft", "US gallons", "lbs", "MPH", "inches", "inches", "inches" };

data{1} = american(1:numamericancars, 3:10);
data{2} = asian(1:numasiancars, 3:10);
data{3} = european(1:numeuropeancars, 3:10);

mypdf(data, nregions, nfeatures, regionnames, featurenames, featureunits);

pdfwithdots(data, nregions, nfeatures, regionnames, featurenames, featureunits);