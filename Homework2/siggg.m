function [btm] = siggg(w1,w2,w3,w4,w5,w6,x1,x2)

btm1 = w5/(1 + exp(-x1*w1-x2*w3));
btm2 = w6/(1 + exp(-x1*w2-x2*w4));
btm = btm1 + btm2;

end

rows = size(A,1)
	columns = size(A,2)
for i=1:rows-2
		for j=1:columns-2
			S1=sum(sum(Gx.*A(i:i+2,j:j+2)))
			S2=sum(sum(Gy.*A(i:i+2,j:j+2)))

			mag(i+1,j+1)=sqrt(S1.^2+S2.^2)
        end
end