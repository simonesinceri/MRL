% codice appoggio TicTacToe

% CASO prima azione mia
%     if((numCroce == numCerchio && numVuote >=1 && numSeqEnd<2)||(numCroce == numCerchio+1 && numSeqEnd<2) ) % stato ammissibile
%          list = horzcat(list, s);
%     end
    
    
%     if(numCerchio < numCroce) % stato non ammissibile
%         for k=1:1%A
%             P(s,:,k)=zeros(1,S);
%             P(:,s,k)=zeros(1,S);   
%         end
%     end
        
%         continue
%     end
%     
%     for a = 1:1%A
%         %calcolare possibili stati successivi->prob in matrice
%         % metto la x in 1 e poi pro
%         % devo vedere le caselle vuote e se è possibile mettere la x in 1
%         if(state(a) ~= 1)% controllo se azione a è possibile
%             P(s,:,a) = zeros(1,S);
%         else
%             % stato aggiornato dopo mia azione
%             state(a) = 2;
%             %possibili stati successivi
%             for t=1:9
%                 if(state(t)==1) % se casella vuota
%                     %aggiorno direttamente matrice P
%                     stateApp = state; 
%                     stateApp(t) = 3;
%                     sp = sub2ind(3*ones(1,9),stateApp(1),stateApp(2),stateApp(3),stateApp(4),...
%                         stateApp(5),stateApp(6),stateApp(7),stateApp(8),stateApp(9));
%                     %aggiorno probabilità
%                     P(s,sp,a) = 1/numVuote-1; %% come setto la prob?
%                 end
%             end
%             
%         end
%     end