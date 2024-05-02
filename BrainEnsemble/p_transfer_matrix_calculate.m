function [p_transfer_matrix] = p_transfer_matrix_calculate(...
    k_sim_value, k_neighbor, k_neighbor_num,connection_matrix)
  
p_transfer_matrix = zeros(k_neighbor_num+1,k_neighbor_num+1);

for i = 1:k_neighbor_num
    p_transfer_matrix(1,i+1) = k_sim_value(i)*connection_matrix(1,i+1);
    p_transfer_matrix(i+1,1) = p_transfer_matrix(1,i+1);
    for j = i+1:k_neighbor_num
        p_transfer_matrix(i+1,j+1) = Distance(k_neighbor(i,:), k_neighbor(j,:))*connection_matrix(i+1,j+1);
        p_transfer_matrix(j+1,i+1) = p_transfer_matrix(i+1,j+1);
    end
end
row_sums = sum(p_transfer_matrix, 2); 
p_transfer_matrix = p_transfer_matrix ./ row_sums;
p_transfer_matrix = p_transfer_matrix';
end

