function [Edge, OneDEdge, BCnodes] =  elementBoundary(n,m)

% n = number of column
% m = number of row

row = m;
column = n;
for i = 1: column
    bottomNodes(i) = i;
    topNodes(i) = column*(row-1) +i;
end

for i = 1: row
    leftNodes(i) = (i-1)*column +1;
    rightNodes(i) = (i-1)*column + column;
                      % or = left1Delement(i) -1 + column;
end

for i = 1 : row -1
    rightEdge(i, 1) = rightNodes(i) - 1 ; 
    rightEdge(i, 2) = rightNodes(i)  ; 
    rightEdge(i, 3) = rightNodes(i+1) ; 
    rightEdge(i, 4) = rightNodes(i+1) -1 ; 
    
    right1Delement(i, 1) = rightNodes(i) ;
    right1Delement(i, 2) = rightNodes(i+1) ;
           
    leftEdge(i,1) = leftNodes(i);
    leftEdge(i,2) = leftNodes(i)+1;
    leftEdge(i,3) = leftNodes(i+1)+1;
    leftEdge(i,4) = leftNodes(i+1);
    
    left1Delement(i, 1) = leftNodes(i);
    left1Delement(i, 2) = leftNodes(i+1);      
end

for i = 1 : column -1
    bottomEdge(i, 1) = bottomNodes(i) ; 
    bottomEdge(i, 2) = bottomNodes(i) +1;  
    bottomEdge(i, 3) = bottomNodes(i+1) +column; 
    bottomEdge(i, 4) = bottomNodes(i) + column ;  

    bottom1Delement(i, 1) = bottomNodes(i) ;
    bottom1Delement(i, 2) = bottomNodes(i) +1 ;
        
    topEdge(i,1) = topNodes(i)-column;
    topEdge(i,2) = topNodes(i+1)-column;
    topEdge(i,3) = topNodes(i+1);
    topEdge(i,4) = topNodes(i);

    top1Delement(i, 1) = topNodes(i);
    top1Delement(i, 2) = topNodes(i+1);     
end

Edge = cell(4,1); % 1.bottom, 2.right, 3.top, 4.left
OneDEdge = cell(4,1);
BCnodes = cell(4,1); 


Edge{1,1} = bottomEdge;
Edge{2,1} = rightEdge;
Edge{3,1} = topEdge;
Edge{4,1} = leftEdge;

OneDEdge{1,1} = bottom1Delement;
OneDEdge{2,1} = right1Delement;
OneDEdge{3,1} = top1Delement;
OneDEdge{4,1} = left1Delement;

BCnodes{1,1} = bottomNodes;
BCnodes{2,1} = rightNodes;
BCnodes{3,1} = topNodes;
BCnodes{4,1} = leftNodes;

