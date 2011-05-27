function Exp = trials_definition (Exp)

Exp.stimuli.randomTrials = 1; % 1 randomize, 0 do not randomize trials
Exp.stimuli.stimDur = 100; %total number of frames for the stimuli presentation -mondrians-
Exp.stimuli.mondrianRate = 10; % numbers of frames to present each mondrian
% mondrianChanges= 1:10:100;
Exp.stimuli.ITI = [21 42 63 85];

Exp.stimuli.stimDur = 85;

% nTrials = 48; % trials per condition
contrast = [0.02 0.04 0.08 0.16 0.32 0.64 0.96]; % michelson contrast 
checkLocation = [1 2 3 4];
% locations = 1: up; 2: down; 3: Left; 4: right;
timing = {[39 49 59 69] [32 42 52 62] [36 46 56 66] };
% timingConds = { 'backwardMasking' 'forwardMasking' 'middleMasking'}; % 1, 2, 3

Exp.stimuli.mondrianEyeLocation = 2; % 1: mondrians to the left eye; 2: mondrians to the righ eye

repetitions= 2; % repetition of the minimun design -one trial per condition-

% Create the block of 84 trials
Trial = zeros(length(contrast) * length(timing) * length (checkLocation), 7);
count = 1;
for m= 1 : length(contrast)
    for j = 1 : length(timing) % timing conditions
        for k = 1 : length (checkLocation)

            Trial(count, 1) = Exp.Gral.SubjectNumber; % subject number
            Trial(count, 2) = Exp.Gral.SubjectBlock; % Block number
            Trial(count, 3) = contrast(m); % contrast value
            randi = ceil(rand(1)*4);
            Trial(count, 4) = timing{j}(randi); % timing value
            Trial(count, 5) = j; % code for the timing conditions
            Trial(count, 6) = k; % location of the checkerboard
            Trial(count, 7) = 0; %  responses for locations
            count = count + 1; 
        end
    end
end

Exp.Trial = repmat(Trial, repetitions, 1);

% randomize trials
if Exp.stimuli.randomTrials
    randi = randperm(length(Exp.Trial));
    Exp.Trial = Exp.Trial(randi, :);
end



