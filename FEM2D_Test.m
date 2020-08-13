% Second-order partial differential equation
% -d/dx(a11du/dx + a12du/dy) - d/dy(a21du/dx+a22du/dy)
%                              + a00u - f = 0
%  In this example, a12 = a21 = 0, a11 = a22 = -1
%  Direclet BC: u at boundary = 0. It means bottomBCnodes,rightBCnodes,topBCnodes,leftBCnodes -> constraint
%  Force f = 2pi^2*sin(pi*x)*sin(pi*y); 0<x,y<1
%
%
%
%%%%%%%%%%
% Created by D. Nguyen Kien (or Dave D.k. Nguyen)
% Tongji University, Shanghai, China.
% email: nkdung@hotmail.com
%%%%%%%%%%


clc
clear all
close all
tic


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equation Initialization
a00 = 0;
a11 = -1; 
a12 = 0; a21 = a12; % to let C be symmetric. 
a22 = -1;

C = [a11 a12 0; a21 a22 0; 0 0 a00];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nGauss = 4;
dof = 1;  % u at each node



% Mesh generation==========================
Lx = 1; Ly = 1; 
n_Xdir = 20; m_Ydir = 20 ;
[node,element] = mesh2D(Lx,Ly,n_Xdir,m_Ydir);
nNode = size(node,1);
nElem = size(element,1);
ndof = dof * nNode;



% force f = 2pi^2*sin(pi*x)*sin(pi*y)
f = zeros(nNode,1);
for i = 1: nNode
    f(i) = 2*pi^2*sin(pi*node(i,1))*sin(pi*node(i,2));
end

% plot nodes
figure
plot_mesh(node, element,'Q4','k-');

% Generate BC===============================
[Edge, OneDEdge, BCnodes] = elementBoundary(n_Xdir, m_Ydir);
bottomBCnodes = BCnodes{1,1};
rightBCnodes = BCnodes{2,1};
topBCnodes = BCnodes{3,1};
leftBCnodes = BCnodes{4,1};



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Kx = zeros(ndof, ndof) ; 
Fx = zeros(ndof, 1) ;


%===========K matrix calculation=============%
[W,Q] = quadrature(nGauss,'GAUSS',2);
for e = 1: nElem
    sctr = element(e,:) ; 
    nn = length(sctr) ;      
    
    for gp = 1: size(W,1)
        pt = Q(gp,:) ;  % quadrature points
        
        [N, dNdxi] = lagrange_basis2('Q4', pt) ;
        J = node(sctr,:)' * dNdxi ;  % [x; y] * [dNdxi, dNdeta]
        dNdx = dNdxi * inv(J);        

        B = zeros(3, dof*nn);
        
        B(1, 1: dof : dof*nn) = dNdx(:,1)' ;
        B(2, 1: dof : dof*nn) = dNdx(:,2)' ;
        B(3, 1: dof : dof*nn) = N' ;        
        
        Kx(sctr, sctr) = Kx(sctr, sctr) + B' * C * B * det(J) * W(gp) ; 
        Fx(sctr) = Fx(sctr) + N* N'*f(sctr) *det(J) * W(gp) ;
        
    end     
end


%===boundary condition===%
bcdof = [bottomBCnodes rightBCnodes topBCnodes leftBCnodes] ; % ???????????

%===Displacement calculation===%
Ux = dispBCCalculation( Kx, Fx, bcdof, ndof ) ;

figure
plot_field(node,element,'Q4',Ux);
colorbar

% x = node(:,1);
% y = node(:,2);
uExact = -sin(pi*node(:,1)) .* sin(pi*node(:,2));
figure
plot_field(node,element,'Q4',uExact)
colorbar

error_abs = abs(Ux-uExact);
error_table = [Ux uExact error_abs];

error_abs_max = max(error_abs);
