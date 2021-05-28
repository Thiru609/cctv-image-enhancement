a=imread("imggurrr.jpeg");
imshow(a)
lefti = a(:, 1:end/2, :);
righti = a(:, end/2+1:end, :);
[rows, columns, numberOfColorChannels] = size(a);
upperi = imcrop(a, [1, 1, columns, floor(rows/2)]);
loweri = imcrop(a, [1, ceil(rows/2), columns, floor(rows/2)]);
im=im2double(lefti);
fftlogim=fft2(log(im+0.01));
f=butterhp(lefti,15,1);
c=fftlogim.*f;
h=real(ifft2(c));
hl=exp(h);
imshow(a)

im=im2double(righti);
fftlogim=fft2(log(im+0.01));
f=butterhp(righti,15,1);
c=fftlogim.*f;
h=real(ifft2(c));
hr=exp(h);


im=im2double(upperi);
fftlogim=fft2(log(im+0.01));
f=butterhp(upperi,15,1);
c=fftlogim.*f;
h=real(ifft2(c));
hup=exp(h);


im=im2double(loweri);
fftlogim=fft2(log(im+0.01));
f=butterhp(loweri,15,1);
c=fftlogim.*f;
h=real(ifft2(c));
hlow=exp(h);


imglol1 = [hup;hlow];
nimglol1 = imresize3(imglol1, [1125, 2085, 3]);

imglol2 = [hl,hr];
nimglol2 = imresize3(imglol2, [1125, 2085, 3]);

abc = imadd(nimglol1,nimglol2);



function [ out ] = butterhp( im,d,n )
h=size(im,1);
w=size(im,2);
[x,y]=meshgrid(-floor(w/2):floor((w-1)/2),-floor(h/2):floor((h-1)/2));
out=1./(1.+(d./(x.^2+y.^2).^0.5).^(2*n));

end

function [] = ifftshow(f)
    f1=abs(f);
    fm=max(f1(:));
    figure,imshow(f1/fm);
end