function i = cluster(i)
i = im2uint8(i);
[idx, centroids]=kmeans(double(i(:)),3);

idx = reshape(idx,size(i,1),size(i,2) );
[c, I] = min(centroids);
[c, I2] = max(centroids);
for a =1:size(i,1)
for b = 1:size(i,2)
if  idx(a,b) == I
i(a,b) = 0;
elseif idx(a,b) == I
i(a,b) = 255;
else
  i(a,b) = 128;  
end
end
end