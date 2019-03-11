%% Start the variables
clear;clc; clf;
iterations  = 200;
no_male     = 50; no_female = 50; factors   = 3; % initial parameters

rand_factor = 0.5 ;stable_factor =0.5; % distribution of desire for stability => check create
relationship_constant = 0.5; doubt_constant = 0; 

jump_start  = 1.2; delusion_effect = 0.3; normal = 1; % action related
flirting_constant = 0.0; % 1-flirting potential for a person
decrease_factor = 2; skip_one = 0.999; % stabilize the relationships that one has
ex_effect = 2; % increase importance of options difference
female_friends   = 4; male_friends = 1;

%% Run

% simplified_run(iterations,no_male,no_female,factors,rand_factor,stable_factor,
% relationship_constant,doubt_constant,jump_start,delusion_effect,normal,
% flirting_constant,decrease_factor,skip_one)
%simplified_run(iterations,no_male,no_female,factors,rand_factor,stable_factor,...
%relationship_constant,doubt_constant,jump_start,delusion_effect,normal,...
%flirting_constant,decrease_factor,skip_one, ex_effect);
%simplified_run(100,10,10,4,0.5,0.5,0.5,0,1,0.05,0.5,0.0,2,0.999);

%% The code
%function simplified_run(iterations,no_male,no_female,factors,rand_factor,stable_factor,relationship_constant,doubt_constant,jump_start,delusion_effect,normal, flirting_constant,decrease_factor,skip_one,ex_effect)
   
    rels          = zeros(1,iterations); % relationships
    rels_change   = zeros(1,iterations); % relationships' alterations
    relationships = zeros(no_male,no_female);
    
    stability   = zeros(no_male,no_female); % relationship stability
    rounds      = zeros(no_male,no_female); % rounds per relationship
    status      = zeros(no_male,no_female); % status : in/out of relationship
    
    filter      = rand( no_male,no_female)>flirting_constant; % flirting filter
    memory      = zeros(no_male,no_female);
    experience  = zeros(no_male,no_female);
    
    %% Personalities creation
    male   = rand(  no_male,factors); female = rand(no_female,factors);
    [male,female, personality]  = create(male,female,no_male,no_female,factors,rand_factor,stable_factor);
    %[male,female,personality]  = create_perfect_matches(no_male,no_female,factors);
    
    %% Iteration
    for i = (1:iterations)
        % In the beginning of each iteration, there is a need for the market to show more reliability than it has.
        improved_personality = perceive(personality,rounds);
        personality_diff     = sum(improved_personality,3)/4;
        
        % checking my options of flirting
        % Filtering the people I can flirt with (assume of geographical positions)
        %options   = flirt(stability);
        options    = flirt2(stability,improved_personality,personality_diff,relationship_constant);
        options    = filter .* options + ~filter .* options * ex_effect;

        % creating my expectations for each combination based on personality and options
        % based on expectations I act
        expectations = expect( personality, stability, options, female, male, personality_diff);
        actions      = act(expectations, rounds,jump_start, delusion_effect, normal);
        
        % remember in order to check change in relationships
        previous_status = status;
        
        % my actions affect my stability with each possible         
        % I choose the best relationship and decrease the other people's chances
        stability       = (stability + (rand(no_male,no_female)-doubt_constant).*(actions));%filter.*
        status          = stabilize(stability);
        stability       = (stability .* status + (stability .* ~status)/decrease_factor).*(stability<1)+(stability>1)*skip_one;
        
        % check which relationships did not work out, negate them, and remember the number of rounds they were working.
        % check your friends' experience with that partner, and if it was long-lasting, improve that potential's partner chances
        status_change   = ( previous_status - status) > 0;
        relationships   = relationships + status_change;
        new_memory      = remember( status_change, rounds);
        [new_experience,new_rels] = discuss(  new_memory, female_friends, male_friends);
        relationships   = relationships + new_rels;
        memory          = memory     + new_memory;
        experience      = experience + new_experience;
            
        % change the options for the next turn
        % if there is an experience, check how it was
        marginal_exp = experience ./ relationships;
        marginal_exp(~isfinite(marginal_exp))=0;
        filter        = (marginal_exp>=30) + (marginal_exp<=0) + (marginal_exp<30 & marginal_exp>0)*0.8;
        
        % increase the rounds the stable relationship has run
        rounds       = iterate(stability, relationship_constant, rounds);        
        imagesc(stability);
        rels(i,1) = sum(status,'all');
        rels_change(i,1)=sum(abs(status-previous_status),'all');
        colorbar;
        axis equal off;
        pause(0.05);
        
    end
    
    %% Plot
    imagesc(marginal_exp);
    colorbar;
    axis equal off;
    title('Experience.')
    %avg_male   = mean(sum(memory+rounds,2));
    %avg_female = mean(sum(memory+rounds));
%end
