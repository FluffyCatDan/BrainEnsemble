function [LIST] = combine_list3(train_x, train_y, Probability_G_loc, classifier_sequence)

LIST = zeros(1,size(classifier_sequence,2));
for i =1:size(classifier_sequence,2)
    L = classifier_sequence{Probability_G_loc(i)};
    LIST(i) = majority_voting(train_x(:,L),numel(unique(train_y)));
end
for i = 1:size(classifier_sequence,2)
    L = classifier_sequence{Probability_G_loc(i)};
    LIST = [LIST train_x(:,L)];
end

end

