function Ihmf_3 = homomorphic(name)
% gray = imread(name);
i = imread(name);
%gray = rgb2gray(name);

gray = rgb2gray(i);
% imtool(gray)
mde = mode(double(gray(:)));
count = 0;
new = zeros(size(gray,1),size(gray,2));

for i = 1:size(gray,1)
for  j = 1:size(gray,2)
if gray(i,j) <  mde 
count = count +1;
new(count) = gray(i,j);
end
end
end
sigma = gather(gpuArray(std2(new(1:count))));


gray = im2double(gray);
gray = log(1+gray);
M = (2*size(gray,1) + 1);
N = (2*size(gray,2) + 1);


% sigma = 35;


[X, Y] = (meshgrid(1:N,1:M));
centerX = gpuArray(ceil(N/2));
centerY = gpuArray(ceil(M/2));
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H = 1 - H;
%imshow(H,'InitialMagnification',25)
H = fftshift(H);
%imshow(H,'InitialMagnification',25)
%If = fft2(gray, M, N);
%Iout = real(ifft2(H.*If));
%Iout = Iout(1:size(gray,1),1:size(gray,2));
%imshowpair(gray, Ihmf, 'montage')
%Ihmf = exp(Iout) - 1;
%imshowpair(gray, Ihmf, 'montage')
%imshow(Ihmf)
%imshowpair(gray, Ihmf, 'montage')
%imshow(gray)
%imshow(Ihmf)
%imshowpair(gray, Ihmf, 'montage')
alpha = 0.5;
beta = 1.5;
Hemphasis = alpha + beta*H;
% If = fft2(gray, M, N);
% Iout = real(ifft2(Hemphasis.*If));
% Iout = Iout(1:size(gray,1),1:size(gray,2));
% Ihmf_2 = exp(Iout) - 1;
% imshowpair(gray, Ihmf_2, 'montage')
% imshow(Ihmf_2)
% imshowpair(Ihmf, Ihmf_2, 'montage')
paddedI = padarray(gray,ceil(size(gray)/2)+1,'replicate');
paddedI = paddedI(1:end-1,1:end-1);
If = fft2(gpuArray(paddedI));
Iout = real(ifft2(Hemphasis.*If));
%imshow(Iout)
Iout = Iout(ceil(M/2)-size(gray,1)/2+1:ceil(M/2)+size(gray,1)/2,ceil(N/2)-size(gray,2)/2+1:ceil(N/2)+size(gray,2)/2);
Ihmf_3 = gather(exp(Iout) - 1);
Ihmf_3 = adapthisteq(Ihmf_3);
%imshowpair(gray, Ihmf_3, 'montage')
% imshowpair(histeq(mat2gray(Ihmf_2)), histeq(mat2gray(Ihmf_3)), 'montage')
% imshow(Iout)