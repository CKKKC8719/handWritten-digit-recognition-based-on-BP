%clear all;
A=imread('1111.png');
%load A1.txt;
%A=A1;
thresh=graythresh(A);%确定二值化阈值
A=im2bw(A,thresh);%对图像二值化
[m n]=size(A);
A=imcomplement(A);
location1_min=9999;%行
location1_max=-1;%行
location2_min=9999;%列
location2_max=-1;%列
for i=1:m
    if sum(A(i,:)) > 0
        if i < location1_min
        location1_min = i;
        end
        if i > location1_max || i == location1_max
         location1_max = i;
        end
    end
end
for j=1:n
    if sum(A(:,j)) > 0
        if j < location2_min
             location2_min = j;
        end
        if j > location2_max || j == location2_max
             location2_max = j+1;   
        end
    end
end
%new_photo=zeros(location1_min:location1_max,location2_min:location2_max);
new_photo=A(location1_min:location1_max,location2_min:location2_max);
imshow(new_photo);
[mm nn]=size(new_photo);
if mm > nn
   new_photo=imresize(new_photo,[120 round(120/mm)*nn],'bicubic');
   figure
   imshow(new_photo);
else
   new_photo=imresize(new_photo,[round(120/nn)*mm 120],'bicubic');
end
[mmm nnn]=size(new_photo);
new_photo=padarray(new_photo,[160-mmm 160-nnn],0);
figure
imshow(new_photo)
new_photo=imresize(new_photo,[16 16]);



    


         
