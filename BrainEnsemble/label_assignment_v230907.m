function [train_classifier_sequence_label,classifier_sequence, classifier_sequence_num] = ...
    label_assignment_v230907(train_x, train_y, TX, TL)

RIO = 0.4;

method = 1;

if method == 1
    [train_x_len, ~] = size(train_x);

    type_num = numel(unique([train_y]));

    for i = 1:train_x_len
        train_classifier_sequence_label{i}.label = [];
    end

    correct_or_not = zeros(1,train_x_len);
    classifier_sequence_num = 0;
    classifier_sequence = {};

    for step = 1:3

        LIST = find(correct_or_not==0);
        if size(LIST,1)>0
            select_sample = randperm(train_x_len);

            [train_acc] = acc_calculate([train_x(select_sample(1:round(train_x_len*RIO)),:);train_x(LIST,:)],...
                [train_y(select_sample(1:round(train_x_len*RIO)));train_y(LIST)]);

            [~, train_acc_loc] = sort(train_acc, 'descend');
            PRIO1 = train_acc_loc';

            classifier_num = classifier_num_selector(PRIO1, TX, TL);

            classifier_sequence_num = classifier_sequence_num + 1;

            classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);

            for i = 1:train_x_len
                if majority_voting(train_x(i,PRIO1(1:classifier_num)),type_num) == train_y(i)
                    train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                    correct_or_not(i) = 1;
                end
            end

        else
            break;
        end

    end

    %
    if numel(find(correct_or_not==0))>0
        for j = 1:train_x_len
            if correct_or_not(j) == 0
                LIST = find(train_x(j,:)==train_y(j));

                [train_acc] = acc_calculate([train_x(:,LIST)],...
                    train_y);

                [~, train_acc_loc] = sort(train_acc, 'descend');

                PRIO1 = train_acc_loc';
                classifier_num = classifier_num_selector(PRIO1, TX, TL);


                classifier_sequence_num = classifier_sequence_num + 1;
                classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);

                for i = 1:train_x_len
                    if majority_voting(train_x(i,PRIO1(1:classifier_num)),type_num) == train_y(i)
                        train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                        correct_or_not(i) = 1;
                    end
                end

            end

        end
    end

elseif method == 2
    [train_x_len, train_wid] = size(train_x);


    type_num = numel(unique([train_y]));

    for i = 1:train_x_len
        train_classifier_sequence_label{i}.label = [];
    end

    correct_or_not = zeros(1,train_x_len);
    classifier_sequence_num = 0;

    for step = 1:3

        LIST = find(correct_or_not==0);
        if size(LIST,1)>0
            select_sample = randperm(train_x_len);

            PRIO1 = make_sequence([train_x(select_sample(1:round(train_x_len*RIO)),:);train_x(LIST,:)],...
                [train_y(select_sample(1:round(train_x_len*RIO)));train_y(LIST)]);

            classifier_sequence_num = classifier_sequence_num + 1;

            classifier_num = classifier_num_selector(PRIO1, TX, TL);

            classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);

            for i = 1:train_x_len
                if majority_voting(train_x(i,PRIO1(1:classifier_num)),type_num) == train_y(i)
                    train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                    correct_or_not(i) = 1;
                end
            end
        else
            break;
        end

    end

    %
    if numel(find(correct_or_not==0))>0
        for j = 1:train_x_len
            if correct_or_not(j) == 0
                LIST = find(train_x(j,:)==train_y(j));

                PRIO1 = make_sequence([train_x(:,LIST)],...
                    train_y);

                classifier_sequence_num = classifier_sequence_num + 1;

                classifier_num = classifier_num_selector(PRIO1, TX, TL);

                classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);


                for i = 1:train_x_len
                    if majority_voting(train_x(i,LIST),type_num) == train_y(i)
                        train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                    end
                    correct_or_not(j) = 1;
                end
            end

        end
    end
