function [vis,pixelcount]=bfs(vis,swt,x,y,n,m,val,counter,pixelcount,median_val)
vis(x,y)=counter;
queue=zeros(n*m,2);
cnt1=1;
cnt2=1;
queue(cnt2,1)=x;
queue(cnt2,2)=y;
cnt2=cnt2+1;
while(cnt1~=cnt2)
    x=queue(cnt1,1);
    y=queue(cnt1,2);
    cnt1=cnt1+1;
    for i=-1:1
        for j=-1:1
            p=x+i;
            q=y+j;
            if(p>0&&p<n&&q>0&&q<m)
                if(vis(p,q)==0)
                    %r=swt(p,q)/val;
                    r=swt(p,q)/swt(x,y);
                    if(r>=0.5&& r<=2)
                        pixelcount=pixelcount+1;            
                        queue(cnt2,1)=p;
                        queue(cnt2,2)=q;
                        vis(p,q)=counter;
                        cnt2=cnt2+1;
                    end
                end
            end
        end
    end
end