function [] = load_data()

database_name_vector = {'balance_scale' 'blood' 'bupa' 'cmc'...
    'cancer'  'diabetes' 'haberman' 'heartstatlog' 'iris' 'jain' 'sonar' ...
    'tic_tac_toe' 'vehicle' 'vowel' 'robotnavigation'};
database_num = size(database_name_vector,2);

for i =1:database_num
    database_name = char(database_name_vector{i});
    fprintf('%s:\n', database_name);

    for folder_num = 1:10
        base_str = '.\generate_classifier_pool\classifier pool\';
        str0 = strcat(base_str, database_name,'\');

        str_n1 = strcat(str0, 'noise\noise_pool_');
        str_n2 = strcat(str0, 'noise\noise_label_folder');
        str_noise = load(strcat(str_n1, num2str(folder_num),'.mat'));
        label_noise = load(strcat(str_n2, num2str(folder_num),'.mat'));

        str_p1 = strcat(str0, 'public\public_pool_');
        str_p2 = strcat(str0, 'public\validation_label_folder');
        str_public = load(strcat(str_p1, num2str(folder_num),'.mat'));
        label_public = load(strcat(str_p2, num2str(folder_num),'.mat'));

        str_te1 = strcat(str0, 'test\test_pool_');
        str_te2 = strcat(str0, 'test\test_label_folder');
        str_test = load(strcat(str_te1, num2str(folder_num),'.mat'));
        label_test = load(strcat(str_te2, num2str(folder_num),'.mat'));

        str_tr1 = strcat(str0, 'train\train_pool_');
        str_tr2 = strcat(str0, 'train\train_label_folder');
        str_train = load(strcat(str_tr1, num2str(folder_num),'.mat'));
        label_train = load(strcat(str_tr2, num2str(folder_num),'.mat'));

        train_pool = str_train.train_predict_matrix;
        train_l = label_train.train_label;

        valid_pool = str_public.public_predict_matrix;
        valid_l = label_public.validation_label;
        [valid_len] = size(valid_l,1);


        valid_pool = [valid_pool(1:round(valid_len),:)];
        valid_l = [valid_l(1:round(valid_len))];

        test_pool = str_test.test_predict_matrix;
        test_l = label_test.test_label;

        savepath = strcat(strcat('.\intermediate_data\input_data_',database_name,'_'),num2str(folder_num),'.mat');
        save(savepath,'train_pool', 'train_l', 'valid_pool', 'valid_l', 'test_pool', 'test_l');

    end
end

end

