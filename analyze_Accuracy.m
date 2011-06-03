function analyze_Accuracy

inDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data_results/';
outDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data_results/';

fileName = 'Data_3subjs';

load ([inDir fileName])

%% Conditions :
% (1) subject number ; (2) Block number; (3) contrast value ; (4) timing
% value ; (5) code for the timing conditions ; (6) location of the checkerboard
% (7) responses for locations ; (8) responses for subjective visibility

%  timingConds = { 'backwardMasking' 'forwardMasking' 'middleMasking'}; %
%  1, 2, 3
timing_conditions = unique(Data(:,5)); %#ok
all_contrasts = unique(Data(:,3)); %#ok
subjects = unique(Data(:,1)); %#ok

accuracies =  zeros(length(timing_conditions), length(all_contrasts), length(subjects));
for subj = 1: length(subjects)
    for cond =1 : length(timing_conditions)
        for contrast =1 :length(all_contrasts)
            
            % Filter subjects
            aux_data = Data( Data(:,1) == subjects(subj) & Data(:,5) ==timing_conditions(cond)...
                & Data(:,3)== all_contrasts(contrast), :) ; %#ok
            % just a sanity check
            if size(aux_data, 1) ~= 48
                display ('ERROR IN THE NUMBER OF TRIALS')
                return
            end
            
            correct = size( aux_data( aux_data(:,6) == aux_data(:,7), :), 1) / size(aux_data, 1);            
            accuracies(cond, contrast, subj) = correct;
        end
    end
end

cols = {'0.02' '0.04' '0.08' '0.16' '0.32' '0.64' '0.96'};
rows = {'backward' 'forward' 'middle'};
accuracies_means = mean(accuracies, 3);
accuracies_std = std(accuracies, 0, 3);
accuracies_sems = std(accuracies,0, 3) / sqrt(size(accuracies, 3));
save([outDir 'Accuracies_3subjs'], 'accuracies', 'accuracies_means', 'accuracies_std', 'accuracies_sems', ...
    'rows', 'cols', 'timing_conditions', 'subjects', 'all_contrasts')



