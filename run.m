%% Relationship-Options connections
%{
# Requirements: Create a model for relationships in a field with options. 
To be done: 
1. Action Function based on personality, stability and options. 
2. Scaling to keep things in the radius of 1. 
%}

clear;clc;clf;
no_male = 4;
no_female = 4;
factors = 4; 
%% Create grid of random stability for the start
stability   = zeros(no_male,no_female);

male   = rand(no_male,factors);
female = rand(no_female,factors);

% make ambitions to go from 0.5 to 1.
male(:,factors)   = male(:,factors) ./2 + 0.5;
female(:,factors) = female(:,factors) ./2 + 0.5;

% increasing similarity increases the personality correlation because of this trick
personality = ones( no_male,no_female, factors);
for i = (1: no_male)
    personality(i,:,:)= abs(female-repmat(male(i,:),no_female,1));
end
    
%% Options
partner = 0.3;
[no,no_1] = size(stability);
%female_options = sum(stability> partner, 1) ;
%male_options   = sum(stability> partner, 2) ;
male_opt       = repmat(sum(stability> partner, 2).',no_1,1);
female_opt     = repmat(sum(stability> partner, 1),no,1);
options = abs(female_opt-male_opt);

%% Expectations

ambition = personality(:,:,factors);

% expectations factor is the distance between what you want, and what the stability is,
% + if ambition differences exist then, depending on these differences increase the expectations limit. 
expect = (ambition - stability) + ((ambition - stability)>0) .* options/10;

%% Actions 
actions = expect; 

%% Run the connection matrix. 
looping = 10;
for i = (1:looping)
    
    stability = stability + actions;
    
    status = stability( stability);
    
    % stability change
    stability = rescale(stability .* status)  + (stability .* ~status)/3;
    previous_status = status;
    if i == 10 || i == 20
       stability = stability - 1; 
    end
    
    imagesc(stability>0.5);
    colorbar;
    axis equal off;
    pause(1);
end
