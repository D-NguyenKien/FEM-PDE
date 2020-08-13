function [node, element] = mesh1D(L, m)

%equal interval space

% 1___2___3___4___5___6   --> node
%  [1] [2] [3] [4] [5]    --> element

dL = L/(m-1);
node = zeros(m,1);
element = zeros(m-1,2);

for i = 1:m
   node(i,1) = dL*(i-1); 
end

for i = 1:m-1
   element(i,1) = i;
   element(i,2) = i+1;
end