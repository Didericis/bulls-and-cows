%Guesses scenario 3v0 or 0v3
function[guesses] = bulls_cows_3v0(scenario,guesses_param,real_param)

    %Defines global variables
    global guess_count
    global cur_right
    
    %Defines Real
    real = real_param;
    
    %Misc Variable Declarations
    used_guess_index_A = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    used_guess_index_B = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    
    %Defines possibles (components for total_possible)
    if scenario == 1
    A = [1, 2, 3; 1, 2, 4; 1, 3, 4; 2, 3, 4];
    B = [9;0];
    elseif scenario == 2
    A = [5, 6, 7; 5, 6, 8; 5, 7, 8; 6, 7, 8];
    B = [9;0];
    end

    %Defines total possible 
    tp_iter = 0;
    for i = 1:4
        for j = 1:2
            tp_iter = tp_iter + 1;
            total_possible(tp_iter,1:3) = A(i,1:3);
            total_possible(tp_iter,4) = B(j,1);
        end
    end
    
    %loop for making/evaluating guesses
    while cur_right ~= 4

        %Adds one to the guess count for each pass, displays guess number
        guess_count = guess_count + 1;
        fprintf('----Guess %d----\n', guess_count);

        %On 3rd guess, use first indexes in A and B
        if guess_count == 3
            fprintf('(default this type)\n');
            guess = zeros(1,4);
            cur_guess_index_A = 1;
            cur_guess_index_B = 1;
            guess(1,1:3) = A(cur_guess_index_A,1:3);
            guess(1,4) = B(cur_guess_index_B,1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;
            
        %The following steps determine which guess to make next.
        %This is the basic process:
        %-------------------------
        %1 - Determine type
        %2 - Inverse, Keep, or Use Next for both A and B
        %3 - Generate guess
        %4 - Store guess as previous guess
        %5 - Add used indexes to used indexes array

        %Keeps A, uses B next
        elseif RW == 1
            fprintf('Keeps A value, uses next B value: \n');
            cur_guess_index_B = cur_guess_index_B + 1;
            if cur_guess_index_B == 3
                cur_guess_index_B = 1;
            end
            guess(1,1:3) = A(cur_guess_index_A, 1:3);
            guess(1,4) = B(cur_guess_index_B, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Uses A next, keeps B
        elseif WR == 1
            fprintf('Use next A value, keeps B value: \n');
            cur_guess_index_A = cur_guess_index_A + 1;
            guess(1,1:3) = A(cur_guess_index_A, 1:3);
            guess(1,4) = B(cur_guess_index_B, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Uses both next
        elseif WW == 1
            fprintf('Use next A value & B value: \n');
            if cur_guess_index_A ~= 4
                cur_guess_index_A = cur_guess_index_A + 1;
            end
            cur_guess_index_B = cur_guess_index_B + 1;
            if cur_guess_index_B == 3
                cur_guess_index_B = 1;
            end
            guess(1,1:3) = A(cur_guess_index_A, 1:3);
            guess(1,4) = B(cur_guess_index_B, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;
        end
        
        %If there is only one possible guess, use it
        if size(total_possible,1) == 1
            guess = total_possible(1,1:4);
        end

        %Compares the guess with the real answer, returns cur_right and
        %stores cur_right as wanted right.
        cur_right_eval(real,guess);
        wanted_right = cur_right;


        %Compares the guess with total_possible combinations and creates an
        %array storing the cur_right values for each called
        %"total_right_results"
        for i = 1:size(total_possible,1)
            cur_right_eval(total_possible(i,1:4),guess);
            total_right_results(i,1)=cur_right;
        end

        %Creates a new array of total_possible combinations for values in
        %which "total_right_results" is equal to cur_right (aka
        %wanted_right)
        n=0;
        clear possible
        for i=1:size(total_possible,1)
            cur_right_eval(total_possible(i,1:4),guess);
            if total_right_results(i,1)==wanted_right
               n=n+1;
               possible(n,1:4)=total_possible(i,1:4);
            end
        end
        clear total_possible
        total_possible = zeros(size(possible,1),4);
        total_possible = possible;

        clear type_possible

        %----------TYPE EVALUATIONS BELOW---------
        
        %Initializes types for each guess count
        RW = 0;
        WR = 0;
        WW = 0;

        %R,W,P evaluation
        for i = 1:size(total_possible,1)
            if isequal(guess(1:3),total_possible(i,(1:3)))
                type_possible(i,1)='R';
            else
                type_possible(i,1)='W';
            end
            %-----
            if isequal(guess(4),total_possible(i,4))
                type_possible(i,2)='R';
            else
                type_possible(i,2)='W';
            end
        end
        
        %Combination evaluations
        for i = 1:size(type_possible,1)
            if strcmp(type_possible(i,1:2),'RW')
                RW = 1;
            elseif strcmp(type_possible(i,1:2),'WR')
                WR = 1;
            elseif strcmp(type_possible(i,1:2),'WW')
                WW = 1;
            end
        end
        %Adds the current guess to an array of all total guesses called
        %"guesses"
        guesses_param(guess_count,1:4) = guess(1,1:4);
        
        %Re-assigns original cur_right for the guess (has been changed 
        %throughout the function)
        cur_right=wanted_right;
        
        %Changes the order of each guess so as to be as different as
        %possible
        guesses_param=order_change4(guesses_param,real);
        
        %Displays the guess used and the number of correct values:
        fprintf('Current Guess:');
        disp(guesses_param(guess_count,1:4));
        fprintf('%d number(s) are correct\n\n', cur_right);
    end
    clear guesses
    guesses = guesses_param;
end