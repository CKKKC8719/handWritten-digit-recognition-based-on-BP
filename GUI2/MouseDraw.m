function  MouseDraw(action)

% MouseDraw 本例展示如何以Handle Graphics来设定滑鼠事件
% (MouseDraw Events)的反应指令(Callbacks)

% 本程序在鼠标移动非常快时，不会造成画“断线”
% global不能传矩阵
 global InitialX InitialY FigHandle PHOTO
 
 imSize = 50;
 if nargin == 0, action = 'start';   end
 
 switch(action)
    %%开启图形视窗
    case 'start',
        FigHandle = figure('WindowButtonDownFcn','MouseDraw down');
        axis([1 imSize 1 imSize]);    % 设定图轴范围
%         axis off;
        grid on;
        box on;     % 将图轴加上图框
        title('手写体输入窗');
% %         fprintf('start');
        %%设定滑鼠按钮被按下时的反应指令为「MouseDraw down」
        % set(gcf, 'WindowButtonDownFcn', 'MouseDraw down');  
        dlmwrite('IXT.txt', -10, 'delimiter', '\t', 'precision', 6);
        dlmwrite('IYT.txt', -10, 'delimiter', '\t', 'precision', 6);
        %%滑鼠按钮被按下时的反应指令
    case 'down',
        if strcmp(get(FigHandle, 'SelectionType'), 'normal')    %如果是左键
            set(FigHandle,'pointer','hand');      
            CurPiont = get(gca, 'CurrentPoint');
            InitialX = CurPiont(1,1);
            InitialY = CurPiont(1,2);
            dlmwrite('IXT.txt', InitialX, '-append', 'delimiter', '\t', 'precision', 6);
            dlmwrite('IYT.txt', InitialY, '-append', 'delimiter', '\t', 'precision', 6);
            % 列印「MouseDraw down!」讯息
% %             fprintf('MouseDraw down!\n');
            % 设定滑鼠移动时的反应指令为「MouseDraw move」
            set(gcf, 'WindowButtonMotionFcn', 'MouseDraw move');
            set(gcf, 'WindowButtonUpFcn', 'MouseDraw up');
        elseif strcmp(get(FigHandle, 'SelectionType'), 'alt')   % 如果是右键
            set(FigHandle, 'Pointer', 'arrow');
            set( FigHandle, 'WindowButtonMotionFcn', '')
            set(FigHandle, 'WindowButtonUpFcn', '')
            fprintf('MouseDraw right button down!\n');
            ImageX = importdata('IXT.txt');
            ImageY = importdata('IYT.txt');
            InputImage = ones(imSize);
            roundX = round(ImageX);
            roundY = round(ImageY);
            for k = 1:size(ImageX,1)
                if 0<roundX(k) && roundX(k)<imSize && 0<roundY(k) && roundY(k)<imSize
                    InputImage(roundX(k)-1:roundX(k)+2, roundY(k)-1:roundY(k)+2) = 0;
                end
            end
            InputImage = imrotate(InputImage,90);       % 图像旋转90
            %figure(2);
            %imshow(InputImage);
           %PHOTO = InputImage;
           Realimage=InputImage;
           
           InputImage=imcomplement(InputImage);
           InputImage=chuli(InputImage);
           
           %Realimage=imresize(InputImage,[100 100]);
           fid=fopen('A1.txt','w+');
            [bbb1 bbb2]=size(InputImage);
            for iii=1:bbb1
                for jjj=1:bbb2
                   fprintf(fid,'%10f',InputImage(iii,jjj));
                end
               fprintf(fid,'\n');
            end
            fclose(fid);
            title('手写体输入窗--图像录入成功！！！');
            pause(1);
            close;
            
            
            
            
            fid=fopen('A2.txt','w+');
            [bbb1 bbb2]=size(Realimage);
            for iii=1:bbb1
                for jjj=1:bbb2
                   fprintf(fid,'%10f',Realimage(iii,jjj));
                end
               fprintf(fid,'\n');
            end
            fclose(fid);
           
            
            
      
            
        end
    %%滑鼠移动时的反应指令
    case 'move',
        CurPiont = get(gca, 'CurrentPoint');
        X = CurPiont(1,1);
        Y = CurPiont(1,2);
        % 当鼠标移动较快时，不会出现离散点。
        % 利用y=kx+b直线方程实现。
        x_gap = 0.1;    % 定义x方向增量
        y_gap = 0.1;    % 定义y方向增量
        if X > InitialX
            step_x = x_gap;
        else
            step_x = -x_gap;
        end
        if Y > InitialY
            step_y = y_gap;
        else
            step_y = -y_gap;
        end  
        % 定义x,y的变化范围和步长
        if abs(X-InitialX) < 0.01        % 线平行于y轴，即斜率不存在时
            iy = InitialY:step_y:Y;
            ix = X.*ones(1,size(iy,2));
        else
            ix = InitialX:step_x:X ;    % 定义x的变化范围和步长
            % 当斜率存在，即k = (Y-InitialY)/(X-InitialX) ~= 0
            iy = (Y-InitialY)/(X-InitialX).*(ix-InitialX)+InitialY;   
        end
        ImageX = [ix, X]; 
        ImageY = cat(2, iy, Y);
        line(ImageX,ImageY, 'marker', '.', 'markerSize',28, ...
            'LineStyle', '-', 'LineWidth', 4, 'Color', 'Red');
        dlmwrite('IXT.txt', ImageX, '-append', 'delimiter', '\t', 'precision', 6);
        dlmwrite('IYT.txt', ImageY, '-append', 'delimiter', '\t', 'precision', 6);
        InitialX = X;       %记住当前点坐标
        InitialY = Y;       %记住当前点坐标
        % 列印「MouseDraw is moving!」及滑鼠现在位置
        % fprintf('MouseDraw is moving! Current location = (%g, %g)\n', ...
          % CurPiont(1,1), CurPiont(1,2));
% %         fprintf('MouseDraw move!\n');
        % 设定滑鼠按钮被释放时的反应指令为「MouseDraw up」
        % set(gcf, 'WindowButtonUpFcn', 'MouseDraw up');
    %%滑鼠按钮被释放时的反应指令
    case 'up',
        % 清除滑鼠移动时的反应指令
        set(gcf, 'WindowButtonMotionFcn', '');
        % 清除滑鼠按钮被释放时的反应指令
        set(gcf, 'WindowButtonUpFcn', '');
        % 列印「MouseDraw up!」
% %         fprintf('MouseDraw up!\n');
 end
 
end