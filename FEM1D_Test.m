% FEM to solve 1D elliptic problem:
%   -d/dx(p(x)du/dx) + q(x)u = f(x), 0<x<1
%   Direclet BC: u(0) = u(1) = 0 
% where p = q = 1, f(x)=x
% exact solution: u(x) = x -sinh(x)/sinh(1)
% 
%%%%%%        
% Created by D. Nguyen Kien (or Dave D.K. Nguyen)
% Tongji University, Shanghai, China.
% email: nkdung@hotmail.com
%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
tic


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDE elliptic equation configuration.
p = 1; q = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Meshing
L = 1; m = 6;

[node, element] = mesh1D(L,m);
nNode = size(node,1);   % = m
nElem = size(element,1); % = m-1
dof = 1;
ndof = nNode;

% dL = h
dL = abs(node(2,1)- node(1,1)); % might not need "abs"

% Continue PDE configuation.
f = zeros(m,1);
for j = 1: m
    f(j) = dL * (j-1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Kx = zeros(nNode, nNode);
Mx = zeros(nNode, nNode);
Fx = zeros(nNode,1);


for e = 1: nElem
   sctr = element(e,:) ;
   kj = p/dL * [1 -1; -1 1];
   mj = q*dL/6 * [2 1; 1 2];
   lj = dL/6 * [2*f(sctr(1)) + f(sctr(2)); f(sctr(1)) + 2*f(sctr(2))];
   
   Kx(sctr, sctr) = Kx(sctr, sctr) + kj ;
   Mx(sctr, sctr) = Mx(sctr, sctr) + mj ;
   Fx(sctr) = Fx(sctr) + lj;
end


%===boundary condition===%
bcdof = [1 nNode] ;

%===Displacement calculation===%
ux = dispBCCalculation( (Kx+Mx), Fx, bcdof, ndof ) ;

figure
plot(node, ux, 'r-', node, node-sinh(node)/sinh(1), 'b-')
% plot(node, node-sinh(node)/sinh(1), 'b-')
