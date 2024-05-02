function [p_path_matrix] = p_path_matrix_calculate(start_node, num, connection_matrix)

S = sum(connection_matrix(start_node,:));
LIST = connection_matrix(start_node,:)./S;
p_path_matrix = LIST';

end

