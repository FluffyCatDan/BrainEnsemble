function [ Probability_G] = Probability_G_calculate(train_seq_y,test_neighbor,...
    p_path_matrix, num, sequence_num)

 Probability_G = zeros(1, sequence_num);

for i = 1:num
    for sn = 1:sequence_num
        if ismember(sn, train_seq_y{test_neighbor(i)}.label)
            Probability_G(sn) = Probability_G(sn)+p_path_matrix(i+1);
        end
    end
end

end

