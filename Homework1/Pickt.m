function [M] = Pick_index(m)

for i = 1:100

    s = round(rand(1,m));
    su = sum(s);

        if su == m/2
         M = s';
        end
end