clear all;

%load the data
dataset1 = csvread('allamerican.csv',1,2);
dataset2 = csvread('alleuropean.csv',1,2);
dataset3 = csvread('allasian.csv',1,2);

dataset2 = sortrows(dataset2, 9);
dataset2 = dataset2(1:2500,1:8);


%define some constants
nfeatures = 8;

dataset = cat(1, dataset1, dataset2, dataset3);


%make a set of strings for the names of the axes of the scatter plots
columnnames = {'Max Horsepower', 
                'Max Torque', 
                'Fuel Tank Capacity', 
                'Curb Weight', 
                'Top Speed',
                'Length',
                'Width',
                'Height'};

%get the size of the data, the number of columns is the number of features,
%while the number of rows is the number of observations.
[datasetrows, datasetcolumns] = size(dataset);

%produce some 2D scatter plots before we do PCA -- we also compute a covariance
%matrix, a correlation matrix, and a means vector while we have our unprocessed
%original space data.
%[covmatrix, corrmatrix, means] = produce2DGraphs(datasetnolabel, datasetcolumns, datasetrows, columnnames);

%preprocess the data (mean center and scale)
[Ur, U, S, V] = prepareData(dataset, datasetcolumns, datasetrows);

%produce the scree plots, loading vectors, and 3D PC scatter plots
producePCAGraphs(Ur, U, S, V, datasetcolumns, datasetrows);

% %reduce the dimensions of the data
% reduceddata = datasetnolabel(:,1:3);
% 
% %print a 3D plot of the reduced dimension space
% figure; 
% scatter3(reduceddata(:,1), reduceddata(:,2), reduceddata(:,3), 225, 'r', '.');
% xlabel(columnnames(1,1));
% ylabel(columnnames(2,1));
% zlabel(columnnames(3,1));
% title('Transformed Space');
% 
% print('TransformedSpaceScatterPlot', '-dpng');
% 
% close;

