function [cla, margin] = majority_voting(classes, type_num)
%instance_num*class_num
[m,n]=size(classes);
%这里的m表示样本的个数
cla=zeros(1,m);

margin = zeros(m,1);

for i=1:m
    cla_lab_temp=zeros(1,type_num);
    for j=1:n
        cla_lab_temp(1,classes(i,j))=cla_lab_temp(1,classes(i,j))+1;
    end
    [a,b]=sort(cla_lab_temp,'descend');
    
    cla(i)=b(1);
end

end

