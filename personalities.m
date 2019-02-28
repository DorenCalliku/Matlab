%% Algorithm
% Find the way to create a meaningful model about people's personalities. 
% Personality(economic_stability, psychological_stability, ambitions, colority)
% Create the personality matrix. 

% number of factors affecting the personality
%factors = 4; % Entered as an argument to the function.

%% Code

function [male, female] = personalities(male_no, female_no, factors)

male = rand(male_no,factors);
female = rand(female_no,factors);
personality = zeros(male_no,female_no,factors);

% find how similar are these two people in the grid
for i = (1:male_no)
    personality(i,:)= abs(female-male(i));
end

return
end
