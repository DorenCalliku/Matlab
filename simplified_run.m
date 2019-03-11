%% Start the variables
clear;clc; clf;

iterations  = 50; no_male     = 40; no_female = 40; factors   = 3; 
rand_factor = 0.5; stable_factor = 0.5; % distribution of desire for stability => check create
flirting_constant = 0.0; % 1-flirting potential for a person
decrease_factor = 2; skip_one = 0.999; % stabilize the relationships that one has
ex_effect = 1; % increase importance of options difference
% relationship levels
lower_limit = 20; upper_limit = 40;
% options
relationship_constant = 0.5; doubt_constant = 0.2; consideration_constant = 0.25;
% act
jump_start  = 1.2; delusion_effect = 0.5; normal = 1; % action related
% discuss
female_friends   = 3; male_friends = 2;
% perceive
lower_lie = 1.2; upper_lie = 1;

 
%% Personalities creation

%male   = rand(  no_male,factors); female = rand(no_female,factors);
%[male,female, personality]  = create(male,female,no_male,no_female,factors,rand_factor,stable_factor);
[male,female,personality]  = create_perfect_matches(no_male,no_female,factors);

%% Initialize matrices
%function simplified_run(iterations,no_male,no_female,factors,rand_factor,...
%stable_factor,relationship_constant,doubt_constant,jump_start,delusion_effect,normal,...
%flirting_constant,decrease_factor,skip_one,ex_effect)
    rels          = zeros(1,iterations); % relationships
    rels_change   = zeros(1,iterations); % relationships' alterations
    relationships = zeros(no_male,no_female);
    
    stability   = zeros(no_male,no_female); % relationship stability
    rounds      = zeros(no_male,no_female); % rounds per relationship
    status_rel  = zeros(no_male,no_female); % status_rel : in/out of relationship
    
    filter      = rand( no_male,no_female)>flirting_constant; % flirting filter
    memory      = zeros(no_male,no_female);
    experience  = zeros(no_male,no_female);
    
   
    %% Iteration
    
    for i = (1:iterations)
        
        % In the beginning of each iteration, there is a need for the market to show more reliability than it has.
        %improved_personality = perceive(personality,rounds,lower_limit, upper_limit, lower_lie, upper_lie);
        %personality_diff     = sum(improved_personality,3)/factors;
        personality_diff     = sum(personality,3)/factors;
        % checking my options of flirting
        % Filtering the people I can flirt with (assume of geographical positions)
        options    = flirt2(stability,personality_diff,relationship_constant, consideration_constant);
        options    = filter .* options + ~filter .* options * ex_effect;
        %stability
        % creating my expectations for each combination based on personality and options
        % based on expectations I act
        expectations = expect( personality, stability, options, female, male, personality_diff);
        actions      = act(expectations, rounds,jump_start, delusion_effect, normal, lower_limit, upper_limit);
        
        % remember in order to track change in relationships
        previous_status = status_rel;
        
        % my actions affect my stability with each possible         
        % I choose the best relationship and decrease the other people's chances
        stability       = (stability + (rand(no_male,no_female)-doubt_constant).*(actions));%filter.*
        status_rel      = stabilize(stability);
        status_change   = ( previous_status - status_rel) > 0;
        status_opt      = status_rel;
        
        % check people who are not in a relationship - they are added to the status_rel
        %status_opt(:,find(sum(abs(status_rel)) == 0)) =1;
        %status_opt(find(sum(abs(status_rel')) == 0),:)=1;
        stability       = (stability .* status_opt + (stability .* ~status_opt)/decrease_factor).*(stability<1)+(stability>1)*skip_one;
        
        imagesc(options);
        rels(i,1) = sum(status_rel,'all');
        rels_change(i,1)=sum(abs(status_rel-previous_status),'all');
        colorbar;
        axis equal off;
        pause(0.05);
        % check which relationships did not work out, negate them, and remember the number of rounds they were working.
        % check your friends' experience with that partner, and if it was long-lasting, improve that potential's partner chances
        
        %% Group memory creation
        %relationships   = relationships + status_change;
        new_memory      = remember( status_change, rounds);
        [new_experience,new_rels] = discuss(  new_memory, female_friends, male_friends);
        relationships   = relationships + new_rels;
        memory          = memory     + new_memory;
        experience      = experience + new_experience;
            
        % change the options for the next turn
        % if there is an experience, check how it was
        marginal_exp = experience ./ relationships;
        marginal_exp(~isfinite(marginal_exp))=0;
        %filter        = (marginal_exp>=upper_limit) + (marginal_exp<=0) + (marginal_exp<upper_limit & marginal_exp>0)*0.8;
        
        % increase the rounds the stable relationship has run
        rounds       = iterate(stability, relationship_constant, rounds);        

        
    end
    
   
    
    subplot(2,1,1);
    title('rels.');
    plot(rels);
    
    subplot(2,1,2);
    title('rels change.');
    plot(rels_change);
    
    %imagesc(experience)        
    %axis equal off; colorbar; 
    
    %avg_male   = mean(sum(memory+rounds,2));
    %avg_female = mean(sum(memory+rounds));
%end



