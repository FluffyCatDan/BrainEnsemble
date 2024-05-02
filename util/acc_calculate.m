function [ public_acc ] = acc_calculate( public_m,  public_l)

[public_len, public_wid] = size(public_m);
public_acc = zeros(public_wid,1);

for i = 1:public_wid
    for j = 1:public_len
        if public_m(j,i) == public_l(j)
            public_acc(i) = public_acc(i)+1;
        end
    end
    public_acc(i) = public_acc(i)/public_len;
end

end

