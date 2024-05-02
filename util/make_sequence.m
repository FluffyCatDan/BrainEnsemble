function [index ] = make_sequence(train_x,train_l)

[angle ] = make_reference(train_x,train_l);
[sa,index]=sort(angle);

end

