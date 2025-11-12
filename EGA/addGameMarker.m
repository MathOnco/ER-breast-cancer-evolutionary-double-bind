% function [] = addGameMarker(TREATMENT,relR,relS,del)
function [] = addGameMarker(point_x,point_y,color,del)
rotate = 0;


relR=point_x(1);
relS=point_y(1);

[n,~]=size(color);
color1=color;
color2=color;
if (n>1)
    color1=color(1,:);
    color2=color(2,:);
end
black=[0,0,0];
halfCircleMarker(rotate,relR,relS,black,color1,color2,del);
errorbarxy(point_x(1),point_y(1),point_x(2),point_y(2),'LineWidth',2,'Color',black);

% if (TREATMENT == 1)
%     halfCircleMarker(rotate,relR,relS,[0,0,0],[0,0,0],[0,0,0],del);
% 
% elseif (TREATMENT == 2)
%     halfCircleMarker(rotate,relR,relS,[0,0,0],[1,0,0],[1,0,0],del);
%         
% elseif (TREATMENT == 3)
%     halfCircleMarker(rotate,relR,relS,[0,0,0],nk0,nk0,del);
% 
% elseif (TREATMENT == 4)
%     halfCircleMarker(rotate,relR,relS,[0,0,0],nk1,nk1,del);
% 
% elseif (TREATMENT == 5)
%     halfCircleMarker(rotate,relR,relS,[0,0,0],[1,0,0],nk0,del);
%     
% elseif (TREATMENT == 6)
%     
%     halfCircleMarker(rotate,relR,relS,[0,0,0],[1,0,0],nk1,del);    
% end





end