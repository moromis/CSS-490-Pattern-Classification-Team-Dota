american = csvread('allamerican.csv');
asian = csvread('allasian.csv');
european = csvread('alleuropean.csv');

numamericancars = rows(american);
numasiancars = rows(asian);
numeuropeancars = rows(european);

data{1} = american(1:numamericancars, 3:10);
data{2} = asian(1:numasiancars, 3:10);
data{3} = european(1:numeuropeancars, 3:10);