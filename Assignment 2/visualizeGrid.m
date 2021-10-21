function visualizeGrid(state)

X = "X";
O = "O";

for i=1:1:3
    if(state(i)== 1)
        fprintf(" ")
    elseif(state(i)== 2)
        fprintf(X)
    else
        fprintf(O)
    end
    
    if(i < 3)
        fprintf(" | ")
    end
end

fprintf("\n")
fprintf("---------- \n")

for k=4:1:6
   if(state(k)== 1)
        fprintf(" ")
    elseif(state(k)== 2)
        fprintf(X)
    else
        fprintf(O)
    end
    if(k < 6)
        fprintf(" | ")
    else
    end
end

fprintf("\n")
fprintf("---------- \n")

for f=7:1:9
    if(state(f)== 1)
        fprintf(" ")
    elseif(state(f)== 2)
        fprintf(X)
    else
        fprintf(O)
    end
    if(f < 9)
        fprintf(" | ")
    end
end

   fprintf("\n")
   
end


% DEMO
% 
% [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), list(1));
% stato = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9];
% visualizeGrid(stato)