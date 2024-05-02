function [ sig,ens ] = make_ensemble(train_m,train_l)

[train_y,train_x] = size(train_m);

sig= zeros(train_y,train_x);
ens = zeros(train_y,1);

for i=1:train_y
    for j=1:train_x
        if train_m(i,j)==train_l(i)
            sig(i,j) = 1;
        else
            sig(i,j) = -1;
        end
        ens(i) = ens(i)+sig(i,j);
    end
    ens(i)=ens(i)/train_x;
end


end

