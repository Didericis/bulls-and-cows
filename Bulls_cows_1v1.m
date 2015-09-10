%Guesses scenario 1v1
function[guesses] = Bulls_cows_1v1(guesses_param,real_param)

    %Defines global variables
    global cur_right
    global guess_count
    
    %Defines real
    real = real_param;

    %Misc variable declarations
    used_guess_index_A2 = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    used_guess_index_B2 = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    type_evaluation = 1;
    
    %Defines possibles (components for total_possible)
    A = [1; 2; 3; 4];
    B = [5; 6; 7; 8];
    A2 = [1, 2; 3, 4];
    B2 = [5, 6; 7, 8];
    C = [9, 0];
    
    %Defines total_possible
    total_possible = zeros(16,4);
    tp_iter = 0;
    for i = 1:4
        for k = 1:4
            tp_iter=tp_iter + 1;
            total_possible(tp_iter,1) = A(i,1);
            total_possible(tp_iter,2) = B(k,1);
            total_possible(tp_iter,3:4) = C(1,1:2);
        end
    end

    %Loop for making and evaluating guesses
    while cur_right ~=4

        %Adds one to the guess count for each pass, displays guess number
        guess_count = guess_count + 1;
        fprintf('----Guess %d----\n', guess_count);

        %On 3rd guess, always uses first indexes in A and B
        if guess_count == 3
            fprintf('(default this type)\n');
            guess = zeros(1,4);
            cur_guess_index_A2 = 1;
            cur_guess_index_B2 = 1;
            guess(1,1:2) = A2(cur_guess_index_A2,1:2);
            guess(1,3:4) = B2(cur_guess_index_B2,1:2);
            previous_guess = guess;
            used_guess_index_A2(guess_count-2) = cur_guess_index_A2;
            used_guess_index_B2(guess_count-2) = cur_guess_index_B2;

        %The following steps determine which guess to make next.
        %This is the basic process:
        %-------------------------
        %1 - Determine type
        %2 - Inverse, Keep, or Use Next for both A and B
        %3 - Generate guess
        %4 - Store guess as previous guess
        %5 - Add used indexes to used indexes array


        %Inverses both guesses
        elseif cur_right == 0
            fprintf('Inverses both A and B values: \n')
            for i = 1:size(A2,1)
                if previous_guess(1,1:2) ~= A2(i)
                    cur_guess_index_A2 = i;
                end
            end
            for i = 1:size(B2,1)
                if previous_guess(1,3:4) ~= B2(i)
                    cur_guess_index_B2 = i;
                end
            end
            guess(1,1:2) = A2(cur_guess_index_A2, 1:2);
            guess(1,3:4) = B2(cur_guess_index_B2,1:2);
            previous_guess = guess;
            used_guess_index_A2(guess_count-2) = cur_guess_index_A2;
            used_guess_index_B2(guess_count-2) = cur_guess_index_B2;


        %Keeps A, uses B next
        elseif cur_right == 1
            fprintf('Keeps A value, uses next B value: \n');
            cur_guess_index_B2 = cur_guess_index_B2 + 1;
            if cur_guess_index_B2 == 3
                cur_guess_index_B2 = 1;
            end
            for i = 1:length(used_guess_index_B2)
                if cur_guess_index_B2 == used_guess_index_B2(i)
                    cur_guess_index_B2 = cur_guess_index_B2 + 1;
                    i = 1;
                    if cur_guess_index_B2 == 3
                       cur_guess_index_B2 = 1;
                    end
                end
            end
            guess(1,1:2) = A2(cur_guess_index_A2, 1:2);
            guess(1,3:4) = B2(cur_guess_index_B2, 1:2);
            previous_guess = guess;
            used_guess_index_A2(guess_count-2) = cur_guess_index_A2;
            used_guess_index_B2(guess_count-2) = cur_guess_index_B2;
        
        %Uses next
        elseif cur_right == 3
            cur_guess_index_B = cur_guess_index_B + 1;
            guess(1) = A(cur_guess_index_A);
            guess(2) = B(cur_guess_index_B);
            guess(3:4) = C(1:2);
        else
            type_evaluation = 2;
            if cur_guess_index_B2 == 1
                cur_guess_index_B = 1;
            else
                cur_guess_index_B = 3;
            end
            if cur_guess_index_A2 == 1
                cur_guess_index_A = 1;
            else
                cur_guess_index_A = 3;
            end
            guess(1) = A(cur_guess_index_A);
            guess(2) = B(cur_guess_index_B);
            guess(3:4) = C(1:2);

        end

        %If there is only one possible guess, uses it
        if size(total_possible,1) == 1
            guess = total_possible(1,1:4);
        end

        %Compares the guess with the real answer, returns cur_right and
        %stores cur_right as wanted right. Each guess's cur_right 
        %evaluation is then stored in array "answers"
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
        
        %Determines the types when comparing A2 to B2
        if type_evaluation == 1
            for i = 1:size(total_possible,1)
                if (guess(1) == total_possible(i,1)) || (guess(2) == total_possible(i,1))
                    type_possible(i,1) = 'R';
                else
                    type_possible(i,1) = 'W';
                end
                if (guess(3) == total_possible(i,2)) || (guess(4) == total_possible(i,2)) 
                    type_possible(i,2) = 'R';
                else   
                    type_possible(i,2) = 'W';
                end
            end
        
        %Determines the types when comparing A to B
        elseif type_evaluation == 2
            for i = 1:size(total_possible,1)
                if (guess(1) == total_possible(i,1))
                    type_possible(i,1) = 'R';
                else
                    type_possible(i,1) = 'W';
                end
                if (guess(2) == total_possible(i,2))
                    type_possible(i,2) = 'R';
                else   
                    type_possible(i,2) = 'W';
                end
            end   
        end

        %Adds the current guess to an array of all total guesses called
        %"guesses"
        guesses_param(guess_count,1:4) = guess(1,1:4);
        
        %Re-assigns origina cur_right for the guess (has been changed 
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