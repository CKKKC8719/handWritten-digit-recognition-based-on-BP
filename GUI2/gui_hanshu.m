function [ numberqq ] = gui_hanshu( photo_matrix )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

        load mydata;
        
        photo_matrix=imresize(photo_matrix,[16 16]);
        %photo_matrix=uint8(photo_matrix<=230);
        %thresh=graythresh(photo_matrix);%确定二值化阈值
        %photo_matrix=im2bw(photo_matrix,thresh);%对图像二值化
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
        numberqq=index(10);
        index;
        
end

