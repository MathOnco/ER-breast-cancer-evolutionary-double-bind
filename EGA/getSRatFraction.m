function [t,S,R,yMax] = getSRatFraction(foldername,ti,fi,Nr,TIME_INDEX)
filename = strcat(foldername,'condition',num2str(ti),'.csv');
data = dlmread(filename,',',1,0);
t = data(:,1); data = data(:,2:end);
yMax = max(max(data));

col = (fi-1)*Nr*2 + 1;
S = data(1:TIME_INDEX,col:(col+(Nr-1)));
R = data(1:TIME_INDEX,(col+Nr):(col+(2*Nr-1)));
t=t(1:TIME_INDEX);
end