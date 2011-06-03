function Exp = showTrial(Exp, tr)

% Create Checkerboard
% im = checkerboard(size,armsR,armsT,cont,mask,sd,inverted)
check1= checkerboard(Exp.stimuli.frameSize, 4, 6, Exp.Trial(tr, 3), 1, 1, 1, Exp.Cfg.Color.inc);
% imshow(check1/255)
CheckTex1 = Screen('MakeTexture', Exp.Cfg.win, check1);
check2= checkerboard(Exp.stimuli.frameSize, 4, 6, Exp.Trial(tr, 3), 1, 1, -1, Exp.Cfg.Color.inc);
CheckTex2 = Screen('MakeTexture', Exp.Cfg.win, check2); % CheckTex2 is a pointer; points to the texture just created;
Exp.stimuli.CheckTexs = [CheckTex1 CheckTex2];
% imshow(check2/255)


% Present the 1 sec of Mondrians and checkerboard
indxs = randperm(length(Exp.stimuli.mondrianTexVector));
indxs = Exp.stimuli.mondrianTexVector(indxs(1:length(Exp.stimuli.mondrianTexVector)));

countMond = 1; % counter for the selection of mondrians

for flp = 1 : Exp.stimuli.stimDur

    % Draw frames for both eyes
    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
    Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);
    % Select the eye to present the mondrians
    if Exp.stimuli.mondrianEyeLocation == 1
        % Draw the mondrians
        % Draw every n frames a different mask (picked up randomly from the 40
        % mondrians on each trial)
        Screen('DrawTextures', Exp.Cfg.win, indxs(countMond), [], Exp.stimuli.destFrame_left)
        % Draw the checkerboard
        if flp == Exp.Trial(tr, 4)
            randi = randperm(length(Exp.stimuli.CheckTexs));
            % Draw the checkerboard on the correct location
            switch Exp.Trial(tr, 6)
                case {1}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.RightCheck_Top);
                case {2}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.RightCheck_Bottom);
                case {3}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.RightCheck_Left);
                case {4}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.RightCheck_Right);
            end
            
        elseif flp == Exp.Trial(tr, 4) + 1
            switch Exp.Trial(tr, 6)
                case {1}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.RightCheck_Top);
                case {2}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.RightCheck_Bottom);
                case {3}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.RightCheck_Left);
                case {4}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.RightCheck_Right);
            end

        end

    elseif Exp.stimuli.mondrianEyeLocation == 2
        % Draw the mondrians
        % Draw every n frames a different mask (picked up randomly from the 40
        % mondrians on each trial)
        Screen('DrawTextures', Exp.Cfg.win, indxs(countMond), [], Exp.stimuli.destFrame_right)
        if flp == Exp.Trial(tr, 4)
            randi = randperm(length(Exp.stimuli.CheckTexs));
            % Draw the checkerboard on the correct location
            switch Exp.Trial(tr, 6)
                case {1}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.LeftCheck_Top);
                case {2}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.LeftCheck_Bottom);
                case {3}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.LeftCheck_Left);
                case {4}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(1)), ...
                        [], Exp.stimuli.LeftCheck_Right);
            end
            
        elseif flp == Exp.Trial(tr, 4) + 1
            switch Exp.Trial(tr, 6)
                case {1}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.LeftCheck_Top);
                case {2}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.LeftCheck_Bottom);
                case {3}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.LeftCheck_Left);
                case {4}
                    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.CheckTexs(randi(2)), ...
                        [], Exp.stimuli.LeftCheck_Right);
            end

        end

    end
    
    %Draw fixation point
    FixdotDims = [Exp.stimuli.xLeft-4, Exp.stimuli.xRight-4; Exp.stimuli.yLeft-4, Exp.stimuli.yRight-4; ...
    Exp.stimuli.xLeft+4, Exp.stimuli.xRight+4; Exp.stimuli.yLeft+4, Exp.stimuli.yRight+4;]; 
    Screen('FillOval', Exp.Cfg.win, [255 0 0], FixdotDims);



    % Flip stimuli on the screen
    Screen('Flip', Exp.Cfg.win, [], Exp.Cfg.AuxBuffers);
    %     if flp == checkFrames(1) || flp == checkFrames(2)
    %         KbWait()
    %         WaitSecs(0.5)
    %     end

    % use the mod function for presenting the mondrians
    if mod(flp, Exp.stimuli.mondrianRate) == 0
        countMond = countMond +1;
    end

