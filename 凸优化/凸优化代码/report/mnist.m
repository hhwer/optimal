train_images = loadMNISTImages('train-images-idx3-ubyte');

[n,p]=size(train_images);
p=p/2;

% split data into half figures
X=train_images(:,1:p);
Y=train_images(:,((p+1):(2*p)));