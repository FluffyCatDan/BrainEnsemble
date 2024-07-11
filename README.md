# BrainEnsemble

**BrainEnsemble: A brain-inspired effective ensemble pruning algorithm for pattern classification**

**Introduction**

The human brain comprises distinct regions, each with specific functions. Interconnected through neural pathways, the brain regions collaborate to process complex information. Similarly, ensemble learning enhances pattern classification by leveraging the collaboration and complementarity between classifiers. The similarity between the two suggests that simulating the brain's functional network holds the potential for groundbreaking advancements in the design of ensemble learning algorithms. Motivated by this, our paper proposes a brain-inspired ensemble pruning method called BrainEnsemble. This method provides an example of using classifier combinations to emulate the functions of brain regions. Guided by the principles of curriculum learning and the divide-and-conquer strategy, each artificial brain region can specialize in specific functions and tasks. Additionally, BrainEnsemble simulates the brain regions’ responses and connectivity mechanisms through graph connections. In this model, different artificial brain regions can dynamically reorganize and adjust their interactions to adapt to continuously changing environments or data distributions, enabling the model to maintain high performance when confronted with new data. 

**BrainEnsemble is a Matlab code for quick implementation, modification, evaluation, and visualization of this paper, and it can be applied to pattern recognition problems.**
![An example of the connection graphs of artificial brain regions](https://github.com/FluffyCatDan/BrainEnsemble/assets/105225235/8c72c063-2dc0-495a-b34b-8d95a454c74e)

**Source Dataset**

In this paper, we primarily utilized the following databases: Balance_scale, blood, bupa, cancer, cmc, diabetes, haberman, heartstatlog, iris, jain, sonar, tic_tac_toe, vehicle, vowel, and robotnavigation. All these databases originate from the UCI Machine Learning Repository. For viewing and downloading the respective data, you can visit https://archive.ics.uci.edu.

**Installation Instruction**

1)Using multiple classifiers to predict data samples.(This paper generated a total of 301 classifiers, which includes 100 ANNs, 100 SVMs, 49 random forests, 20 Bayesian classifiers, 12 K-nearest neighbors, and 20 discriminant analysis classifiers)

2)Then save the generated prediction matrix as follows: in the prediction matrix {public\test\train}_pool_{n}.mat, columns represent the number of data points, and rows represent the number of classifiers used. In this paper, the number of classifiers is 301, and n denotes the fold number. And the corresponding directory structure is shown as follows.

![image](https://github.com/FluffyCatDan/BrainEnsemble/assets/105225235/7a9df1a4-8d37-447a-910f-18b094863fb5)

3）Then, using ‘\util\load_data.m’ to merge the files from ‘\generate_classifier_pool’ and place them into the ‘\intermediate_data folder’. The structure of the data in the intermediate_data folder is as follows:

![image](https://github.com/FluffyCatDan/BrainEnsemble/assets/105225235/c466ff37-85d9-4351-9dc8-c6250f623a90)

The file input_data_{dataset_name}_{folder_num}.mat contains the following:

       the train_pool: data_num*classifier_num, 
     
       train_l:data_num*1, 
       
       valid_pool:data_num*classifier_num,
       
       valid_l:data_num*1, 
       
       test_pool:data_num*classifier_num, 
       
       test_l:data_num*1

4）To execute, run main.m

5）Upon entering methodology.m, proceed to label_assignment_v230907.m to construct the brain region model and explore the relationship between data and brain regions. Proceeding to graph_connection_main.m enables the construction of the brain region connectivity model and establishes dynamic connections between test data and brain regions.
