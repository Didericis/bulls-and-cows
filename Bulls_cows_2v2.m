%Guesses scenario 2v2
function[guesses]=Bulls_cows_2v2(guesses_param,real_param)
    
    %Defines global variables
    global guess_count
    global cur_right
    
    %Defines Real
    real = real_param;
    
    %Misc Variable Declarations
    used_guess_index_A = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    used_guess_index_B = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

    %Defines possibles (components for total_possible)
    A = [1, 2; 1, 3; 1, 4; 2, 3; 2, 4; 3, 4];
    B = [5, 6; 5, 7; 5, 8; 6, 7; 6, 8; 7, 8];

    %Defines total possible    
    total_possible = zeros(36,4);
    tp_iter = 0;
    for i = 1:6
        for j = 1:6
            tp_iter = tp_iter + 1;
            total_possible(tp_iter,1:2) = A(i,1:2);
            total_possible(tp_iter,3:4) = B(j,1:2);
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
            guess(1,1:2) = A(cur_guess_index_A,1:2);
            guess(1,3:4) = B(cur_guess_index_B,1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;

        %The following steps determine which guess to make next.
        %This is the basic process:
        %-------------------------
        %1 - Determine type
        %2 - Inverse, Keep, or Use Next for both A and B
        %3 - Generate guess
        %4 - Store guess as previous guess
        %5 - Add used indexes to used indexes array


        %Inverses both guesses
        elseif WW == 1
            fprintf('Inverses both A and B values: \n')
            for i = 1:length(A)
                if previous_guess(1,1:2) ~= A(i)
                    cur_guess_index_A = i;
                end
            end
            for i = 1:length(B)
                if previous_guess(1,3:4) ~= B(i)
                    cur_guess_index_B = i;
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B,1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;


        %Keeps A, uses B next
        elseif (RP_PR == 1) || (WR_RW_PP == 1) || (PP == 1) || (RP == 1)
            fprintf('Keeps A value, uses next B value: \n');
            cur_guess_index_B = cur_guess_index_B + 1;
            if cur_guess_index_B == 7
                cur_guess_index_B = 1;
            end
            for i = 1:length(used_guess_index_B)
                if cur_guess_index_B == used_guess_index_B(i)
                    cur_guess_index_B = cur_guess_index_B + 1;
                    i = 1;
                    if cur_guess_index_B == 7
                       cur_guess_index_B = 1;
                    end
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;

        %Uses A next, keeps B
        elseif PR == 1
            fprintf('Use next A value, keeps B value: \n');
            cur_guess_index_A = cur_guess_index_A + 1;
            if cur_guess_index_A == 7
                cur_guess_index_A = 1;
            end
            for i = 1:length(used_guess_index_A)
                if cur_guess_index_A == used_guess_index_A(i)
                    cur_guess_index_A = cur_guess_index_A + 1;
                    i = 1;
                    if cur_guess_index_A == 7
                       cur_guess_index_A = 1;
                    end
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;

        %Keeps A, inverses B    
        elseif (RW_PP == 1) || (RW == 1) || (PW == 1) || (RW_WR == 1)
            fprintf('Keeps A value, inverses B value: \n');
            for i = 1:length(B)
                if ((previous_guess(1,3) ~= B(i,1)) && (previous_guess(1,4) ~= B(i,2))) && ((previous_guess(1,3) ~= B(i,2)) && (previous_guess(1,4) ~= B(i,1)))
                    cur_guess_index_B = i;
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2);
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;

        %Inverses A, keeps B
        elseif (WR_PP == 1) || (WR == 1) || (WP == 1) || (WP_PW == 1)
            fprintf('Inverses A value, keeps B value: \n');
            for i = 1:length(A)
                if ((previous_guess(1,3) ~= A(i,1)) && (previous_guess(1,4) ~= A(i,2))) && ((previous_guess(1,3) ~= A(i,2)) && (previous_guess(1,4) ~= A(i,1)))
                    cur_guess_index_A = i;
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3:4) = B(cur_guess_index_B, 1:2); 
            previous_guess = guess;
            used_guess_indexes_A(guess_count-2) = cur_guess_index_A;
            used_guess_indexes_B(guess_count-2) = cur_guess_index_B;

        end

        %If the same A value is present in all the total_possibles, keep
        %that A value
        repitions_A = 0;
        for i = size(total_possible,1)
            if total_possible(1,3:4) == total_possible(i,3:4)
                repitions_A = 1;
            end
        end
        if repitions_A == 1
            guess(1,3:4) = total_possible(1,3:4);
        end
        
        %If the same B value is present in all the total_possibles, keep
        %that B value
        repitions_B = 0;
        for i = size(total_possible,1)
            if total_possible(1,3:4) == total_possible(i,3:4)
                repitions_B = 1;
            end
        end
        if repitions_B == 1
            guess(1,3:4) = total_possible(1,3:4);
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
        PW = 0;
        WP = 0;
        RP = 0;
        PR = 0;
        RR = 0;
        WW = 0;
        PP = 0;
        RW_WR = 0;
        WP_PW = 0;
        RP_PR = 0;
        RW_PP = 0;
        WR_PP = 0;
        WR_RW_PP = 0;
        
        %R,W,P evaluation
        for i = 1:size(total_possible,1)
            if ((guess(1) == total_possible(i,1)) && (guess(2) == total_possible(i,2))) || ((guess(1) == total_possible(i,2)) && (guess(2) == total_possible(i,1)))
                type_possible(i,1)='R';
            elseif (guess(1) ~= total_possible(i,1) && guess(2) ~= total_possible(i,2)) && (guess(2) ~= total_possible(i,1) && guess(1) ~= total_possible(i,2))
                type_possible(i,1)='W';
            else
                type_possible(i,1)='P';
            end
            if ((guess(3) == total_possible(i,3)) && (guess(4) == total_possible(i,4))) || ((guess(3) == total_possible(i,4)) && (guess(4) == total_possible(i,3)))
                type_possible(i,2)='R';
            elseif (guess(3) ~= total_possible(i,3) && guess(4) ~= total_possible(i,4)) && (guess(4) ~= total_possible(i,3) && guess(3) ~= total_possible(i,4))
                type_possible(i,2)='W';
            else
                type_possible(i,2)='P';
            end
        end

        %Combination evaluations
        for i = 1:size(type_possible,1)
            if strcmp(type_possible(i,1:2),'RW')
                RW = 1;
            elseif strcmp(type_possible(i,1:2),'WR')
                WR = 1;
            elseif strcmp(type_possible(i,1:2),'PW')
                PW = 1;
            elseif strcmp(type_possible(i,1:2),'WP')
                WP = 1;
            elseif strcmp(type_possible(i,1:2),'RP')
                RP = 1;
            elseif strcmp(type_possible(i,1:2),'PR')
                PR = 1;
            elseif strcmp(type_possible(i,1:2),'RR')
                RR = 1;
            elseif strcmp(type_possible(i,1:2),'PP')
                PP = 1;
            elseif strcmp(type_possible(i,1:2),'WW')
                WW = 1;
            end
        end

        %Combinations of combinations evaluations
        if RW && WR == 1
            RW_WR = 1;
        end
        if WP && PW == 1
            WP_PW = 1;
        end
        if RP && PR == 1
            RP_PR = 1;
        end
        if RW && PP == 1
            RW_PP = 1;
        end
        if WR && PP == 1
            WR_PP = 1;
        end
        if WR && RW && PP == 1
            WR_RW_PP = 1;
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

        %disp(possible);

        %disp(total_possible);

        %for i = 1:36
            %x_eval(guess,total_possible(i));
    
        
