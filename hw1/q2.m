pic = imread('1.tif');
pic2=imread('2.tif');
pic1 = histeq(pic);
imshow(hist_equalization(pic,pic2))
function y = hist_equalization (K,L)
%calculating the PDFs
p_k = zeros(256,1);
[height, width] = size(K);
for i=1:height
    for j=1:width
    p_k(K(i,j)+1)=p_k(K(i,j)+1)+1;
    end
end

p_l = zeros(256,1);
[height2, width2] = size(L);
for x=1:height2
    for y=1:width2
    p_l(L(x,y)+1)=p_l(L(x,y)+1)+1;
    end
end

%calculating CDFs
c_k = zeros(256,1);
c_l = zeros(256,1);
c_k(1)=p_k(1);
c_l(1)=p_l(1);
for i=2:256
   c_k(i)=c_k(i-1)+p_k(i);
   c_l(i)=c_l(i-1)+p_l(i); 
end

 c_k=c_k / numel(K);
 c_l=c_l / numel(L);

%find the map
map = zeros(255,1);

for z=1:256
    min=2;%large amount
    for w=1:256
        d=abs(c_k(z)- c_l(w));
        if min>d
            min=d;
            idx=w;
        end
    end
   map(z)=idx-1;
end

%apply mapping on the first image
for i=1:height
    for j=1:width
    y(i,j)=map(K(i,j)+1)/255;
    end
end

end
