%% Relationship-Options connections
%{
# Requirements: Create a model for relationships in a field with options. 
To be done: 
1. Action Function based on personality, stability and options. 
2. Scaling to keep things in the radius of 1. 
%}

clear;clc;clf;
female  = 20;
male    = 20;
looping = 40;

%% Create grid of random stability for the start
stability   = zeros(male,female);

%% Personality traits
A = rand(male,1);
B = rand(female,1);
personality = zeros(male,female);

% find how similar are these two people in the grid
for i = (1:male)
    personality(i,:)= 1-abs(B-A(i));
end
%personality = personality;
%% Action and Expectations
%action = rand(male,female)-0.5;
%expectations = rand(male,female);
%% Run the connection matrix. 

for i = (1:looping)
    
    action    = rand(male,female)-0.5;
    stability = stability + 2*personality.* action;%+ (stability>0.5) .* expectations;
    
    % find which partners are with which partners
    status = stability_measure( stability);
    
    % stability change
    stability = rescale(stability .* status) ...
                        + (stability .* ~status)/3;
    previous_status = status;
    if i == 10 || i == 20
       %stability = stability - 2; 
    end
    
    imagesc(stability>0.5);
    colorbar;
    axis equal off;
    pause(1);
end
