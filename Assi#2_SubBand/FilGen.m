function [out] = FilGen(g0)

% first we need to generate filters g1[], h0[], h1[]
g1=[];h0=[];h1=[];

k = size(g0,2); % get the K-even
    % building g1[n],h0[n] from g0[n]
    for n=1:k
        %k+1 as it starts from 1
       g1(n) = ((-1).^(n+1))*g0(k+1-n);%n+1 because n starts from 1 not 0 
       h0(n) = g0(k+1-n);
    end
    % building H1[n] from G1[n]
    for n=1:k
        %k+1 as it starts from 1
       h1(n) = g1(k+1-n);
    end
    % stem filters
    figure;
    subplot(2,2,1);
    stem(h0);
    title('H0[n]');
    subplot(2,2,2);
    stem(h1);
    title('H1[n]');
    subplot(2,2,3);
    stem(g0);
    title('G0[n]');
    subplot(2,2,4);
    stem(g1);
    title('G1[n]');
    
   
    out = cell(1,4);
    out{1} = h0;out{2} = h1;out{3} = g0;out{4} = g1;
end
