function drawFrame (Exp, m, fixColor)


% fixPos = [Exp.Cfg.centerX - 5  Exp.Cfg.centerY - 5  Exp.Cfg.centerX + 5 Exp.Cfg.centerY + 5];

distLeft = ceil((Exp.Cfg.pixelsPerDegree * Exp.addParams.separationFixationL));
% SELECT LEFT EYE:
% Draw outer frame
Screen('DrawTextures', Exp.Cfg.win, Exp.Stimuli.frame, [], Exp.Stimuli.leftFrame,[] ,[], [], []);
Screen('FillRect',  Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.Trial(m).leftStimuliCoordinate);
% fixation point
Screen('DrawDots',  Exp.Cfg.win, [Exp.Cfg.centerX+distLeft  Exp.Cfg.centerY] , Exp.Trial(m).fixDotSize,...
    fixColor, [], Exp.addParams.fixDotType);

distRight = ceil((Exp.Cfg.pixelsPerDegree * Exp.addParams.separationFixationR));


% SELECT RIGHT EYE:
% Draw outer Frame
Screen('DrawTextures', Exp.Cfg.win,  Exp.Stimuli.frame, [], Exp.Stimuli.rightFrame,...
    [] ,[], [], []);
Screen('FillRect',  Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.Trial(m).rigthStimuliCoordinate);
% fixation point
Screen('DrawDots',  Exp.Cfg.win, [Exp.Cfg.centerX+distRight Exp.Cfg.centerY] , Exp.Trial(m).fixDotSize,...
    fixColor, [], Exp.addParams.fixDotType);








