function [colors]=getColor(ti)
% treatments = {'untreated', ...
%               '10nM Pacli', ...
%               
%               'Disu H (1uM)', ...
%               'Disu M (300nM)', ...
%               'Disu L (100nM)', ...
%               
%               'Pacli+ Disu H', ...
%               'Pacli+ Disu M', ...
%               'Pacli+ Disu L'};

          
% green = [0,133,66]/255; white = [1,1,1]; 
red = [176,36,24]/255; blue = [48,110,186]/255; 
% purple = [112,48,160]/255; 
bb = 0.3; black = [bb,bb,bb];

blueRange = ColorRange(black,blue,4);

mediumBlue = [51, 102, 255]/255;
lightBlue = [51, 204, 255]/255;
darkBlue = [0, 51, 153]/255;
blueRange=[black;lightBlue;mediumBlue;darkBlue];


% disu is blue
% pacl is red

    if (ti == 1)
        colors=[black;black];
    elseif (ti == 2)
        colors=[red;red];     
    elseif (ti == 3)
        colors=[blueRange(4,:);blueRange(4,:)];
    elseif (ti == 4)
        colors=[blueRange(3,:);blueRange(3,:)];
    elseif (ti == 5)
        colors=[blueRange(2,:);blueRange(2,:)];    
    elseif (ti == 6)
        colors=[red;blueRange(4,:)];
    elseif (ti == 7)
        colors=[red;blueRange(3,:)];
    elseif (ti == 8)
        colors=[red;blueRange(2,:)];        
    end
end