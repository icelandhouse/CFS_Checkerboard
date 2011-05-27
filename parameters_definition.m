function Exp = parameters_definition


PsychJavaTrouble; % Check there are no problems with Java
Exp.Cfg.SkipSyncTest = 0; %This should be '0' on a properly working NVIDIA video card. '1' skips the SyncTest.
Exp.Cfg.AuxBuffers= 1; % '0' if no Auxiliary Buffers available, otherwise put it into '1'.
% Check for OpenGL compatibility
AssertOpenGL;
Screen('Preference','SkipSyncTests', Exp.Cfg.SkipSyncTest);

Exp.Cfg.WinSize= [0 0 1000 500];  %Empty means whole screen
Exp.Cfg.WinColor= []; % empty for the middle gray of the screen.

Exp.Cfg.xDimCm = 32.5; %Length in cm of the screen in X
Exp.Cfg.yDimCm = 24.5; %Length in cm of the screen in Y
Exp.Cfg.distanceCm = 60; %Viewing distance