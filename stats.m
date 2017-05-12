american = csvread('allamerican.csv',0,2);
asian = csvread('allasian.csv',0,2);
european = csvread('alleuropean.csv',0,2);

[numamericancars_row, numamericancars_col] = size(american);
[numasiancars_row, numasiancars_col] = size(asian);
[numeuropeancars_row, numeuropeancars_col] = size(european);

numeuropeancars_row


