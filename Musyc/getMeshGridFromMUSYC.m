function [x_grid,y_grid,z_grid,x_i,y_i]=getMeshGridFromMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER)
    [x,y,z,ez]=getMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER);
    
    X=sort(unique(x));
    Y=sort(unique(y));

    [x_grid,y_grid] = meshgrid(X,Y);
    [n,m]=size(x_grid);

    z_grid=zeros(n,m)*NaN;

    eps=1e-11;


    x_i=zeros(length(X),1);
    y_i=zeros(length(Y),1);

    for i = 1:1:length(x)
        
        x_i(i) = find(X+eps>=x(i),1);
        y_i(i) = find(Y+eps>=y(i),1);
        z_grid(y_i(i),x_i(i)) = z(i);
    end


    % get rid of rows w/ a NaN 
    % (because the drug1 axis has many more points)

%     indices = isnan(mean(z_grid'))';
%     z_grid = z_grid(~indices,:);
%     x_grid = x_grid(~indices,:);
%     y_grid = y_grid(~indices,:);

end