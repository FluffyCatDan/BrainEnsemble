function [classifier_num] = classifier_num_selector(PRIO1, train_x, train_y)

[total_classifer_num] = size(PRIO1,2);

[train_len] = size(train_x,1);

acc = zeros(1, total_classifer_num);
for i = 1:total_classifer_num
    for j = 1:train_len
        if majority_voting(train_x(j,PRIO1(1:i)),numel(unique(train_y))) == train_y(j)
            acc(i) = acc(i)+1;
        end
    end
    acc(i) = acc(i)/train_len;
end
[~, acc_loc] = max(acc);

classifier_num = acc_loc;
end

