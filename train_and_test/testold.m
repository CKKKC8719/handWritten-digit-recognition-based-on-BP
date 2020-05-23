
correct_num=0;%记录正确的数量
incorrect_num=0;%记录错误数量
test_number=9;%测试集中，一共多少数字，9个，没有0
test_num=20;%测试集中，每个数字多少个，最大100个
% load W;%%之前训练得到的W保存了，可以直接加载进来
% load V;
% load yita1;
%记录时间
tic %计时开始
for number=1:test_number
    ReadDir=['E:\MATLAB-R2017a\recognize_handwiting_numbers\text20\'];
    for num=1:test_num  %控制多少张
        photo_name=[num2str(number),num2str(num,'%04d'),'.png'];
        photo_index=[ReadDir,photo_name];
        photo_matrix=imread(photo_index);
        %大小改变
        photo_matrix=imresize(photo_matrix,[16 16]);
        %二值化
       % photo_matrix=uint8(photo_matrix<=230);%黑色是1
        thresh=graythresh(photo_matrix);%确定二值化阈值
        photo_matrix=im2bw(photo_matrix,thresh);%对图像二值化
%         photo_matrix=imcomplement(photo_matrix);
%         photo_matrix=chuli(photo_matrix);
        %行向量
        tmp=photo_matrix';
        tmp=tmp(:);
        %计算输入层输入
        x=double(tmp');
        %得到隐层输入
        y0=x*V;
        %激活
        y=1./(1+exp(-y0*yita1));
        %得到输出层输入
        o0=y*W;
        o=1./(1+exp(-o0*yita1));
        %最大的输出即是识别到的数字
        [o,index]=sort(o);
        if index(10)==number
            correct_num=correct_num+1
        else
            incorrect_num=incorrect_num+1;
        %     显示不成功的数字，显示会比较花时间
            %figure(incorrect_num)
             %imshow((1-photo_matrix)*255);
             %title(num2str(number));
        end
    end
end
correct_rate=correct_num/test_number/test_num
toc %计时结束