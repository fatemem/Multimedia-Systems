pic = imread('Hi.tif');
imshow(IUT_rotate(pic,185))

function J= IUT_rotate(I, teta)
% Convert to radian
a =  teta*pi/180;
[height, width] = size(I);
midx=ceil((width+1)/2);
midy=ceil((height+1)/2);
Diagonal = sqrt(height^2 + width^2); 
RowPad = ceil(Diagonal - height) + 2;
ColPad = ceil(Diagonal - width) + 2;
result=zeros(height+RowPad, width+ColPad,'uint8');
%rotation
for i=1:height
    for j=1:width

         x=(i-midx)*cos(a)-(j-midy)*sin(a);
         y=(i-midx)*sin(a)+(j-midy)*cos(a);
         x=round(x)+midx+ceil(RowPad/2);
         y=round(y)+midy+ceil(ColPad/2);

         if (x>=1 && y>=1)
              result(x,y)=I(i,j); % k degrees rotated image         
         end

    end
end
J=Hw_median(result,3)
end

function z=Hw_median(I,n)
p=floor(n/2);
new = padarray(I,[p p],0,'both');% zero padding
[height, width] = size(I);
res=zeros(height, width,'uint8');
for i=p+1:height+p 
    for j=p+1:width+p
        w=new(i-p:i+p,j-p:j+p);
        window=w(:);
        M = median(window);
        res(i-p,j-p)=M;
    end
end
z=res;
end