clear all;

%load the data
dataset1 = csvread('allamerican.csv');
dataset2 = csvread('alleuropean.csv');
dataset3 = csvread('allasian.csv');

dataset = cat(1, dataset1(:,3:10), dataset2(:,3:10), dataset3(:,3:10));

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
datasetrows = rows(dataset);
datasetcolumns = columns(dataset);

%get rid of the label columns, we don't need them where we're going
datasetnolabel = dataset(2:datasetrows, 2:datasetcolumns); 

%produce some 2D scatter plots before we do PCA -- we also compute a covariance
%matrix, a correlation matrix, and a means vector while we have our unprocessed
%original space data.
[covmatrix, corrmatrix, means] = produce2DGraphs(datasetnolabel, datasetcolumns - 1, datasetrows - 1, columnnames);

%preprocess the data (mean center and scale)
[Ur, U, S, V] = prepareData(datasetnolabel, datasetcolumns - 1, datasetrows - 1);

%produce the scree plots, loading vectors, and 3D PC scatter plots
producePCAGraphs(Ur, U, S, V, datasetcolumns - 1, datasetrows - 1);

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

