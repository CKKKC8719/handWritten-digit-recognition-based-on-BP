
V=double(rand(256,64));
W=double(rand(64,10));
delta_V=double(rand(256,64));
delta_W=double(rand(64,10));

yita=0.1;%缩放系数，有的文章称学习率
yita1=0.05;%我自己加的参数，缩放激活函数的自变量防止输入过大进入函数的饱和区，可以去掉体会一下变化
train_number=9;%训练样本中，有多少个数字，一共9个，没有0
train_num=100;%训练样本中，每种数字多少张图，一共100张
x=double(zeros(1,256));%输入层
y=double(zeros(1,64));%中间层，也是隐藏层
output=double(zeros(1,10));%输出层
tar_output=double(zeros(1,10));%目标输出，即理想输出
delta=double(zeros(1,10));%一个中间变量，可以不管

%记录总的均方差便于画图
s_record=1:1000;
tic %计时
for train_control_num=1:1000  %训练次数控制，在调参的最后发现1000次其实有多了，大概400次完全够了
    s=0;
%读图，输入网络
    for number=1:train_number
        ReadDir=['E:\MATLAB-R2017a\recognize_handwiting_numbers\train100\'];%读取样本的路径
            for num=1:train_num  %控制多少张
                photo_name=[num2str(number),num2str(num,'%05d'),'.png'];%图片名
                photo_index=[ReadDir,photo_name];%路径加图片名得到总的图片索引
                photo_matrix=imread(photo_index);%使用imread得到图像矩阵
             %   photo_matrix=uint8(photo_matrix<=230);%二值化，黑色是1
                thresh=graythresh(photo_matrix);%确定二值化阈值
                photo_matrix=im2bw(photo_matrix,thresh);%对图像二值化
%                 photo_matrix=imcomplement(photo_matrix);
%                 photo_matrix=chuli(photo_matrix);
                tmp=photo_matrix';
                tmp=tmp(:);%以上两步完成了图像二维矩阵转变为列向量，256维，作为输入
                %计算输入层输入
                x=double(tmp');%转化为行向量因为输入层X是行向量，并且化为浮点数
                %得到隐层输入
                y0=x*V;
                %激活
                y=1./(1+exp(-y0*yita1));
                %得到输出层输入
                output0=y*W;
                output=1./(1+exp(-output0*yita1));
                %计算预期输出
                tar_output=double(zeros(1,10));
                tar_output(number)=1.0;
                %计算误差
                %按照公式计算W和V的调整，为了避免使用for循环比较耗费时间，下面采用了直接矩阵乘法，更高效
                delta=(tar_output-output).*output.*(1-output);
                delta_W=yita*repmat(y',1,10).*repmat(delta,64,1);
                tmp=sum((W.*repmat(delta,64,1))');
                tmp=tmp.*y.*(1-y);
                delta_V=yita*repmat(x',1,64).*repmat(tmp,256,1);
                %计算均方差
                s=s+sum((tar_output-output).*(tar_output-output))/10;
                %更新权值
                W=W+delta_W;
                V=V+delta_V;
            end

      end
s=s/train_number/train_num  %不加分号，随时输出误差观看收敛情况
train_control_num           %不加分号，随时输出迭代次数观看运行状态
s_record(train_control_num)=s;%记录
end
toc %计时结束
plot(1:1000,s_record);
axis([1 1000,0 0.1]);

