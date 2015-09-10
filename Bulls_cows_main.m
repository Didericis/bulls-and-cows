random_numbers = load('randomDigits.txt');

%Imports global variables
global cur_right
global guess_count

num_guesses = zeros(length(random_numbers),1);

for i = 1:length(random_numbers)
 
    clear guesses
    
    %Stores current real value in variable 'real'
    real = random_numbers(i,1:4);
    
    A = [1,2,3,4];
    B = [5,6,7,8];
    init_guesses = [A;B];
    
    %Guess 1
    fprintf('----Guess 1----\n');
    fprintf('(default)\n');
    fprintf('Current Guess:');
    disp(A);
    
    cur_right_eval(A,real);
    answer(1,1) = cur_right;
    fprintf('%d number(s) are correct\n\n', cur_right);
    
    %Guess 2
    fprintf('----Guess 2----\n');
    fprintf('(default)\n');
    fprintf('Current Guess:');
    disp(B);
    
    cur_right_eval(B,real);
    answer(2,1) = cur_right;
    fprintf('%d number(s) are correct\n\n', cur_right);
    
    guess_count = 2;
    
    guesses = [];
    
    %Determines which type of evaluation to use
    if (answer(1,1) == 1) && (answer(2,1) == 1)
        guesses=Bulls_cows_1v1(init_guesses,real);
    elseif (answer(1,1) == 1) && (answer(2,1) == 2)
        guesses=Bulls_cows_2v1(2,init_guesses,real);
    elseif (answer(1,1) == 2) && (answer(2,1) == 1)
        guesses=Bulls_cows_2v1(1,init_guesses,real);
    elseif (answer(1,1) == 0) && (answer(2,1) == 2)
        guesses=bulls_cows_0v2(2,init_guesses,real);
    elseif (answer(1,1) == 2) && (answer(2,1) == 0)
        guesses=bulls_cows_0v2(1,init_guesses,real);
    elseif (answer(1,1) == 3) && (answer(2,1) == 1)
        guesses=bulls_cows_3v1(1,init_guesses,real);
    elseif (answer(1,1) == 1) && (answer(2,1) == 3)
        guesses=bulls_cows_3v1(2,init_guesses,real);
    elseif (answer(1,1) == 3) && (answer(2,1) == 0)
        guesses=bulls_cows_3v0(1,init_guesses,real);
    elseif (answer(1,1) == 0) && (answer(2,1) == 3)
        guesses=bulls_cows_3v0(2,init_guesses,real);
    elseif (answer(1,1) == 2) && (answer(2,1) == 2)
        guesses=Bulls_cows_2v2(init_guesses,real);
    
    end
    final_guesses=final_eval(guesses,real);
    last_guesses(i,1:4)=final_guesses(guess_count,1:4);
    num_guesses(i,1) = guess_count;
end

%Displays results
fprintf('--------------Results Sumary----------------\n');
for i = 1:length(last_guesses)
    last_guess_digits = last_guesses(i, 1:4);
    fprintf('Answer %d: %d %d %d %d  | Guesses Neeeded: %d \n',i, last_guess_digits, num_guesses(i));
end

%----Standard Deviation & averages initializations
n=size(num_guesses,1);
psum1_num_guesses = 0;
psum2_num_guesses = 0;

for i = 1:n
    psum1_num_guesses = psum1_num_guesses + num_guesses(i);
    psum2_num_guesses = psum2_num_guesses + (num_guesses(i)).^2;
end

x_bar = psum1_num_guesses/n;
std_dev = sqrt((n*psum2_num_guesses - psum1_num_guesses.^2)/(n * (n-1)));

fprintf('\nX Bar: %f\n',x_bar);
fprintf('Standard Deviation: %f\n',std_dev);
