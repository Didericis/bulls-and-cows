function[guesses_param]=order_change4(guesses_param2,real_param)

    %Imports global variables
    global guess_count
    global Bulls
    
    %Evaluates the number of bulls in all guesses before the current guess,
    %stores results in "Bulls_array"
    for i = 1:(size(guesses_param2,1)-1)
        Bulls_eval(guesses_param2(i,1:4),real_param);
        Bulls_array(i) = Bulls;
    end
    
    %Defines the current guess
    cur_guess = guesses_param2(guess_count,1:4);

    %Finds all permutations of cur_guess, stores in perms_guess
    perms_guess = perms(cur_guess);
    
    %Compares all the rows of perms_guess to the previous guess and creates a new
    %array "possible bulls" which records the number of bulls for each
    %permutation
    for i = 1:size(perms_guess,1)
        for k = 1:4
            if perms_guess(i,k) == guesses_param2((guess_count - 1),k)
                possible_bulls(i,k) = 1;
            else
                possible_bulls(i,k) = 0;
            end
        end
    end
    
    %Initializes finish variable
    finish = 0;

    %If the total bulls in a permutation is equal to 
    for i = 1:size(possible_bulls,1)
        total_bulls = 0;
        for k = 1:4
            total_bulls = total_bulls + possible_bulls(i,k);
        end
        if total_bulls == 0
            new_guess = perms_guess(i,1:4);
        end
    end
    %Adds the new version of the guess to guesses array
    guesses_param2(guess_count,1:4) = new_guess;
    guesses_param = guesses_param2;
end
    
    