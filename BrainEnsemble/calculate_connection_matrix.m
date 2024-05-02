function [connection_matrix] = calculate_connection_matrix(...
    test_neighbor, train_classifier_sequence_label, sequence_num)

[test_neighbor_num] = size(test_neighbor,2);

for sn = 1:sequence_num
    connection_matrix{sn}.Matrix = zeros(test_neighbor_num+1,test_neighbor_num+1);
    
    for i = 2:test_neighbor_num+1
       
        for j = i+1:test_neighbor_num+1
          
            if numel(intersect(train_classifier_sequence_label{test_neighbor(i-1)}.label,...
                    train_classifier_sequence_label{test_neighbor(j-1)}.label))>0
                connection_matrix{sn}.Matrix(i,j) = 1;
                connection_matrix{sn}.Matrix(j,i) = 1;
            end
         
        end
        if ismember(sn,train_classifier_sequence_label{test_neighbor(i-1)}.label)
            connection_matrix{sn}.Matrix(1,i) = 1;
            connection_matrix{sn}.Matrix(i,1) = 1;
        end
    end

    for i = 1:test_neighbor_num+1
        connection_matrix{sn}.Matrix(i,i) = 1;
    end

end

end

