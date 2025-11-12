function [out, out_v]=IndepDiff(point1,point2)
    out = point1(1) - point2(1);
    out_v = point1(2) + point2(2);
end