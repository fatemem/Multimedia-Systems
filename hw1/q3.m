pic = imread('1.tif');
J=salt_pepper (pic,0.02);
MED=Hw_median(J,15);
AVG=Hw_mean(J,3);

subplot(1,3,1), imshow(J)
subplot(1,3,2), imshow(MED)
subplot(1,3,3), imshow(AVG)

function x=salt_pepper (I,n)
new=I;
[height, width] = size(I);
for i=1:height
   for j=1:width
       r=rand;
       if r<n
           r1=rand;
           if r1<0.5
               new(i,j)=0;
           else
               new(i,j)=255;
           end
       end 
   end 
end
x=new;    
end

function w=find_neighbors(x,y,img,n)
w=zeros(n,n);
        a=x-floor(n/2);
        b=y-floor(n/2);
         for c=1:n
             for d=1:n
                w(c,d)=img(a,b);
                b=b+1;
             end
             a=a+1;
             b=y-floor(n/2);
         end
end

function y=Hw_mean (I,n)
p=floor(n/2);
new = padarray(I,[p p],0,'both');% zero padding
[height, width] = size(I);
res=zeros(height, width,'uint8');
for i=p+1:height+p
    for j=p+1:width+p
        w=find_neighbors(i,j,new,n);
        window=w(:);
        M = mean(window);
        res(i-p,j-p)=M;    
    end
end
y=res;
end


function z=Hw_median(I,n)
p=floor(n/2);
new = padarray(I,[p p],0,'both');% zero padding
[height, width] = size(I);
res=zeros(height, width,'uint8');
for i=p+1:height+p 
    for j=p+1:width+p
        w=find_neighbors(i,j,new,n);
        window=w(:);
        M = median(window);
        res(i-p,j-p)=M;
    end
end
z=res;
 end
