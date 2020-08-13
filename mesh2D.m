function [node, element] = mesh2D(L, W, n, m)
%m: No of delta distant in x-dir
%n: No of delta distant in y-dir
%
%                      FORCE
%                        ||  
%                       \||/
% 1___2___3___4___5___6__\/_ _ _ _ _ _ _ _ _\ x
% |e1 |e2 |e3 |e4 |e5 |e6 |                 /
% |___|___|___|___|___|___|    W,m,dw,i
% |e7 |e8 |e9 |e10|e11|e12|
% |___|___|___|___|___|___|
% |                     
%\|/    L,n,dL,j
% y
%
% Example L=7, W=3
%
%====================================
% Create by D. Nguyen Kien (or Dave D.K. Nguyen)
% Civil Engineering, Tongji University
%====================================



NoN = m*n; %No of node
node = zeros(NoN,2);%(No of node, vertices of node )

NoE = (m-1) *(n-1); %No of element

dL = L/(n-1);  % ADDED
dW = W/ (m-1);  % ADDED





if m>1
    
    %%%=======NODE=======%%%
    for i = 0:m-1
        for j =0:n-1
       % i*base + j+1 = No. of node run along from 1 to NoN
            node(i*n+j+1,1) = dL * j; % vertix x of node
            node(i*n+j+1,2) = dW * i; % vertix y of node
        end
    end
    
    %%%=======ELEMENT=======%%%
    element = zeros(NoE,4);%No of element,
                                   %No of 4 nodes bound the element                                   
    e=1;  % No of Element
    for i = 1:m-1 % Run along each row
          k = (i-1)*n; % Renew No of the head of each row
          for j =1:n-1 % Run along each column
             element(e,1) = k+1;
             element(e,2) = k+2;
             element(e,3) = i*n + j+1;  %?? % OK, but should be j
             element(e,4) = i*n + j;  %?? % OK, but should be j+1
             e=e+1;
             k=k+1;
          end      
    end

elseif m==1
    
    %%%=======NODE=======%%%
    for i = 1:n
        node(i,1) = dL*(i-1);
        node(i,2) = 0;
    end
    
    
    %%%=======ELEMENT=======%%%
    element = zeros(NoE,2); %number of element
                                            % 2 nodes at each element
    e = 1;
    for i = 1: n-1
        element(e,1) = i;
        element(e,2) = i+1;
        e = e+1;
    end
                                        
end


