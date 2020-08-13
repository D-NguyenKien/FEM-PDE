function dis = dispBCCalculation(KMat, FMat, bcdof, ndofs)

% global ndofs

n=1:ndofs;
activeDof = setdiff(n,bcdof);
sad = size(activeDof, 2);  % size of activedof

Kmat = sparse(sad, sad);
Fmat = zeros(sad,1);

Kmat = KMat(activeDof, activeDof);
Fmat  = FMat(activeDof);

disBC = Kmat\Fmat;     % carefully with disBC since it does not
                                   % contain displacement at constraint.

dis2 = zeros(ndofs,2);
dis2(:,1) = 1:ndofs;   % dis2(:,1): position, dis2(:,2) value of dis
% count = 1;
icount = 1;
for i = 1: ndofs
    if i ==activeDof(icount)
        dis2(i,2) = disBC(icount);
%         count = count+1;
        icount = icount +1;
        if icount == (sad+1)
            icount = sad;
        end
    end
end

dis = dis2(:,2);