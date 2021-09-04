pic = imread('Hi.tif');
y=Hw2_binarization(pic,9)
imshow(y)

%the output of function is the texture of input image
function A= Hw2_binarization(image,k)
p=floor(k/2);
new = padarray(image,[p p],0,'both');% zero padding
[height, width] = size(image);
res=zeros(height, width,'uint8');
for i=p+1:height+p
    for j=p+1:width+p
        w=new(i-p:i+p,j-p:j+p);
        window=w(:);
        M = mean(window);
        if new(i,j)>M
            res(i-p,j-p)=255;
        end
            
    end
end
A=res;
end