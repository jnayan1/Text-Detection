clear;
clc;
close all;
im=imread('1.jpg');
im=rgb2gray(im);
im1 = im2bw(im);
label = bwlabel(im1);
pagelabel = mode(label(:));
rowlabel = mode(label,2);
r = find(rowlabel==pagelabel);
imf = im(r(1):r(end),:);
imf=imresize(imf,0.25);
im=double(imf);
imf=im;
im_original=im;
a=1:size(im,1);
imf(find(mod(a,2)==1),:)=0;
imf=fliplr(imf);
im(find(mod(a,2)==0),:)=0;
im=im+imf;
len=size(im);
arr=reshape(transpose(im),1,numel(im));
cum=cumsum(arr);
n=200;
r=1;c=n+1;
im2=im_original;
size(im_original)
for i=n+1:numel(im)
    f=0;
    th=cum(i)-cum(i-n);
    th=th/n;
    if(r==2&&c==460)
        th
        im_original(r,c)
    end
    if(im_original(r,c)>th)
        im_original(r,c)=255;
    else
        im_original(r,c)=0;
    end
    if((c==len(2)&&mod(r,2)==1)||(c==1&&mod(r,2)==0))
        r=r+1;
        f=1;
    end
    if(f==0)
        if(mod(r,2)==0)
            c=c-1;
        else
            c=c+1;
        end
    end
end
imshow(im_original);
figure,imhist(im_original);
unique(im_original)