function [acc] = methodology(test_x, test_y, train_x, train_y, TX, TL)

% 1-artificial brain region construction
[train_classifier_sequence_label,classifier_sequence, classifier_sequence_num] = ...
    label_assignment_v230907(train_x, train_y, TX, TL);

%acc_representation = classifier_sequence_ability_representation(test_x, test_y,classifier_sequence, ...
%  classifier_sequence_num,database_name);

% 2-Simulating brain functional activation channels
[predict_label] = graph_connection_main(train_x, train_y, train_classifier_sequence_label, test_x, test_y,...
    classifier_sequence,classifier_sequence_num);

%[~,width] = size(predict_label);
classifier_num = 1; %need to adjust (1:width)
test_len = size(test_x,1);

acc = 0;

for i = 1:test_len
    if predict_label(i,classifier_num)==test_y(i)
        acc = acc+1;
    end
end
acc = acc/test_len;

end

