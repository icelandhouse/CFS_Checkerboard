function analyze_plotAccuracies (fileName, inDir, outDir)


% Load desired file
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
    markerSize = 7;
    for cond =1 : size(accuracies,1)
        plot(all_contrasts, accuracies(cond, : , subj), markers{cond},'MarkerEdgeColor', markerColor{cond}, ...
            'MarkerFaceColor', MarkerFaceColor{cond}, 'MarkerSize', markerSize); %#ok
    end

    % Anotate the figure
    title(['Subject :  ' num2str(subjects(subj))], 'fontsize',14,'fontweight','b');
    ylabel('Accuracies', 'fontsize',12,'fontweight','b');
    xlabel('Contrast levels', 'fontsize',12,'fontweight','b');
    set(gca,'XTick', all_contrasts,'XTickLabel',cols)
    legend(rows, 'Location', 'Best')

    set(gca,'YLim',[0 1])
    print(gcf, '-djpeg', [outDir fileName '_Accuracy_Subject' num2str(subjects(subj))])

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
% markerSize = 6;
for cond =1 : size(accuracies,1)
    plot(all_contrasts, accuracies_means(cond, :), markers{cond},'MarkerEdgeColor', markerColor{cond}, ...
        'MarkerFaceColor', MarkerFaceColor{cond}, 'MarkerSize', markerSize); %#ok
end

% Anotate the figure
title('All Subjects', 'fontsize',14,'fontweight','b');
ylabel('Accuracy', 'fontsize',12,'fontweight','b');
xlabel('Contrast levels', 'fontsize',12,'fontweight','b');
set(gca,'XTick', all_contrasts,'XTickLabel',cols)
legend(rows, 'Location', 'Best')
set(gca,'YLim',[0 1])
    print(gcf, '-djpeg', [outDir fileName '_Accuracy_All_Subjects'])



close all