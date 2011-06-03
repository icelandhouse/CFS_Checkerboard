function analyze_plotAccuracies

inDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Data_results/';
figDir = '/home/lisandro/Work/Project_CFS/CFS_Checkerboard/Figures/';

% Load desired file
fileName = 'Accuracies_3subjs.mat';
load ([inDir fileName])

%% single subject plots
for subj = 1 : size(accuracies, 3)
    figure();
    set(gcf,'Position',[0 0 600 300],'Color','w')
    set(gcf,'PaperPositionMode','auto')
    set(gcf,'InvertHardcopy','off')
    hold on

    markers = {'-ks'  '-k^' '-ok'};
    markerColor = {'k'  'k' 'k'};
    MarkerFaceColor = {'k'  'b' 'g'};
    for cond =1 : size(accuracies,1)
        plot(all_contrasts(1:5), accuracies(cond, 1:5, subj), markers{cond},'MarkerEdgeColor', markerColor{cond}, ...
            'MarkerFaceColor', MarkerFaceColor{cond}, 'MarkerSize',10); %#ok
    end

    % Anotate the figure
    title(['Subject :  ' num2str(subjects(subj))], 'fontsize',14,'fontweight','b');
    ylabel('Accuracies', 'fontsize',12,'fontweight','b');
    xlabel('Contrast levels', 'fontsize',12,'fontweight','b');
    set(gca,'XTick', all_contrasts,'XTickLabel',cols(1:5))
    legend(rows, 'Location', 'Best')

    set(gca,'YLim',[0 1])
    print(gcf, '-djpeg', [figDir 'Accuracy_Subject' num2str(subjects(subj))])

end

%% plot means across participants

figure();
set(gcf,'Position',[0 0 600 300],'Color','w')
set(gcf,'PaperPositionMode','auto')
set(gcf,'InvertHardcopy','off')
hold on
markers = {'-ks'  '-k^' '-ok'};
markerColor = {'k'  'k' 'k'};
MarkerFaceColor = {'k'  'b' 'g'};
for cond =1 : size(accuracies,1)
    plot(all_contrasts(1:5), accuracies_means(cond, 1:5), markers{cond},'MarkerEdgeColor', markerColor{cond}, ...
        'MarkerFaceColor', MarkerFaceColor{cond}, 'MarkerSize',10); %#ok
end

% Anotate the figure
title('All Subjects', 'fontsize',14,'fontweight','b');
ylabel('Accuracy', 'fontsize',12,'fontweight','b');
xlabel('Contrast levels', 'fontsize',12,'fontweight','b');
set(gca,'XTick', all_contrasts,'XTickLabel',cols(1:5))
legend(rows, 'Location', 'Best')
set(gca,'YLim',[0 1])
    print(gcf, '-djpeg', [figDir 'Accuracy_All_Subjects'])



close all