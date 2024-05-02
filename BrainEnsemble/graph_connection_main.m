function [ final_prediction] = graph_connection_main(train_x, train_y, train_seq_y, test_x, test_y,...
    classifier_sequence,sequence_num)

num = 5;%round(0.1*train_len);

[test_sample_num, ~] = size(test_x);
[train_sample_num, ~] = size(train_x);

final_prediction = zeros(test_sample_num,1);

for i = 1:test_sample_num

    test_similarity = zeros(1, train_sample_num);

    for j = 1:train_sample_num
        test_similarity(j) = Distance(test_x(i,:), train_x(j,:));
    end

    [test_sim_value, sim_index] = sort(test_similarity, "ascend");
    test_neighbor = sim_index(1:num);

    L = [];
    for j = 1:num
        % train_seq_y{test_neighbor(j)}.label
        L = [L train_seq_y{test_neighbor(j)}.label];
    end
   
    [connection_matrix] = calculate_connection_matrix(...
        test_neighbor, train_seq_y, sequence_num);


    Probability_G = zeros(1, sequence_num);

    for G = 1: numel(unique(L))%sequence_num
        p_transfer_matrix = p_transfer_matrix_calculate(test_sim_value, train_x(sim_index,:), num, connection_matrix{G}.Matrix);
        start_node = 1;
        p_path_matrix = p_path_matrix_calculate(start_node, num, connection_matrix{G}.Matrix);
        for step = 1:3
            p_path_matrix = 0.5*p_transfer_matrix*p_path_matrix;
        end

        Probability_G = Probability_G+...
            Probability_G_calculate(train_seq_y, test_neighbor, p_path_matrix,num, sequence_num);

    end
    [~, Probability_G_loc] = sort(Probability_G,'descend');

    method = 5;

    if method == 1
        LIST = combine_list(train_x, train_y, Probability_G_loc, classifier_sequence);%classifier_sequence{Probability_G_loc(1)};
        for cn = 1:2:400
            if cn>=size(LIST,2)
                final_prediction(i,cn) = majority_voting(test_x(i, LIST), numel(unique(test_y)));
                break;
            else
                final_prediction(i,cn) = majority_voting(test_x(i, LIST(1:cn)), numel(unique(test_y)));
            end
        end
    elseif method == 2
        LIST = classifier_sequence{Probability_G_loc(1)};
        for cn = 1:1:size(LIST,2)
            final_prediction(i,cn) = majority_voting(test_x(i, LIST(1:cn)), numel(unique(test_y)));
        end
    elseif method == 3
        LIST = combine_list2(test_x(i,:), test_y,Probability_G_loc, classifier_sequence);
        final_prediction(i,1) = majority_voting(LIST,numel(unique(test_y)));
    elseif method == 4
        LIST = combine_list3(test_x(i,:), test_y,Probability_G_loc, classifier_sequence);
        final_prediction(i,1) = majority_voting(LIST,numel(unique(test_y)));
    elseif method == 5
        LIST = combine_list3(test_x(i,:), test_y,Probability_G_loc, classifier_sequence);
        for cn = 1:1:size(LIST,2)
        final_prediction(i,cn) = majority_voting(LIST(1:cn),numel(unique(test_y)));
        end
    end

end

end
