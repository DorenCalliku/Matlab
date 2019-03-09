%% Start the variables
clear;clc; clf;
iterations  = 100;
no_male     = 6; no_female = 6; factors   = 4; % initial parameters

rand_factor = 0.4 ;stable_factor =0.6; % distribution of desire for stability => check create
relationship_constant = 0.5; doubt_constant = 0; 

jump_start  = 1.2; delusion_effect = 0.3; normal = 0.5; % action related
flirting_constant = 0.0; % 1-flirting potential for a person
decrease_factor = 1.5; skip_one = 0.999; % stabilize the relationships that one has
ex_effect = 2; % increase importance of options difference
%% Run

% simplified_run(iterations,no_male,no_female,factors,rand_factor,stable_factor,
% relationship_constant,doubt_constant,jump_start,delusion_effect,normal,
% flirting_constant,decrease_factor,skip_one)
simplified_run(iterations,no_male,no_female,factors,rand_factor,stable_factor,...
relationship_constant,doubt_constant,jump_start,delusion_effect,normal,...
flirting_constant,decrease_factor,skip_one, ex_effect);
%simplified_run(100,10,10,4,0.5,0.5,0.5,0,1,0.05,0.5,0.0,2,0.999);