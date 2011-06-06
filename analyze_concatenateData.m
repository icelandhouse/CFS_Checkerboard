function analyze_concatenateData

rawDataDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data/';
resultsDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data_results/';
figsDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Figures/';

fileName = 'Data_02062011'; % DEFINE THE NAME TO SAVE THE FILE
files = dir([rawDataDir 'S*02062011*.mat']);
displayFiles (files)


Data = [];
for fi = 1: length(files)
    load ( [rawDataDir files(fi).name] )
    Data = cat(1,Data, Exp.Trial);
    clear Exp
end

save([resultsDir fileName], 'Data')


%% Analyze accuracy

analyze_Accuracy (fileName, resultsDir, resultsDir)

%% Plot Results

analyze_plotAccuracies (fileName, resultsDir, figsDir)


