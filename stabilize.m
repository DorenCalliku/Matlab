%{
% => takes biggest for each column-row intersection.   
%   1. get > constant, others 0
%   2. while !(all 0 or 1)
%          3. find biggest position
%          4. send everybody else in the row and column to 0
%}

function grid = stabilize(grid_input)
    grid = grid_input;
    % trick pass to the >1 problem
    grid = grid .* (grid > 0.5 & grid<1)+((grid>=1).*0.9999);
    %grid
    
    % check if there are more values than 0's and 1's
    while sum(grid(:),'all') - sum( (grid >= 1) ,'all' ) > 0
        % take max of those values         
        %max((grid - (grid==1)),[],'all')
        [i,j] = find(grid==max(grid - (grid>=1).*grid,[],'all'),1,'first');
        
        % make 1 and 0's accordingly - only one relationship allowed
        grid(i,:) = 0; grid(:,j) =0; grid(i,j) = 1;
    end
    % decrease the chances of other people to become partner with your crew
    %stability    = stability .* status + rescale((stability .* ~status),0,0.5);
    return
end
