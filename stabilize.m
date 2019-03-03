%{
% => takes biggest for each column-row intersection.   
%   1. get > constant, others 0
%   2. while !(all 0 or 1)
%          3. find biggest position
%          4. send everybody else in the row and column to 0
%}

function grid = stabilize(grid_input)
    grid = rescale(grid_input);
    grid = grid .* (grid > 0.5);
    
    % check if there are more values than 0's and 1's
    while sum(grid(:),'all') - sum( (grid == 1) ,'all' ) > 0
        % take max of those values
        [i,j] = find( grid == max( grid - (grid==1),[],'all'));
        % make 1 and 0's accordingly - only one relationship allowed
        grid(i,:) = 0; grid(:,j) =0; grid(i,j) = 1;
    end
    return
end
