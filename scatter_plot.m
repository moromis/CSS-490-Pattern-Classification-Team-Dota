

function scatter_plot(file_name)
    v_data = csvread(file_name,0,2);
    [v_row, v_col] = size(v_data);
    
    v_row,v_col
    
    %get the feature colums
    
    max_hp = v_data(:,1)
    max_trq = v_data(:,2)
    fuel_t = v_data(:,3)
    curb_w = v_data(:,4)
    top_sp = v_data(:,5)
    length = v_data(:,6)
    width = v_data(:,7);
    height = v_data(:,8);
    
    figure
    
    
       
load('iris.mat','setosa');
load('iris.mat','versicolor');
load('iris.mat','virginica');

%%%%%%% for setosa %%%%%%%%
setosaPW = setosa(:,1);
setosaPL = setosa(:,2);
setosaSW = setosa(:,3);
setosaSL = setosa(:,4);

%%%%%%% for versicolor %%%%%
versiPW = versicolor(:,1);
versiPL = versicolor(:,2);
versiSW = versicolor(:,3);
versiSL = versicolor(:,4);


%%%%%%% for virginica  %%%%%
virginPW = virginica(:,1);
virginPL = virginica(:,2);
virginSW = virginica(:,3);
virginSL = virginica(:,4);

f = figure;
p = uipanel('Parent',f,'BorderType','line');
p.Title = 'My Supa Title';
p.TitlePosition = 'centertop';
p.FontSize = 13;
p.FontWeight = 'bold';

f = figure;

%%%%% Petal Width with Petal Length
scatter(setosaPW,setosaPL,'r');
hold on
scatter(versiPW, versiPL, 'k');
scatter(virginPW, virginPL, 'b'); 
%title('Petal Width', 'FontSize',20);

figure;
%%%%%% petal width with Sepal Width
scatter(setosaPW,setosaSW,'r');
hold on
scatter(versiPW, versiSW, 'k');
scatter(virginPW, virginSW, 'b'); 
title('Petal Width', 'FontSize',20);

figure;
%%%%%% petal width with Sepal Length
scatter(setosaPW,setosaSL,'r');
hold on
scatter(versiPW, versiSL, 'k');
scatter(virginPW, virginSL, 'b'); 

figure;
%%%%%% petal Length with Sepal Width
scatter(setosaPL,setosaSW,'r');
hold on
scatter(versiPL, versiSW, 'k');
scatter(virginPL, virginSW, 'b'); 
title('Petal Length','FontSize',20);
box on

figure;
%%%%%% Petal Length to Sepal Length
scatter(setosaPL,setosaSL,'r');
hold on
scatter(versiPL, versiSL, 'k');
scatter(virginPL, virginSL, 'b'); 
box on

figure;
%%%%%% Sepal Width to Sepal Length
scatter(setosaSW,setosaSL,'r');
hold on
scatter(versiSW, versiSL, 'k');
scatter(virginSW, virginSL, 'b'); 
title('Sepal Width','FontSize',20);
box on

legend('show','setosa','versicolor','virginica');
    
   
    
 
    
end


