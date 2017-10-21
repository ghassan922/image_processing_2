%wavelet based compression sub-band coding
clear all;
% CLOSE ALL  closes all the open figure windows.
close all;
X=imread('cameraman.tif');
X=X(1:256,1:256);
figure;
%load woman;
%subplot(2,1,1);
imshow(uint8(X));

[a1,a2]=size(X);
disp('The number of rows in input image are'); 
disp(a1);
disp('The number of coloums in input image are'); 
disp(a2);
figure;
title('Input image');
% Perform single-level decomposition 
% of X using haar. 
[cA1,cH1,cV1,cD1] = dwt2(X,'haar');
% Images coding. 
[C,S] = wavedec2(X,1,'haar');
A1 = wrcoef2('a',C,S,'haar',1);
H1 = wrcoef2('h',C,S,'haar',1); 
V1 = wrcoef2('v',C,S,'haar',1); 
D1 = wrcoef2('d',C,S,'haar',1); 
%Display the results of a first level decomposition.
colormap(gray);
subplot(2,2,1); image(wcodemat(A1,192));
title('Approximation A1')
subplot(2,2,2); image(wcodemat(H1,192));
title('Horizontal Detail H1')
subplot(2,2,3); image(wcodemat(V1,192));
title('Vertical Detail V1')
subplot(2,2,4); image(wcodemat(D1,192));
title('Diagonal Detail D1')
%disp(cod_cA1);

%Multi-level 1-D wavelet reconstruction.
re_ima1 = idwt2(cA1,cH1,cV1,cD1,'haar'); 
re_ima=uint8(re_ima1);
figure;
subplot(2,1,1);
imshow(uint8(X));
title('Input image');
subplot(2,1,2);
imshow(re_ima);
title('1-level reconstructed image');
figure;


%To perform a level 2 decomposition of the image
%X using haar
[C,S] = wavedec2(X,2,'haar');
% decomposse the image X in Level 2  
%image coding
A2 = wrcoef2('a',C,S,'haar',2);
A1 = wrcoef2('a',C,S,'haar',1);
H1 = wrcoef2('h',C,S,'haar',1); 
V1 = wrcoef2('v',C,S,'haar',1); 
D1 = wrcoef2('d',C,S,'haar',1); 
H2 = wrcoef2('h',C,S,'haar',2);
V2 = wrcoef2('v',C,S,'haar',2); 
D2 = wrcoef2('d',C,S,'haar',2);
colormap(gray);
subplot(2,4,1);image(wcodemat(A1,192));
title('Approximation A1')
subplot(2,4,2);image(wcodemat(H1,192));
title('Horizontal Detail H1')
subplot(2,4,3);image(wcodemat(V1,192));
title('Vertical Detail V1')
subplot(2,4,4);image(wcodemat(D1,192));
title('Diagonal Detail D1')
subplot(2,4,5);image(wcodemat(A2,192));
title('Approximation A2')
subplot(2,4,6);image(wcodemat(H2,192));
title('Horizontal Detail H2')
subplot(2,4,7);image(wcodemat(V2,192));
title('Vertical Detail V2')
subplot(2,4,8);image(wcodemat(D2,192));
title('Diagonal Detail D2')
dec2d = [A2,A1,H1,V1,D1,H2,V2,D2];

%Multi-level 2-D wavelet reconstruction.
re_ima1 = waverec2(C,S,'haar'); 
re_ima=uint8(re_ima1);
figure;
subplot(2,1,1);
imshow(uint8(X));
title('Input image');
subplot(2,1,2);
imshow(re_ima);
title('2-level reconstructed image');
%figure;
%y=imsubtract(uint8(X),re_ima);
%imshow(y);title('error image');


% Using some plotting commands,
% the following figure is generated.
n=input('enter the decomposition level');
X=imread('cameraman.tif');
X=X(1:256,1:256);
X=double(X)-128;
%To compute four filters associated 
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters('haar');
%Multilevel 2-D wavelet decomposition.
[c,s]=wavedec2(uint8(X),n,Lo_D,Hi_D);
disp('Decomposition vector of size 1*524288 is stored in c');
disp('Coressponding book keeeping matrix');
disp(s);
[thr,nkeep] = wdcbm2(uint8(dec2d),1.5,prod(s(1,:)));
%Default values for de-noising or compression.
[THR,SORH,KEEPAPP,CRIT] = DDENCMP('cmp','wp',uint8(X));
%De-noising or compression using wavelet packets.
[XC,TREED,PERF0,PERFL2] =WPDENCMP(X,SORH,2,'haar',CRIT,THR,KEEPAPP);
disp('Level-dependent thresholds'); 
disp(THR);
disp('The entropy used is');
disp(CRIT);
disp('The type of thersholding is');
if SORH==s
    disp('Soft Thresholding');
       
else
    disp('Hard Thresholding');
end
disp('Approximation coefficients are');
disp(KEEPAPP);
disp('Wavelet packet best tree decomposition of XD');
disp(TREED);
disp('The L^2 recovery');
disp(PERFL2);
disp('The compression scores in percentages');
disp(PERF0);
XC=double(X)+128;
figure;
%subplot(2,1,1);
%imshow(uint8(X));
%title('Original Image');
%subplot(2,1,2);
imshow(uint8(XC));
title('Output image');
[b1,b2]=size(XC);
disp('The number of rows in compressed image are'); 
disp(b1);
disp('The number of coloums in image are'); 
disp(b2);
%figure;
%y=imsubtract(uint8(X),uint8(XC));
%imshow(y);title('error image');

%INFO = IMFINFO(X,bmp);
%INFO1 = IMFINFO(XC,bmp);