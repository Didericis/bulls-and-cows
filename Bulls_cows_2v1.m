%Guesses scenario 2v1 or 1v2
function[guesses] = Bulls_cows_2v1(scenario,guesses_param,real_param)
    
    %Defines global variables
    global guess_count
    global cur_right
    
    %Defines Real
    real = real_param;
    
    %Misc variable declarations
    used_guess_index_A = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    used_guess_index_B = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

    %Defines possibles (components for total_possible)
    if scenario == 1
        A = [1, 2; 1, 3; 1, 4; 2, 3; 2, 4; 3, 4];
        B = [5;6;7;8];
        C = [9;0];
    elseif scenario == 2
        A = [5, 6; 5, 7; 5, 8; 6, 7; 6, 8; 7, 8];
        B = [1;2;3;4];
        C = [9;0];
    end

    %Defines total possible
    tp_iter = 0;
    for i = 1:6
        for j = 1:4
            for k = 1:2
                tp_iter = tp_iter + 1;
                total_possible(tp_iter,1:2) = A(i,1:2);
                total_possible(tp_iter,3) = B(j,1);
                total_possible(tp_iter,4) = C(k,1);
            end
        end
    end

    %Loop for making and evaluating guesses
    while cur_right ~= 4

        %Adds one to the guess count for each pass, displays guess number
        guess_count = guess_count + 1;
        fprintf('----Guess %d----\n', guess_count);

        %On third guess, do the following:
        if guess_count == 3
            fprintf('(default this type)\n');
            guess = zeros(1,4);
            cur_guess_index_A = 1;
            cur_guess_index_B = 1;
            cur_guess_index_C = 1;
            guess(1,1:2) = A(cur_guess_index_A,1:2);
            guess(1,3) = B(cur_guess_index_B,1);
            guess(1,4) = C(cur_guess_index_C,1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;
            used_guess_index_C(guess_count-2) = cur_guess_index_C;

        %On fourth guess, Keeps A, uses B next
        elseif guess_count == 4
            fprintf('Keeps A value, Keeps B value, uses next C value: \n');
            cur_guess_index_C = cur_guess_index_C + 1;
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;
            
        %On fifth guess, do the following:
        if guess_count == 5
            if answer(3) > answer(4)
                cur_guess_index_C = 1;
            else
                cur_guess_index_C = 2;
            end
        end
        
        %The following steps determine which guess to make next.
        %This is the basic process:
        %-------------------------
        %1 - Determine type
        %2 - Inverse, Keep, or Use Next for both A and B
        %3 - Generate guess
        %4 - Store guess as previous guess
        %5 - Add used indexes to used indexes array

        %Uses A next, keeps B and correct C
        elseif RW == 1
            fprintf('Keeps A, uses next B, uses correct C value \n');
            if cur_guess_index_B ~=4
                cur_guess_index_B = cur_guess_index_B + 1;
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Uses inverse A, B next and correct C
        elseif WW == 1
            fprintf('Use inverse A, next B and correct C value: \n');
            for i = 1:size(A,1)
                if isequal(previous_guess(1,1:2),A(i,1:2)) ~= 1
                    cur_guess_index_A = i;
                end
            end
            if cur_guess_index_B ~=4
                cur_guess_index_B = cur_guess_index_B + 1;
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Use next A, next B, and C correct
        elseif PW == 1
            fprintf('Use next A, next B and correct C: \n');
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
            if cur_guess_index_B ~=4
                cur_guess_index_B = cur_guess_index_B + 1;
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Use next A, keep B, use C correct
        elseif PR == 1
            fprintf('Use next A, next B and correct C: \n');
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
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;

        %Uses inverse A, keep B, uses C correct    
        elseif WR == 1
            fprintf('Use inverse A, keeps B, and correct C value: \n');
            for i = 1:size(A,1)
                if isequal(previous_guess(1,1:2),A(i,1:2)) ~= 1
                    cur_guess_index_A = i;
                end
            end
            guess(1,1:2) = A(cur_guess_index_A, 1:2);
            guess(1,3) = B(cur_guess_index_B, 1);
            guess(1,4) = C(cur_guess_index_C, 1);
            previous_guess = guess;
            used_guess_index_A(guess_count-2) = cur_guess_index_A;
            used_guess_index_B(guess_count-2) = cur_guess_index_B;
        end


        %If there is only one possible guess, uses it
        if size(total_possible,1) == 1
            guess = total_possible(1,1:4);
        end

        %Compares the guess with the real answer, returns cur_right and
        %stores cur_right as wanted right. Each guess's cur_right 
        %evaluation is then stored in array "answer"
        cur_right_eval(real,guess);
        wanted_right = cur_right;
        answer(guess_count,1) = cur_right;


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
        
        
        %Initializes RW, WR and WW
        RW = 0;
        PW = 0;
        WR = 0;
        WW = 0;
        RR = 0;
        PR = 0;

        C_R = 0;
        C_W = 0;

        %R,W,P evaluation
        for i = 1:size(total_possible,1)
            if isequal(guess(1:2),total_possible(i,(1:2)))
                type_possible(i,1)='R';
            elseif (guess(1) ~= total_possible(i,1) && guess(2) ~= total_possible(i,2)) && (guess(2) ~= total_possible(i,1) && guess(1) ~= total_possible(i,2))
                type_possible(i,1)='W';
            else
                type_possible(i,1)='P';
            end
            if isequal(guess(3),total_possible(i,3))
                type_possible(i,2)='R';
            else
                type_possible(i,2)='W';
            end
        end
        
        %Combination evaluations
        for i = 1:size(type_possible,1)
            if strcmp(type_possible(i,1:2),'RW')
                RW = 1;
            elseif strcmp(type_possible(i,1:2),'PW')
                PW = 1;
            elseif strcmp(type_possible(i,1:2),'WR')
                WR = 1;
            elseif strcmp(type_possible(i,1:2),'WW')
                WW = 1;
            elseif strcmp(type_possible(i,1:2),'RR')
                RR = 1;
            elseif strcmp(type_possible(i,1:2),'PR')
                PR = 1;
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