l = load('pyr.mat');

d = l.diff ;
J = size(d,2);
temp=d{J};
figure
imshow(temp)
title('first');
for j=J:-1:2
temp = imresize(temp,2,'bilinear');
temp = temp+d{j-1};
end
figure
imshow(temp);
title('restored');