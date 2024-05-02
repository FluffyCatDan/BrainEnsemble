function [distance] = Distance(x1, x2)
   distance= numel(find(x1~=x2))/size(x2,2);
end