elseif method == 3
    % PRIO3= DREP_main([error_matrix;train_x(T(1:EL),:)], [error_label;train_y(T(1:EL))], 0.3);
    [train_x_len, train_wid] = size(train_x);


    type_num = numel(unique([train_y]));

    for i = 1:train_x_len
        train_classifier_sequence_label{i}.label = [];
    end

    correct_or_not = zeros(1,train_x_len);
    classifier_sequence_num = 0;

    for step = 1:3

        LIST = find(correct_or_not==0);
        if size(LIST,1)>0
            select_sample = randperm(train_x_len);

            DICE = rand(1);

            if DICE<=0.5
                [train_acc] = acc_calculate([train_x(select_sample(1:round(train_x_len*RIO)),:);...
                    train_x(LIST,:)],[train_y(select_sample(1:round(train_x_len*RIO)));...
                    train_y(LIST)]);

                [~, train_acc_loc] = sort(train_acc, 'descend');
                PRIO1 = train_acc_loc';

            elseif 0.5<DICE
                PRIO1 = make_sequence([train_x(select_sample(1:round(train_x_len*RIO)),:);...
                    train_x(LIST,:)],...
                    [train_y(select_sample(1:round(train_x_len*RIO)));train_y(LIST)]);

            end

            classifier_sequence_num = classifier_sequence_num + 1;

            classifier_num = classifier_num_selector(PRIO1, TX, TL);

            classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);

            for i = 1:train_x_len
                if majority_voting(train_x(i,PRIO1(1:classifier_num)),type_num) == train_y(i)
                    train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                    correct_or_not(i) = 1;
                end
            end
        else
            break;
        end

    end

    if numel(find(correct_or_not==0))>0
        for j = 1:train_x_len
            if correct_or_not(j) == 0
                LIST = find(train_x(j,:)==train_y(j));

                PRIO1 = make_sequence([train_x(:,LIST)],...
                    train_y);
                DICE = rand(1);

                if DICE<=0.5
                    [train_acc] = acc_calculate(train_x(:,LIST),train_y);

                    [~, train_acc_loc] = sort(train_acc, 'descend');
                    PRIO1 = train_acc_loc';

                elseif 0.5<DICE
                    PRIO1 = make_sequence(train_x(:,LIST),train_y);

                end

                classifier_sequence_num = classifier_sequence_num + 1;

                classifier_num = classifier_num_selector(PRIO1, TX, TL);

                classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);


                for i = 1:train_x_len
                    if majority_voting(train_x(i,LIST),type_num) == train_y(i)
                        train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                    end
                    correct_or_not(j) = 1;
                end
            end

        end
    end
elseif method == 4

    [train_x_len, train_wid] = size(train_x);

    type_num = numel(unique([train_y]));

    for i = 1:train_x_len
        train_classifier_sequence_label{i}.label = [];
    end

    correct_or_not = zeros(1,train_x_len);
    classifier_sequence_num = 0;

    for step = 1:type_num

        select_sample = find(train_y(:)==step);
        non_select_sample = find(train_y(:)~=step);
        L_TEMP = randperm(size(non_select_sample,1));

        NUM = min(round(size(select_sample,1)*0.6),size(non_select_sample,1));

        LIST = non_select_sample(L_TEMP(1:NUM));

        [train_acc] = acc_calculate([train_x(select_sample,:);train_x(LIST,:)],...
            [train_y(select_sample);train_y(LIST)]);

        [~, train_acc_loc] = sort(train_acc, 'descend');
        PRIO1 = train_acc_loc';
        classifier_sequence_num = classifier_sequence_num + 1;

        classifier_num = classifier_num_selector(PRIO1, TX, TL);

        classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);

        for i = 1:train_x_len
            if majority_voting(train_x(i,PRIO1(1:classifier_num)),type_num) == train_y(i)
                train_classifier_sequence_label{i}.label = [train_classifier_sequence_label{i}.label classifier_sequence_num];
                correct_or_not(i) = 1;
            end
        end


    end

    if numel(find(correct_or_not==0))>0
        for j = 1:train_x_len
            if correct_or_not(j) == 0
                LIST = find(train_x(j,:)==train_y(j));

                [train_acc] = acc_calculate([train_x(:,LIST)],...
                    train_y);

                [~, train_acc_loc] = sort(train_acc, 'descend');

                PRIO1 = LIST(train_acc_loc');

                classifier_sequence_num = classifier_sequence_num + 1;
                classifier_num = classifier_num_selector(PRIO1, TX, TL);

                classifier_sequence{classifier_sequence_num} = PRIO1(1:classifier_num);
                correct_or_not(j) = 1;
            end

        end
    end
end

%[classifier_sequence, classifier_sequence_num,train_classifier_sequence_label] = judge_sequence_diff(...
% classifier_sequence, classifier_sequence_num,train_classifier_sequence_label);


