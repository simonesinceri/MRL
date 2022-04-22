%% Demo Visualizzazione Grafica

%load mc_race_10e6_GAMMA1.mat % qst con che eps fai con 01 03 05
%load mc_race_10e6_GAMMA1_eps02.mat


GW = createGridWorld(20,20,'Kings');
GW.ObstacleStates = ["[20,5]";"[20,16]";"[5,5]";"[6,5]";"[7,5]";"[8,5]";"[9,5]";...
    "[10,5]";"[11,5]";"[12,5]";"[13,5]";"[14,5]";"[15,5]";"[16,5]";"[17,5]";"[18,5]";"[19,5]";...
    "[11,16]";"[11,17]";"[11,18]";"[11,19]";"[11,20]";...
   "[12,16]";"[13,16]";"[14,16]";"[15,16]";"[16,16]";"[17,16]";"[18,16]";"[19,16]";"[20,16]";...
   "[5,6]";"[5,7]";"[5,8]";"[5,9]";"[5,10]";"[5,11]";"[5,12]";"[5,13]";"[5,14]";"[5,15]";"[5,16]";...
   "[5,17]";"[5,18]";"[5,19]";"[5,20]";];
GW.TerminalStates = ["[6,20]";"[7,20]";"[8,20]";"[9,20]";"[10,20]"];
env = rlMDPEnv(GW);
plot(env)
s0 = sub2ind([20 20 11 11],20,randi([6 15]),6,6); 
[s, a, r] = playRaceEpsilon(s0, policy, 0);

par1="[";
virg= ",";
par2 = "]";


for i=1:length(s)
   
    if(s(i) == -1)
        [x,y,x_p,y_p] = ind2sub([20 20 11 11],s(i-1));
        act = policy(s(i-1),:);
       
        x_p = x_p - 1 - 5;
        y_p = y_p - 1 - 5;
        
        if(act(1) == 2)
            x_p = x_p + 1;
        end
        if(act(1) == 3)
            x_p = x_p - 1;
        end
        
        if(act(2) == 2)
            y_p = y_p + 1;
        end
        if(act(2) == 3)
            y_p = y_p - 1;
        end
        
        x_p = min(max(x_p,-5),5);
        y_p = min(max(y_p,-5),5);
        
        x = max(min(x + x_p,20),1);
        y = max(min(y + y_p,20),1);
        
    else
        
        [x,y,x_p,y_p]= ind2sub([20 20 11 11],s(i));
        
    end
    
    xg = string(x);
    yg = string(y);
    
    GW.CurrentState = par1+xg+virg+yg+par2;
    plot(env)
    %pause
    pause(0.5)
end
