% test;
% imshow('ak.jpg')
% pause;
face = vision.CascadeObjectDetector;
name = 'ak.jpg';
img1 = imread(name);
% img = homomorphic(name);
 img = im2bw(cluster(homomorphic(name)));
% img = im2double(rgb2gray(imread('selfie.jpg')));
% img2 = im2bw(cluster(img1));

bbox = step(face,img1);
for i = 1: size(bbox,1)
    left = vision.CascadeObjectDetector('LeftEyeCART');
    temp = (img1(bbox(i,2):bbox(i,2)+bbox(i,4),bbox(i,1):bbox(i,1)+bbox(i,3)));
     tempp = (img(bbox(i,2):bbox(i,2)+bbox(i,4),bbox(i,1):bbox(i,1)+bbox(i,3)));
    box = step(left,temp);
    if size(box,1) == 0
        continue;
    end
    for j = 1:size(box,1)
    temp2 = (tempp(box(j,2)+25:box(j,2)+box(j,4),box(j,1)-10:box(j,1)+box(j,3)+5));
    imshow(temp2)
    pause;
    temp2 = imresize(temp2 , [24 24]);
  
%     bwmorph(temp2,'thin');
    temp2 = reshape(temp2,1,[]);
    netopen(temp2')
     result = net(temp2');
    [c,l] = max(result);
    if c > 0.5
        if l == 1
            disp(' left eye open')
        elseif l == 2
            disp(' left eye closed')
        elseif l == 3
            disp(' right eye open')
        elseif l == 4
            disp(' right eye closed')
        end
    else
        disp('no eyes found')
    end
    end
end
    
     
        
    
