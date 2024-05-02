function [] = main()
clc;clear;
addpath(genpath('.'));

database_name_vector = {'balance_scale' 'blood' 'bupa' 'cmc'...
    'cancer'  'diabetes' 'haberman' 'heartstatlog' 'iris' 'jain' 'sonar' ...
    'tic_tac_toe' 'vehicle' 'vowel' 'robotnavigation'};

database_num = size(database_name_vector,2);

database_count = 0;

for i =1:database_num
    database_name = char(database_name_vector{i});
    fprintf('%s:\n', database_name);

    acc = zeros(10,1);

    for folder_num = 1:10
        % load data, including:
        % the train_pool: data_num*classifier_num, 
        % train_l:data_num*1, 
        % valid_pool:data_num*classifier_num,
        % valid_l:data_num*1, 
        % test_pool:data_num*classifier_num, 
        % test_l:data_num*1
        loadpath = strcat(strcat('.\intermediate_data\input_data_', database_name, '_'),num2str(folder_num),'.mat');
        load(loadpath);
       
        [acc(folder_num)] = methodology(test_pool, test_l, valid_pool, valid_l, train_pool, train_l);
    end

    acc_ave = mean(acc);
   
    fprintf('acc_ave=%0.4f\n', acc_ave);
        
end

end



