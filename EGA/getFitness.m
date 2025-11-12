function [gS,gR,t,S,R,yMax,tFit,sFit,rFit] = getFitness(foldername,ti,fi,Nr,TIME_INDEX)
    
    %% get growth rates for all replicates:
    [t,S,R,yMax] = getSRatFraction(foldername,ti,fi,Nr,TIME_INDEX);

    % fitness (growth rates)
    gS = zeros(1,Nr);
    gR = gS;
    
    tFit=[];rFit=[];sFit=[]; % these have Nr rows
    for ri = 1:Nr
        Sm = S(:,ri);
        Rm = R(:,ri);
        
        %% USE EXPONENTIAL FIT
        [~,aS,tFitS,yFitS]=getExpFit(t,Sm);
        [~,aR,tFitR,yFitR]=getExpFit(t,Rm);      
        
        %% add to arrays:
        gS(1,ri) = aS;
        gR(1,ri) = aR;
        sFit=[sFit;yFitS];
        rFit=[rFit;yFitR];
        tFit=tFitR;
        
        if (isempty(tFit))
            tFit=tFitS;
        end
    end

end
