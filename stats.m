%clear everything from previous runs
clear all;

%read in the data files
american = csvread('allamerican.csv',1,3);
asian = csvread('allasian.csv',1,3);
european = csvread('alleuropean.csv',1,3);

%get the size (in number of rows) of each of the data sets
numamericancars = rows(american);
numasiancars = rows(asian);
numeuropeancars = rows(european);

%define some constants
nfeatures = 8;
nregions = 3;

%define some arrays to name plots and their axes and legends
regionnames = { 'American Cars', 'Asian Cars', 'European Cars' };
featurenames = { 'Horsepower', 'Maximum Torque', 'Fuel Tank Capacity', 'Curb Weight', 'Top Speed', 'Length', 'Width', 'Height' };
featureunits = { 'BHP', 'lb/ft', 'US gallons', 'lbs', 'MPH', 'inches', 'inches', 'inches' };

%put all three datasets into a cell matrix, so we can iterate through them
data{1} = american(1:numamericancars, 3:10);
data{2} = asian(1:numasiancars, 3:10);
data{3} = european(1:numeuropeancars, 3:10);

%plot and print PDFs for the datasets
%mypdf(data, nregions, nfeatures, regionnames, featurenames, featureunits);

%plot and print PDFs with dot diagrams at the bottom
pdfwithdots(data, nregions, nfeatures, regionnames, featurenames, featureunits);

%create covariance matrices for the datasets
for i = 1:nfeatures
  for j = 1:nfeatures
    americancov(i,j) = cov(data{1}(:,i), data{1}(:,j));
  end
end

for i = 1:nfeatures
  for j = 1:nfeatures
    asiancov(i,j) = cov(data{1}(:,i), data{1}(:,j));
  end
end

for i = 1:nfeatures
  for j = 1:nfeatures
    europeancov(i,j) = cov(data{1}(:,i), data{1}(:,j));
  end
end

%find a population mean for each of the datasets
for i = 1:nfeatures
  americanpopmean(:,i) = mean(american(:,i));
end

for i = 1:nfeatures
  asianpopmean(:,i) = mean(asian(:,i));
end

for i = 1:nfeatures
  europeanpopmean(:,i) = mean(european(:,i));
end

%grab a random sample, using 20% of the population as a sufficiently large sample
%space to determine if CLT applies

americansamplesize = (20/100) * numamericancars;

asiansamplesize = (20/100) * numasiancars;

europeansamplesize = (20/100) * numeuropeancars;

for i = 1:americansamplesize
  americansample(i,:) = american(floor(rand * numamericancars + 1),:);
end

for i = 1:asiansamplesize
  asiansample(i,:) = asian(floor(rand * numasiancars + 1),:);
end

for i = 1:europeansamplesize
  europeansample(i,:) = european(floor(rand * numeuropeancars + 1),:);
end

%find the sample mean for all the datasets, based on the sample datasets we just found
for i = 1:nfeatures
  americansamplemean(:,i) = mean(americansample(1:americansamplesize,i));
end

for i = 1:nfeatures
  asiansamplemean(:,i) = mean(asiansample(1:asiansamplesize,i));
end

for i = 1:nfeatures
  europeansamplemean(:,i) = mean(europeansample(1:europeansamplesize,i));
end