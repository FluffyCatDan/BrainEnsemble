function [acc] = majority_voting_acc(classes,classes_L, label_number)
%instance_num*class_num
[m,n]=size(classes);

%这里的m表示样本的个数
cla=zeros(1,m);
count=0;
for i=1:m
    cla_lab_temp=zeros(1,label_number+1);
    for j=1:n
        if classes(i,j)<=0
            cla_lab_temp(1,end) =  cla_lab_temp(1,end) +1;
        else
            cla_lab_temp(classes(i,j))=cla_lab_temp(classes(i,j))+1;       
        end
    end
    [a,b]=sort(cla_lab_temp,'descend');
    
    
    cla(i)=b(1);
    
    if cla(i)==classes_L(i)
        count=count+1;
    end
    
end

acc=(count)/m;
%这里需要输出准确度

end

