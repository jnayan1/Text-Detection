clear;
clc;
close all;
im=imread('/home/gazzib/Desktop/word/word/1/74.jpg');
im=rgb2gray(im);
% im1 = im2bw(im);
% label = bwlabel(im1);
% pagelabel = mode(label(:));
% rowlabel = mode(label,2);
% r = find(rowlabel==pagelabel);
% imf = im(r(1):r(end),:);
% im=imf;
% %im=imresize(im,0.25);
imshow(im);
l=size(im);
BW2 = edge(im,'canny');
figure,imshow(BW2);
[Gmag, Gdir] = imgradient(im);
swt=zeros(l);
swt(:)=Inf;
edges=find(BW2==1);
[edgex edgey]=ind2sub(size(BW2),edges);
l1=size(edges);
for i=1:l1
    x=edgex(i);
    y=edgey(i);
    m=tand(Gdir(x,y));
    f=0;
    counter=1;
    arr(counter,1)=x;
    arr(counter,2)=y;
    counter=counter+1;
    for j=x+1:l(1)
        x1=j;
        y1=m*(x1-x)+y;
        y1=floor(y1);
        if(x1>0&&x1<l(1)&&y1>0&&y1<l(2))
            if(BW2(x1,y1)==1)
                m1=tand(Gdir(x1,y1));
                if(abs(Gdir(x,y)-Gdir(x1,y1))<=0.577)
                    f=1;
                end
            end
            arr(counter,1)=x1;
            arr(counter,2)=y1;
            counter=counter+1;
        end
        if(f==1)
            break;
        end
    end
    if(f==1)
        x1=arr(counter-1,1);
        y1=arr(counter-1,2);
        dis=sqrt((x1-x).^2+(y1-y).^2);
        for j=1:counter-1
            swt(arr(j,1),arr(j,2))=min(swt(arr(j,1),arr(j,2)),dis);
        end
    end
end
undiscarded=find(swt<Inf);
median_val=median(swt(undiscarded(:)))
swt(find(swt>median_val))=median_val;
figure,imshow(swt,[]);
l2=size(swt);
counter=1;
vis=zeros(l2);
swt1=swt;
arr1=zeros(l2(1)*l2(2),1);
for i=1:l2(1)
    for j=1:l2(2)
        if(vis(i,j)==0)
            pixelcount=1;
            [vis,pixelcount]=bfs(vis,swt,i,j,l2(1),l2(2),swt(i,j),counter,pixelcount);
            arr=find(vis==counter);
            [pointx pointy]=ind2sub(size(swt),arr);
            width=abs(max(pointx)-min(pointx));
            height=abs(max(pointy)-min(pointy));
            diameter=max(height,width);
            %arr1(counter)=pixelcount;
            variance1=var(swt(arr(:)));
            mean1=mean(swt(arr(:)));
            median1=median(swt(arr(:)));
            th=mean1/2;
            ratio=diameter/median1;
             if(variance1>th||ratio>=10) %||pixelcount<10||pixelcount>300)
                 swt(arr(:))=255;
             else
                 swt(arr(:))=0;
             end
            counter=counter+1;
        end
    end
end
%[val label]=sort(arr1,'descend');
figure,imshow(swt,[]);
% swt2=swt1;
% swt2(find(vis==label(1)))=255;
% swt2(find(vis~=label(1)))=0;
% figure,imshow(swt2,[]);