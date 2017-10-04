function [ pyr ] = genPyr( img,typ,J )
%GENPYR Summary of this function goes here
%   Detailed explanation goes here
P = cell(1,J); % image pyramid : p{1}= Original image
D = cell(1,J); % Differnace Pyramid
h =[];
img = rgb2gray(img);
[xx yy] = size(img)

%-------------  

%----- check required filter

if (strcmp(typ,'lap'))
filter = fspecial('laplacian');
elseif (strcmp(typ,'gauss'))
filter = fspecial('gaussian');
end
P{1} = img;
figure
h(1) = subplot(2,J,1)
imshow(P{1});
title('Original Image');
% -------- Loop to generate J level pyramid
for j=2:J
%---- Gaussian low pass filter and / Downsampling by 2
%temp =temp(1:2:x,1:2:y);
temp = imfilter(P{j-1},filter);
P{j} = imresize(temp,0.5);
[x y] =size(P{j})
%---- Upsampling * 2 and / interpolation with bilinear filter
k=imresize(P{j},2,'bilinear');
%k = zeros(2*x,2*y);
%k(1:2:2*x,1:2:2*y)=temp(:,:);

h(j) = subplot(2,J,j);
imshow(P{j});
title('DownSampled By 2 ');
%imshow(k);
%title('Upsampled By 2 / interpolation');
%filter = intfilt(2,1,0.5);
%k = imfilter(k,filter);
%figure
%imshow(k)
%title('Interpolated by intfilt');
D{j-1} = (P{j-1}-k);
h(j+(J-1)) =subplot(2,J,j+(J-1));
imshow(5*D{j-1});
title('Error "Original-Predicted');
end
h
D{J} = P{J};
h(J*2)=subplot(2,J,2*J);
imshow(D{J});
title('Pyramid(J)');
linkaxes(h)

figure
subplot(1,2,1);
imshow(P{1})
title('Original Image');

k=imresize(P{2},2,'bilinear');
subplot(1,2,2);
imshow(k-D{1})
title('restored Image');


 pyr = P ;   
 diff = D;
 
 save  pyr;
 
   
end