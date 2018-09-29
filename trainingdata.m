list1 = dir('dataset_B_Eye_Images\openLeftEyes\*.jpg');
list2 = dir('dataset_B_Eye_Images\closedLeftEyes\*.jpg');
list3 = dir('dataset_B_Eye_Images\openRightEyes\*.jpg');
list4 = dir('dataset_B_Eye_Images\closedRightEyes\*.jpg');
%output
ooleft = zeros(size(list1,1),4);
ooleft(:,1) = 1;
ocleft = zeros(size(list2,1),4);
ocleft(:,2) = 1;
ooright = zeros(size(list3,1),4);
ooright(:,3) = 1;
ocright = zeros(size(list4,1),4);
ocright(:,4) = 1;
out = [ooleft; ocleft; ooright; ocright];
%input 
oleft = zeros(size(list1,1),24*24);
cleft = zeros(size(list2,1),24*24);
oright = zeros(size(list3,1),24*24);
cright = zeros(size(list4,1),24*24);

parfor i = 1:size(list1,1)
% temp = im2bw(homomorphic(strcat('dataset_B_Eye_Images\openLeftEyes\' , list1(i).name)));
temp = (homomorphic(strcat('dataset_B_Eye_Images\openLeftEyes\' , list1(i).name)));
% temp = imread(strcat('dataset_B_Eye_Images\openLeftEyes\' , list1(i).name));
oleft(i,:) = reshape(temp,1,[]);
end

parfor i = 1:size(list2,1)
% temp = im2bw(homomorphic(strcat('dataset_B_Eye_Images\closedLeftEyes\' , list2(i).name)));
temp = (homomorphic(strcat('dataset_B_Eye_Images\closedLeftEyes\' , list2(i).name)));
% temp = imread(strcat('dataset_B_Eye_Images\closedLeftEyes\' , list2(i).name));
cleft(i,:) = reshape(temp,1,[]);
end

parfor i = 1:size(list3,1)
% temp = im2bw(homomorphic(strcat('dataset_B_Eye_Images\openRightEyes\' , list3(i).name)));
temp = (homomorphic(strcat('dataset_B_Eye_Images\openRightEyes\' , list3(i).name)));
% temp = imread(strcat('dataset_B_Eye_Images\openRightEyes\' , list3(i).name));
oright(i,:) = reshape(temp,1,[]);
end

parfor i = 1:size(list4,1)
% temp = im2bw(homomorphic(strcat('dataset_B_Eye_Images\closedRightEyes\' , list4(i).name)));
temp = (homomorphic(strcat('dataset_B_Eye_Images\closedRightEyes\' , list4(i).name)));

% temp = imread(strcat('dataset_B_Eye_Images\closedRightEyes\' , list4(i).name));
cright(i,:) = reshape(temp,1,[]);
end

inp = [oleft; cleft; oright; cright]; 