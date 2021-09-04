function main_Adaptive(I, B, a, W2D, K, alpha, Q)
[I1,w1D]=embed_proj(I,B,a,W2D,K,alpha);
I2=uint8(I1);
outputname=fullfile(['W_image' num2str(Q) '.jpg']);
imwrite(I2,outputname,'Quality',Q);
W_image=imread(outputname);
s=extract_proj(W_image, B, a, K);
NC=NC_project(s, w1D);
display(NC);
figure('Name','original image');
imshow(I);
figure('Name','watermark image');
imshow(I2);
figure('Name','saved image');
imshow(W_image);
figure('Name','original logo');
[height, width] = size(W_image);
h=floor(height/B);
r=floor(width/B);
W1D=reshape(w1D,[h,r]);
imshow(W1D);
figure('Name','extracted logo');
s1=reshape(s,[h,r]);
imshow(s1);
end