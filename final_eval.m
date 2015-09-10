%Steps to evaluate final few guesses; calculates possible permutations
function[final_guesses]=final_eval(guesses_param,real_param)
    
    %Defines global variables
    global Bulls
    global guess_count
    global cur_right
    
    %Compares guesses to real, stores # of bulls in new variable "Bulls_array"
    %NOTE: DOES NOT COUNT AS EXTRA SINCE THE LAST GUESSES HAVE NOT BEEN
    %ALTERED. IS REMINDING COMPUTER THE BULLS FOR THE LAST GUESSES
    for i = 1:size(guesses_param,1)
        Bulls_eval(guesses_param(i,1:4),real_param);
        Bulls_array(i,1) = Bulls;
    end
    
    %Generates permutations for guess with all correct digits
    perms_guess = perms(guesses_param(guess_count,1:4));
    
    %Compares each guess (except for last) to each 
    %permutation of correct guess (last guess), stores in new variable
    %"Possible_bulls_array"
    %NOTE: DOES NOT INVOLVE COMPARING TO ACTUAL ANSWER, SO NO NEW GUESS
    for i = 1:(guess_count-1)
        for k = 1:size(perms_guess,1);
            Bulls_eval(guesses_param(i,1:4),perms_guess(k,1:4));
            Possible_bulls_array(k,1) = Bulls;
        end
        
        %Compares Possible_bulls_array to the Bulls_array for the the guess
        %it corresponds to. If they are equal, stores the corresponding
        %perms_guess as "new_perms_guess"
        new_index = 0;
        if size(perms_guess,1)~= 1
            clear new_perms_guess
        end
        for k = 1:size(perms_guess,1);
            if Possible_bulls_array(k,1) == Bulls_array(i,1)
                new_index = new_index+1;
                new_perms_guess(new_index,1:4) = perms_guess(k,1:4);
            end
        end
        clear perms_guess
        perms_guess = new_perms_guess;
                 
    end
    
    new_index = 0;
    
    %Evaluates number of bulls in the last guess. If it's = to 4, does
    %nothing (guess was correct)
    Bulls_eval(guesses_param(guess_count,1:4),real_param(1,1:4))
    if Bulls == 4
        
    %If the last guess didn't have four bulls, makes a new guess based on
    %possible permutations of the last guess
    else
        while Bulls ~= 4
            new_index = new_index+1;
            guess_count = guess_count + 1;
            guesses_param(guess_count,1:4) = perms_guess(new_index,1:4);
            Bulls_eval(perms_guess(new_index,1:4),real_param)
            
            %Displays
            fprintf('----Guess %d----\n', guess_count);
            fprintf('Current Guess:');
            disp(guesses_param(guess_count,1:4));
            cur_right_eval(guesses_param(guess_count,1:4),real_param);
            fprintf('%d number(s) are correct\n\n', cur_right);
        end
    end
    
    fprintf('\n------------------------------------------------------\n\n');
    final_guesses=guesses_param;
    

    
            
            
    
    
    
        