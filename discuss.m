%{
Discuss is the group contribution to the information that one has. 
If the people close to us have had a relationship with the person, then we take that in consideration. 
%}

function [new_exp,new_rels] = discuss( new_memory,female_friends,male_friends)
    % female experience
    left_exp     = circshift(new_memory, female_friends,2); % indices shifted to right
    right_exp    = circshift(new_memory,-female_friends,2); % shift to left

    % male experience
    up_exp       = circshift(new_memory, male_friends,1); % up
    down_exp     = circshift(new_memory,-male_friends,1); % down
    
    % female rels
    left_rels     = circshift(new_memory>0, female_friends,2); % indices shifted to right
    right_rels    = circshift(new_memory>0,-female_friends,2); % shift to left

    % male rels
    up_rels       = circshift(new_memory>0, male_friends,1); % up
    down_rels     = circshift(new_memory>0,-male_friends,1); % down
    % experience is the my experience and experience of my close friends
    new_exp      = left_exp + new_memory + right_exp + up_exp + down_exp;
    new_rels     = left_rels + right_rels + new_memory>0 + up_rels + down_rels;
    return
end
