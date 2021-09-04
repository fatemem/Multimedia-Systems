pic = imread('1.tif');
pic2 = imread('2.tif');
imshow(rule2 (pic2,pic,0.1));

function x=rule1 (a,b,l)
if numel(a)< numel(b)
    bb = imresize(b,size(a));
    x=l*a+(1-l)*bb;
else
    aa = imresize(a,size(b));
    x=l*aa+(1-l)*b;
end
end

function y=rule2 (a,b,l)
if numel(a)< numel(b)
    img2 = imresize(b,size(a));
    img1=a;
else
    img1 = imresize(a,size(b));
    img2=b;    
end
[height, width] = size(img1);
for i=1:height
   for j=1:width
       r=rand;
       if r<l
               y(i,j)=img1(i,j);
       else
               y(i,j)=img2(i,j);
       end 
   end 
end
end