% Compares 4 digits with 4 other digits and returns the total bulls as
% "Bulls"
function[]=Bulls_eval(guess_param,real_param)
    global Bulls
    Bulls = 0;
    for i = 1:4
        if guess_param(i) == real_param(i);
            Bulls = Bulls + 1;
        end
    end
end