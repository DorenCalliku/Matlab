%{
Remember creates the memory of people and their relationships. 
Change is status will turn a possible partner into memory for later using this knowledge in relationship building. 
Algorithm:
    Each round take the people who changed status from 1 to 0
    Each combination that decreased will be affected
%}

function memory = remember(status_change, rounds)
    memory = status_change .* rounds;
    return
end