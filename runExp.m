function runExp


try
    

    %% Defining parameters

    Exp.Gral.SubjectName= input('Please enter subject ID:\n', 's');
    Exp.Gral.SubjectNumber= input('Please enter subject number:\n');
    Exp.Gral.SubjectBlock= input('Please enter block number:\n');

    PsychJavaTrouble; % Check there are no problems with Java
    Exp.Cfg.SkipSyncTest = 0; %This should be '0' on a properly working NVIDIA video card. '1' skips the SyncTest.
    Exp.Cfg.AuxBuffers= 1; % '0' if no Auxiliary Buffers available, otherwise put it into '1'.
    % Check for OpenGL compatibility
    AssertOpenGL;
    Screen('Preference','SkipSyncTests', Exp.Cfg.SkipSyncTest);

    Exp.Cfg.WinSize= [];  %Empty means whole screen
    Exp.Cfg.WinColor= []; % empty for the middle gray of the screen.

    Exp.Cfg.xDimCm = 32.5; %Length in cm of the screen in X
    Exp.Cfg.yDimCm = 24.5; %Length in cm of the screen in Y
    Exp.Cfg.distanceCm = 60; %Viewing distance

    Exp.addParams.textSize = 30;
    Exp.addParams.textColor = [0 0 255];
    Exp.stimuli.checkSize = 3; % IN DEGREES
    Exp.stimuli.checkOffcenter = 2;
    Exp.stimuli.arrowSize = 2;% IN DEGREES
    Exp.stimuli.arrowOffcenter = 1.5; %IN DEGREES
    Exp.stimuli.frameSize = 8;

    Exp.addParams.exitKey = 'o';
    Exp.addParams.blankInterval = 15; % interval between the last mondrian and the question. IN FRAMES

    %% Use Psychophysics
    %C:\Users\John.John-PC\Documents\MATLAB\CFS_Checkerboard

    %% INITIALYZE SCREEN
    Exp = InitializeScreen (Exp);

    %% Define Trials
    Exp = trials_definition (Exp);
    
    % Preallocate the timing matrix for all trials
    for tr=1: size(Exp.Trial, 1)
        Exp.expinfo(tr).timing = zeros(Exp.stimuli.stimDur,6);
    end
    
    %% Stimuli & Textures creation
    Exp.stimuli.frameSize = ceil(Exp.stimuli.frameSize * Exp.Cfg.pixelsPerDegree); % frames in pixels

    % Mondrians
    Exp.stimuli.NumberOfMondrians = 40;
    Exp.stimuli.ArrayOfMondrians = CreateMondrians(Exp.stimuli.NumberOfMondrians, Exp.stimuli.frameSize, Exp.stimuli.frameSize); %This creates 'NumberOfMondrians' of matrices, to be put into textures
    Exp.stimuli.mondrianTexVector = zeros(length(Exp.stimuli.NumberOfMondrians),1);
    for m = 1:Exp.stimuli.NumberOfMondrians
        Exp.stimuli.mondrianTexVector(m) = Screen('MakeTexture', Exp.Cfg.win, Exp.stimuli.ArrayOfMondrians{m});
    end

    %% Create and define frames
    % frameBackground = zeros(Exp.stimuli.frameSize,Exp.stimuli.frameSize,3);
    width = 25; % in pixels
    frame = rand(Exp.stimuli.frameSize + width) * 255;
    %Creating TEXTURE from Frame matrix
    Exp.stimuli.frameTex = Screen('MakeTexture', Exp.Cfg.win, frame);

    %% Arrow texture
    arrow_image = imread('arrow.png');
    arrow_image( arrow_image(:,:,:) ~= 255) = Exp.Cfg.Color.inc;
    Exp.stimuli.arrow = Screen('MakeTexture', Exp.Cfg.win, arrow_image);

    %% Define positions for the Frames, Masks, checherboard and arrows
    %Defining the two x and y coordinates on which both Frame Backgrounds and Masks
    %will be centered (first is Center Screen Left, second is Center Screen Right)
    Exp.stimuli.xLeft = Exp.Cfg.windowRect(3)/4;
    Exp.stimuli.xRight = Exp.Cfg.windowRect(3)*(3/4);
    Exp.stimuli.yRight = Exp.Cfg.windowRect(4)/2;
    Exp.stimuli.yLeft = Exp.Cfg.windowRect(4)/2;
    x = [Exp.stimuli.xLeft; Exp.stimuli.xRight];
    y = [Exp.stimuli.yLeft; Exp.stimuli.yRight];

    %Create rectangles for (1)Frame Backgrounds and Masks, and (2)Frame TEXTURES
    %Feed them into 'CenterRectOnPoint' and get a handle to be fed into 'DrawTextures' to specify rectangle locations for both
    %On-screen rectangle size and location for Frame Backgrounds and Masks
    rect = [0 0 Exp.stimuli.frameSize Exp.stimuli.frameSize];
    %On-screen rectangle size and location for Frames
    Exp.stimuli.rectFrame= [0 0 length(frame) length(frame)];
    Exp.stimuli.destFrame = CenterRectOnPoint(Exp.stimuli.rectFrame,x,y)';
    Exp.stimuli.newRect = CenterRectOnPoint(rect,x,y)';
    Exp.stimuli.destFrame_right = CenterRectOnPoint(rect, Exp.stimuli.xRight, Exp.stimuli.yRight)';
    Exp.stimuli.destFrame_left = CenterRectOnPoint(rect, Exp.stimuli.xLeft, Exp.stimuli.yLeft)';

    % CHECKERBOARD positions
    Exp.stimuli.checkSize = Exp.stimuli.checkSize * Exp.Cfg.pixelsPerDegree;
    RectCheck = [0 0 Exp.stimuli.checkSize Exp.stimuli.checkSize];
    offCenter = Exp.stimuli.checkOffcenter * Exp.Cfg.pixelsPerDegree;
    %Defining 4 checherboard positions within the left and within the right frame
    %Left frame
    Exp.stimuli.LeftCheck_Left = CenterRectOnPoint(RectCheck,Exp.stimuli.xLeft-offCenter,Exp.stimuli.yLeft);
    Exp.stimuli.LeftCheck_Right = CenterRectOnPoint(RectCheck,Exp.stimuli.xLeft+offCenter,Exp.stimuli.yLeft);
    Exp.stimuli.LeftCheck_Top = CenterRectOnPoint(RectCheck,Exp.stimuli.xLeft,Exp.stimuli.yLeft-offCenter);
    Exp.stimuli.LeftCheck_Bottom = CenterRectOnPoint(RectCheck,Exp.stimuli.xLeft,Exp.stimuli.yLeft+offCenter);
    %Right frame
    Exp.stimuli.RightCheck_Left = CenterRectOnPoint(RectCheck,Exp.stimuli.xRight-offCenter,Exp.stimuli.yRight);
    Exp.stimuli.RightCheck_Right = CenterRectOnPoint(RectCheck,Exp.stimuli.xRight+offCenter,Exp.stimuli.yRight);
    Exp.stimuli.RightCheck_Top = CenterRectOnPoint(RectCheck,Exp.stimuli.xRight,Exp.stimuli.yRight-offCenter);
    Exp.stimuli.RightCheck_Bottom = CenterRectOnPoint(RectCheck,Exp.stimuli.xRight,Exp.stimuli.yRight+offCenter);

    % ARROWS position
    Exp.stimuli.arrowSize = Exp.stimuli.arrowSize * Exp.Cfg.pixelsPerDegree;
    RectArrow = [0 0 Exp.stimuli.arrowSize Exp.stimuli.arrowSize];
    offCenter = Exp.stimuli.arrowOffcenter * Exp.Cfg.pixelsPerDegree;

    %Left frame
    Exp.stimuli.LeftArrow_Left = CenterRectOnPoint(RectArrow,Exp.stimuli.xLeft-offCenter,Exp.stimuli.yLeft);
    Exp.stimuli.LeftArrow_Right = CenterRectOnPoint(RectArrow,Exp.stimuli.xLeft+offCenter,Exp.stimuli.yLeft);
    Exp.stimuli.LeftArrow_Top = CenterRectOnPoint(RectArrow,Exp.stimuli.xLeft,Exp.stimuli.yLeft-offCenter);
    Exp.stimuli.LeftArrow_Bottom = CenterRectOnPoint(RectArrow,Exp.stimuli.xLeft,Exp.stimuli.yLeft+offCenter);
    %Right frame
    Exp.stimuli.RightArrow_Left = CenterRectOnPoint(RectArrow,Exp.stimuli.xRight-offCenter,Exp.stimuli.yRight);
    Exp.stimuli.RightArrow_Right = CenterRectOnPoint(RectArrow,Exp.stimuli.xRight+offCenter,Exp.stimuli.yRight);
    Exp.stimuli.RightArrow_Top = CenterRectOnPoint(RectArrow,Exp.stimuli.xRight,Exp.stimuli.yRight-offCenter);
    Exp.stimuli.RightArrow_Bottom = CenterRectOnPoint(RectArrow,Exp.stimuli.xRight,Exp.stimuli.yRight+offCenter);

    %% calibrate stereoscope
    %Draw the frames here:
    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
    Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);
    %Draw fixation point and 'Fixate'
    xy = zeros(2);
    xy(1,:) = x;
    xy(2,:) = y; %This now is a matrix containg two pairs of x,y coordinates to be used by 'DrawDots' to present dots
    Screen('DrawDots', Exp.Cfg.win, xy, 7, [0 0 255], [], 2);
    Screen('TextSize', Exp.Cfg.win, 18);
    Screen('DrawText', Exp.Cfg.win, 'Fixate', x(1)- 45, y(1) + 5, [0 0 255]);
    Screen('DrawText', Exp.Cfg.win, 'Fixate', x(2)- 45, y(2) + 5, [0 0 255]);
    Screen('Flip', Exp.Cfg.win, [], Exp.Cfg.AuxBuffers);
    kbwait();


    %% Run main experiment

    HideCursor;
    ListenChar(0);
    Priority(1); %Set Maximun Priority to Window win    

    time1 = GetSecs();
    for tr =1 : size(Exp.Trial, 1)
        Exp = showTrial(Exp, tr); % function to present each trial
        % Elegant exit
        if tr == size(Exp.Trial, 1) || Exp.responses.ActualResponse(1) == Exp.addParams.exitKey
            Screen('Close', [Exp.stimuli.frameTex Exp.stimuli.CheckTexs Exp.stimuli.mondrianTexVector] );
            break;
        end
    end

    time2 = GetSecs();
    Exp.totalDuration = time2 - time1; % total duration of the experiment in seconds

    %Save results
    save(Exp.Gral.SubjectName, 'Exp')
    
    %% Plot timing control
    timing_diagnosis( Exp.expinfo, Exp.Cfg)

    %% Shut down
    Priority(0);
    Screen('CloseAll');
    sca
    ShowCursor;


catch % ME1
    sca;
    %     rethrow(ME1);
    rethrow(psychlasterror);
end

%% HISTORY

% 02/06/2011    LK.     --Calculated the total duration of each block

% 04/06/2011    MS.     --Set the objective question first and the
%                       subjective question second. Randomized the order of
%                       presentation of the "yes" and "no".

% 05/06/2011    LK.     --Created the matrix for timing control. We
%                       preallocate it just after trial_generation
%                       --Added timing_diagnosis plot at the end of
%                       experiment
%                       --Simple backward masking. Changed trial_definition
%                       and showTrial: now we can specify the number of
%                       mondrians and their time of presentation. We can 
%                       choose to use only 2 mondrians
%                       in order to run the backward masking controls.