end


%% Present the blank interval
blankInterval = 15;
for flp =1 : blankInterval
    % Draw frames for both eyes
    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
    Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);
    %Draw fixation point
    FixdotDims = [Exp.stimuli.xLeft-4, Exp.stimuli.xRight-4; Exp.stimuli.yLeft-4, Exp.stimuli.yRight-4; ...
    Exp.stimuli.xLeft+4, Exp.stimuli.xRight+4; Exp.stimuli.yLeft+4, Exp.stimuli.yRight+4;]; 
    Screen('FillOval', Exp.Cfg.win, [255 0 0], FixdotDims);
    
    % Flip stimuli on the screen
    Screen('Flip', Exp.Cfg.win, [], Exp.Cfg.AuxBuffers);

end

%% OBJECTIVE RESPONSES: POSITION
% Draw frames for both eyes
Screen('FillRect',  Exp.Cfg.win, Exp.Cfg.Color.inc);
Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);

% Draw Arrows
Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.arrow, [], ...
    [Exp.stimuli.LeftArrow_Left ; Exp.stimuli.LeftArrow_Right; ...
    Exp.stimuli.LeftArrow_Top; Exp.stimuli.LeftArrow_Bottom; ...
    Exp.stimuli.RightArrow_Left ; Exp.stimuli.RightArrow_Right; ...
    Exp.stimuli.RightArrow_Top; Exp.stimuli.RightArrow_Bottom]', [270 90 0 180 270 90 0 180]);

%Draw fixation point
    FixdotDims = [Exp.stimuli.xLeft-4, Exp.stimuli.xRight-4; Exp.stimuli.yLeft-4, Exp.stimuli.yRight-4; ...
    Exp.stimuli.xLeft+4, Exp.stimuli.xRight+4; Exp.stimuli.yLeft+4, Exp.stimuli.yRight+4;]; 
    Screen('FillOval', Exp.Cfg.win, [255 0 0], FixdotDims);

vbl= Screen('Flip', Exp.Cfg.win,  [], Exp.Cfg.AuxBuffers);

RTflag=0; %Flag to collect only the first response for the trial
%Here begins to count the time for the RTs
time2 = GetSecs;
%Take the time for the duration startAdaptation-startTest
% Exp.Synch.time(tr)= time2-time1;
while (RTflag==0)
    waitTime=0; % interval of time to check for a response inside each flip
    while (waitTime < (Exp.Cfg.MonitorFlipInterval-0.005) && RTflag==0)
        [keyIsDown, T, keyCode ] = KbCheck; %#ok
        if  (keyIsDown)
            T = GetSecs;
            Exp.responses.ActualResponse= KbName(keyCode);
            if iscell(Exp.responses.ActualResponse)
                Exp.responses.ActualResponse= []; % The subject pressed two simulatneos butons
            end
            Exp.responses.RT= T - time2;
            RTflag=1;
            break;
        end
        %wait 5ms in between each Check to avoid 'overheating'
        WaitSecs(0.005);
        leavingTime= GetSecs;
        waitTime= leavingTime - vbl;
    end
end

% Recode the responses

if isempty(Exp.responses.ActualResponse)
    Exp.Trial(tr, 7) = 0;
    % locations = 1: up; 2: down; 3: Left; 4: right;
elseif strcmpi(Exp.responses.ActualResponse, 'Up')
    Exp.Trial(tr, 7) = 1;
elseif strcmpi(Exp.responses.ActualResponse, 'Down')
    Exp.Trial(tr, 7) = 2;
elseif strcmpi(Exp.responses.ActualResponse, 'Left')
    Exp.Trial(tr, 7) = 3;
elseif strcmpi(Exp.responses.ActualResponse, 'Right')
    Exp.Trial(tr, 7) = 4;
elseif strcmpi(Exp.responses.ActualResponse, Exp.addParams.exitKey)
    % just do nothing
else
    display('Error in coding responses!!!!')
    return
end

while keyIsDown
    keyIsDown = KbCheck;
    WaitSecs(0.01);
end

