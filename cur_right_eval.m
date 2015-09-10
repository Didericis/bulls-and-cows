% Part I compare "real" with "guess" and return the total bulls and cows in
% term of cur_right
function[]=cur_right_eval(guess_param,real_param)
    global cur_right
    cur_right = 0;
    for j = 1:4
        for i = 1:4
            if guess_param(j) == real_param(i)
                cur_right = cur_right + 1;
            end
        end
    end
end