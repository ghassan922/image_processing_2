function  subband(img,g0)
% 
% % first we need to generate filters g1[], h0[], h1[]
% g1=[];h0=[];h1=[];
% 
% k = size(g0,2); % get the K-even
%     % building g1[n],h0[n] from g0[n]
%     for n=1:k
%         %k+1 as it starts from 1
%        g1(n) = ((-1).^(n+1))*g0(k+1-n);%n+1 because n starts from 1 not 0 
%        h0(n) = g0(k+1-n);
%     end
%     % building H1[n] from G1[n]
%     for n=1:k
%         %k+1 as it starts from 1
%        h1(n) = g1(k+1-n);
%     end
%     % stem filters
%     figure;
%     subplot(2,2,1);
%     stem(h0);
%     title('H0[n]');
%     subplot(2,2,2);
%     stem(h1);
%     title('H1[n]');
%     subplot(2,2,3);
%     stem(g0);
%     title('G0[n]');
%     subplot(2,2,4);
%     stem(g1);
%     title('G1[n]');
%     
%     out = cell(1,4);
%     out{1} = h0;out{2} = h1;out{3} = g0;out{4} = g1;
%h = [0.23037781 0.71484657 0.63088076 -0.02798376 -0.18703481 0.03084138 0.03288301 -0.01059740]
figure
imshow(img);
title('Original Image');

h = FilGen(g0);
h0=h{1};h1=h{2};g0=h{3};g1=h{4};
[x y z] = size(img);
temp =[] ;

    %%% Approximation a(h0,h0)
    for m=1:x
        temp(m,:,:)=imfilter(img(m,:,:),h0);
       % temp(m,:)= imfilter(double(img(m,:)),double(h0));
       
    end
    [c r w] = size(temp);
    temp = imresize(temp,[c/2 r]);
    temp1=temp;
%     figure 
%     imshow(uint8(temp));
%     title('after rows downsampling and h0 filter');
    for n=1:r
        temp(:,n,:)=imfilter(temp(:,n,:),h0');
        %temp(:,n) = imfilter(double(temp(:,n)),double(h1));
        
    end
    [c r w] = size(temp)
        temp = imresize(temp,[c r/2]);
figure
imshow(uint8(temp));
title('a(h0,h0): approximation');

    temp=[];


    %%%  a(h0,h1)
%     
%  for m=1:x
%         temp(m,:,:)=imfilter(double(img(m,:,:)),double(h0));
%        % temp(m,:)= imfilter(double(img(m,:)),double(h0));
%        
%     end
%     [c r w] = size(temp);
%     temp = imresize(temp,[c/2 r]);
%     figure 
%     imshow(uint8(temp));
%     title('after rows downsampling and h0 filter');
    for n=1:r
        temp(:,n,:)=imfilter(temp1(:,n,:),h1');
        %temp(:,n) = imfilter(double(temp(:,n)),double(h1));
        
    end
    [c r w] = size(temp)
        temp = imresize(temp,[c r/2]);
figure
imshow(uint8(10*temp));
title('a(h0,h1) : V-band');

temp =[] ;

    %%%  a(h1,h0)
    for m=1:x
        temp(m,:,:)=imfilter(img(m,:,:),h1);
       % temp(m,:)= imfilter(double(img(m,:)),double(h0));
       
    end
    [c r w] = size(temp);
    temp = imresize(temp,[c/2 r]);
    temp1=temp;
    figure 
    imshow(uint8(10*temp));
    title('after rows downsampling and h1 filter');
    for n=1:r
        temp(:,n,:)=imfilter(temp(:,n,:),h0');
        %temp(:,n) = imfilter(double(temp(:,n)),double(h1));
        
    end
    [c r w] = size(temp)
        temp = imresize(temp,[c r/2]);
figure
imshow(uint8(10*temp));
title('a(h1,h0) : H-band');
    temp=[];

    %%%  a(h1,h0)
    for n=1:r
        temp(:,n,:)=imfilter(temp1(:,n,:),h1');
        %temp(:,n) = imfilter(double(temp(:,n)),double(h1));
        
    end
    [c r w] = size(temp)
        temp = imresize(temp,[c r/2]);
figure
imshow(uint8(20*temp));
title('a(h1,h1) : Diagonal band');
    temp=[];

%     [x y z] = size(temp);
%     temp = imresize(temp,[x y/2]);
%     
%     figure
%     imshow(temp);
%     [x y z] = size(temp)
%     h0
end






