%% SUBJECTIVE RESPONSES
% Draw frames for both eyes
Screen('FillRect',  Exp.Cfg.win, Exp.Cfg.Color.inc);
Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);
%Draw fixation point
    FixdotDims = [Exp.stimuli.xLeft-4, Exp.stimuli.xRight-4; Exp.stimuli.yLeft-4, Exp.stimuli.yRight-4; ...
    Exp.stimuli.xLeft+4, Exp.stimuli.xRight+4; Exp.stimuli.yLeft+4, Exp.stimuli.yRight+4;]; 
    Screen('FillOval', Exp.Cfg.win, [255 0 0], FixdotDims);

    randNum = round(rand(1));
if randNum
    Screen('DrawText',Exp.Cfg.win, 'Yes', Exp.stimuli.xLeft - 70, Exp.stimuli.yLeft, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'No', Exp.stimuli.xLeft + 50, Exp.stimuli.yLeft, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'Yes', Exp.stimuli.xRight -70, Exp.stimuli.yRight, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'No', Exp.stimuli.xRight +50, Exp.stimuli.yRight, [0 0 255]);
else
    Screen('DrawText',Exp.Cfg.win, 'No', Exp.stimuli.xLeft - 70, Exp.stimuli.yLeft, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'Yes', Exp.stimuli.xLeft + 50, Exp.stimuli.yLeft, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'No', Exp.stimuli.xRight -70, Exp.stimuli.yRight, [0 0 255]);
    Screen('DrawText',Exp.Cfg.win, 'Yes', Exp.stimuli.xRight +50, Exp.stimuli.yRight, [0 0 255]);
end

vbl= Screen('Flip', Exp.Cfg.win,  [], Exp.Cfg.AuxBuffers);

RTflag=0; %Flag to collect only the first response for the trial
%Here begins to count the time for the RTs
time2 = GetSecs;
%Take the time for the duration startAdaptation-startTest
% Exp.Synch.time(tr)= time2-time1;
while (RTflag==0)
    waitTime=0; % interval of time to check for a response inside each flip
    while (waitTime < (Exp.Cfg.MonitorFlipInterval-0.005) && RTflag==0)
        [keyIsDown, T, keyCode ] = KbCheck; %#ok
        if  (keyIsDown)
            T = GetSecs;
            Exp.responses.ActualResponse = KbName(keyCode);
            if iscell(Exp.responses.ActualResponse)
                Exp.responses.ActualResponse= []; % The subject pressed two simulatneos butons
            end
            Exp.responses.RT= T - time2;
            RTflag=1;
            if isempty(Exp.responses.ActualResponse)
                RTflag = 0;
                % locations- 3: Left, means 'yes' ; 4: Right, means 'no';
            elseif strcmpi(Exp.responses.ActualResponse, 'Up')
                RTflag = 0;
            elseif strcmpi(Exp.responses.ActualResponse, 'Down')
                RTflag = 0;
            elseif strcmpi(Exp.responses.ActualResponse, 'Left')
                if randNum
                Exp.Trial(tr, 8) = 3; % 'left' is 'yes'
                else
                Exp.Trial(tr, 8) = 4; % 'left' is 'no'
                end
            elseif strcmpi(Exp.responses.ActualResponse, 'Right')
                if randNum
                    Exp.Trial(tr, 8) = 4;
                else
                    Exp.Trial(tr, 8) = 3;
                end
            elseif strcmpi(Exp.responses.ActualResponse, Exp.addParams.exitKey)
                % just do nothing
            else
                display('Error in coding responses!!!!')
                return
            end

            break;
        end
        %wait 5ms in between each Check to avoid 'overheating'
        WaitSecs(0.005);
        leavingTime= GetSecs;
        waitTime= leavingTime - vbl;
    end
end

while keyIsDown
    keyIsDown = KbCheck;
    WaitSecs(0.01);
end
%% ITI
randi = randperm(length(Exp.stimuli.ITI));
for flp =1 : Exp.stimuli.ITI(randi(1))
    % Draw frames for both eyes
    Screen('DrawTextures', Exp.Cfg.win, Exp.stimuli.frameTex, [], Exp.stimuli.destFrame);
    Screen('FillRect', Exp.Cfg.win, Exp.Cfg.Color.inc, Exp.stimuli.newRect);
    % Flip stimuli on the screen
    Screen('Flip', Exp.Cfg.win, [], Exp.Cfg.AuxBuffers);
end




