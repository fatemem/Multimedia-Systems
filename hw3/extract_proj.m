function s=extract_proj(W_image, B, a, K)
[height, width] = size(W_image);
numrows=floor(height/B);
numcols=floor(width/B);
shuffled_W1D=zeros(numrows*numcols,1);
dct = @(block_struct) dct2(block_struct.data);
dct_W = blockproc(W_image,[B B],dct);
for i=0:numrows-1
    for j=0:numcols-1
        ind1_x=i*B+a+1;
        ind2_x=i*B+a;
        ind1_y=j*B+a;
        ind2_y=j*B+a+1;
        if dct_W(ind1_x,ind1_y) > dct_W(ind2_x,ind2_y)
            shuffled_W1D(i*numrows+j+1)=1;
        end
    end
end
rand('seed',K);
indx=(randperm(numrows*numcols))';
for i=1:numrows*numcols
    s(indx(i),1)=shuffled_W1D(i,1);
end
end