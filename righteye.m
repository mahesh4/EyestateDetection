face = vision.CascadeObjectDetector;
 img = homomorphic('selfie3.jpg');
% img = im2double(rgb2gray(imread('selfie.jpg')));
img2 = im2bw(cluster(img));

bbox = step(face,img);
for i = 1: size(bbox,1)
    left = vision.CascadeObjectDetector('RightEyeCART');
    temp = (img(bbox(i,2):bbox(i,2)+bbox(i,4),bbox(i,1):bbox(i,1)+bbox(i,3)));
     tempp = (img2(bbox(i,2):bbox(i,2)+bbox(i,4),bbox(i,1):bbox(i,1)+bbox(i,3)));
    box = step(left,temp);
    if size(box,1) == 0
        continue;
    end
    temp2 = (tempp(box(1,2)+25:box(1,2)+box(1,4),box(1,1)-10:box(1,1)+box(1,3)+5));
    imshow(temp2)
    pause;
    temp2 = imresize(temp2 , [24 24]);
  
    
    temp2 = reshape(temp2,1,[]);
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
    
     
        
    
