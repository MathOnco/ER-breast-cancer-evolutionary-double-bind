function [] = halfCircleMarker(rotate,xData,yData,color,color1,color2,del)

    frac = 55/70;
    del = del*2.5;
    r = del/55;
    markerSize = 0.6;

    lw = 1.5;
    markerEdgeColor = color;
    markerFaceColor = color;

    % color-filled circle, then gray circle
    for i = 1:2
        if i == 2
            r = del/60;%slightly smaller
            markerFaceColor = color2;
            phi2 = rotate:0.01:(pi+rotate);
            markerDataX = r*cos(phi2);
            markerDataY = r*sin(phi2);
        else
            markerFaceColor = color1;
            phi1 = 0:0.01:(2*pi);
            markerDataX = r*cos(phi1);
            markerDataY = r*sin(phi1);
        end

        xData = reshape(xData,length(xData),1) ;
        yData = reshape(yData,length(yData),1) ;
        markerDataX = markerSize * reshape(markerDataX,1,length(markerDataX)) ;
        markerDataY = markerSize * reshape(markerDataY,1,length(markerDataY)) ;

        vertX = repmat(markerDataX,length(xData),1) ; vertX = vertX(:) ;
        vertY = repmat(markerDataY,length(yData),1) ; vertY = vertY(:) ;

        vertX = repmat(xData,length(markerDataX),1) + vertX ;
        vertY = repmat(yData,length(markerDataY),1) + vertY ;
        faces = 0:length(xData):length(xData)*(length(markerDataY)-1) ;
        faces = repmat(faces,length(xData),1) ;
        faces = repmat((1:length(xData))',1,length(markerDataY)) + faces ;

        patchHndl = patch('Faces',faces,'Vertices',[vertX vertY]);

        if (i>1)
            set(patchHndl,'FaceColor',markerFaceColor,'EdgeColor','none') ;
        else
            set(patchHndl,'FaceColor',markerFaceColor,'EdgeColor',markerEdgeColor,'LineWidth',lw);
        end
    end
end