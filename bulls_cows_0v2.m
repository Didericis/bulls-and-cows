%Guesses scenario 2v0 or 0v2
function[guesses] = bulls_cows_0v2(scenario,guesses_param,real_param)

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
    A = [1, 2; 1, 3; 1, 4; 2, 3; 2, 4; 3, 4];
    B = [9,0];
    elseif scenario == 2
    A = [5, 6; 5, 7; 5, 8; 6, 7; 6, 8; 7, 8];
    B = [9,0];
    end

    %Defines total possible 
    tp_iter = 0;
    for i = 1:6
        tp_iter = tp_iter + 1;
        total_possible(tp_iter,1:2) = A(i,1:2);
        total_possible(tp_iter,3:4) = B(1,1:2);
    end
    
    disp(total_possible);
    
    %loop for making/evaluating guesses
    while cur_right ~= 4

        %Adds one to the guess count for each pass, displays guess number
        guess_count = guess_count + 1;
        fprintf('----Guess %d----\n', guess_count);
        
        if guess_count == 3
            fprintf('(default this type)\n');
            cur_guess_index_A = 1;
            cur_guess_index_B = 1;
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;
            
        %On every guess after 3, use first next A vaule, keeps B vaule
        else
            fprintf('Use next A value, keeps B value: \n');
            cur_guess_index_A = cur_guess_index_A + 1;
            for i = 1:length(used_guess_index_A)
                if cur_guess_index_A == used_guess_index_A(i)
                    cur_guess_index_A = cur_guess_index_A + 1;
                    i = 1;
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;
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
            
            