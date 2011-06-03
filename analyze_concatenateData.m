function analyze_concatenateData

inDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data/';
outDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data_results/';

files = dir([inDir 'S*.mat']);
displayFiles (files)

Data = [];
for fi = 1: length(files)
    load ( [inDir files(fi).name] ) 
    Data = cat(1,Data, Exp.Trial);
    clear Exp
end

save([outDir 'Data_3subjs'], 'Data')
    