function [cla] = weighted_majority_voting(weight,classes,type_num)
[m,n]=size(classes);
cla=zeros(1,m);
for i=1:m
    cla_lab_temp=zeros(1,type_num);
    for j=1:n
        cla_lab_temp(classes(i,j))=cla_lab_temp(classes(i,j))+weight(j);
    end
    [a,b]=sort(cla_lab_temp,'descend');
   
    cla(i)=b(1);
    
end
end

