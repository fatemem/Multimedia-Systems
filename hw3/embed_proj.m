function [W_image, W1D]=embed_proj(I, B, a, W2D, K ,alpha)
W2D=W2D>250;
[height, width] = size(I);
numrows=floor(height/B);
numcols=floor(width/B);
W2D = imresize(W2D,[numrows numcols]);
W1D=W2D(:);
rand('seed',K);
shuffled_W1D=W1D(randperm(length(W1D)));
dct = @(block_struct) dct2(block_struct.data);
dct_I = blockproc(I,[B B],dct);
D=dct_I;

for i=0:numrows-1
    for j=0:numcols-1
        ind1_x=i*B+a+1;
        ind2_x=i*B+a;
        ind1_y=j*B+a;
        ind2_y=j*B+a+1;
        if shuffled_W1D(i*numrows+j+1)==0
            if dct_I(ind1_x,ind1_y) > dct_I(ind2_x,ind2_y)
                D(ind1_x,ind1_y)=dct_I(ind2_x,ind2_y)-alpha;
                D(ind2_x,ind2_y)=dct_I(ind1_x,ind1_y)+alpha;
                
            else
                D(ind1_x,ind1_y)=dct_I(ind1_x,ind1_y)-alpha;
                D(ind2_x,ind2_y)=dct_I(ind2_x,ind2_y)+alpha;
            end
            
        else
            if dct_I(ind1_x,ind1_y) > dct_I(ind2_x,ind2_y)
                D(ind1_x,ind1_y)=dct_I(ind1_x,ind1_y)+alpha;
                D(ind2_x,ind2_y)=dct_I(ind2_x,ind2_y)-alpha;
            else
                D(ind1_x,ind1_y)=dct_I(ind2_x,ind2_y)+alpha;
                D(ind2_x,ind2_y)=dct_I(ind1_x,ind1_y)-alpha;
            end
            
        end
    end
end
idct = @(block_struct) idct2(block_struct.data);
W_image= blockproc(D,[B B],idct);
UW_image=uint8(W_image);
PSNR = psnr(UW_image,I);
display(PSNR);
end