classdef RoboNouMiChiClass < RoboNouMiChiClassOc
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

    end
    
    methods
        function obj = RoboNouMiChiClass(inputArg1,inputArg2)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
            obj.videoPlayer = vision.DeployableVideoPlayer;
            obj.videoReader = vision.VideoFileReader;
            obj.videoWriter = vision.VideoFileWriter;
            obj.peopleDetector = vision.PeopleDetector();
            % J = imread('JapaneseMen.jpeg');
            % J = imread('IMG_1106.jpg');
            % J = imread('Japanese3.jpeg');
            obj.frame = imread('visionteam1.jpg');
            
        end

        function buildExamples(obj,examples)
            for ii=1:length(examples)
                if examples(ii)==1
                    xx = imread('CarPaintDefect.jpg');
                    % From imrect
                    pp = [18.9999999999999 92 1031 188];
                    pp1 = bbox2points(pp);
                    myroi = roipoly(xx,pp1(:,1),pp1(:,2));
                    xx1 = xx;
                    xx1(repmat(~myroi,[1,3]))=0;
                    imwrite(xx1,'CarPaintDefectIsolated.jpg');
                    obj.setFrame(xx1);
                    mc = maskClassOc(1,2);mc.channels={[55 100 -100 100 -100 100]}; [aa,bb] = obj.createMask(mc);imshowpair(obj.frame,bb,'montage');
                    
                    imwrite(bb,'CarPaintDefectIdentified.jpg');
                elseif examples(ii)==2
                    xx = imresize(imread('IMG_6582.JPG'),0.25);
                    imwrite(xx,'AircraftBodyChalkmarks.jpg');
                    obj.setFrame(xx);
                    mc = maskClassOc(1,2);mc.channels={[55 100 -20 0 -20 -1]}; [aa,bb] = obj.createMask(mc);imshowpair(obj.frame,bb,'montage');
                    
                    imwrite(bb,'ChalkmarkingsDetected.jpg');
                end
            end
        end
        
        
        function I = detectPerson(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %             outputArg = obj.Property1 + inputArg;
            %filename = 'visionteam1.jpg';
            
            [bboxes,scores] = step(obj.peopleDetector,obj.frame);
            I = insertObjectAnnotation(obj.frame,'rectangle',bboxes,'Person ');
            
            
        end
        
        function I = humanFrame(obj)
            % The body is represented by 15 points in three space, i.e. a vector of
            % length 45.  The data consists of F, five vectors describing the average
            % female and M, five vectors describing the average male.  Four linked
            % segments, indexed by L, are the head, torso, arms, and legs.
            
            % Initial view
            
            f = figure;
            f.CurrentAxes.set(gcf,'color','white', ...
                'name','Eigenwalker', ...
                'menu','none', ...
                'numbertitle','off')
            F = [];
            M = [];
            H = [];
            load walkers  % Load F and M, Females and Males -- and a surprise.
            V = (F+M)/2;  % Coefficient matrix.
            X = reshape(V(:,1),15,3);
            L = {[1 5],[5 12],[2 3 4 5 6 7 8],[9 10 11 12 13 14 15]};  % Links
            p = {};
            for k = 1:4
                p{k} = line(X(L{k},1),X(L{k},2),X(L{k},3), ...
                    'marker','o', ...
                    'markersize',10, ...
                    'linestyle','-');
            end
            set(p{1},'tag','happy', ...
                'userdata',zeros(1,3));
            %     f.CurrentAxes([-750 750 -750 750 0 1500])
            f.CurrentAxes.XLim=[-750 750];
            f.CurrentAxes.YLim = [ -750 750];
            f.CurrentAxes.ZLim = [0 1500];
            lift = get(gca,'position')+[0 .04 0 0];
%             f.CurrentAxes.set('xtick',[], ...
%                 'ytick',[], ...
%                 'ztick',[], ...
%                 'position',lift, ...
%                 'clipping','off')
            view(160,10)
            myaxis = gca;
                 % Start walkin'...

    period = 151.5751;
    omega = 2*pi/period;
    fps = 120;    % 120 fps when s(1)=1
    t = 0;
    dt = 2*pi/omega/fps;
    s = [1.0 1.0 1.0 1.0 1.0 1.0]';
    steps = 0
%     while get(stop,'value') == 0
    while steps < 1000
        steps = steps+1;
%         s = cell2mat(get(sliders,'value'));
        t = t + s(1)*dt;
        c = [1 sin(omega*t) cos(omega*t) sin(2*omega*t) cos(2*omega*t)]';
        c = [1; s(2:5).*c(2:5)];
        V = (F+M)/2 + s(6)*(F-M)/2;
        X = reshape(V*c,15,3);
        H = get(p{1},'userdata');
        e = ones(size(H,1),1);
        XH = [X(e,:)+H; X(5,:)];
        set(p{1},'xdata',XH(:,1), ...
            'ydata',XH(:,2), ...
            'zdata',XH(:,3))
        for k = 2:4
            set(p{k},'xdata',X(L{k},1), ...
                'ydata',X(L{k},2), ...
                'zdata',X(L{k},3));
        end
        p
        pause(1/(s(1)*fps))
    end;
        end
        
        function I = detectFaces(obj)
            %             Create a detector object.
            
            faceDetector = vision.CascadeObjectDetector;
            %             Read input image.
            
            I = imread('visionteam.jpg');
            %             Detect faces.
            
            bboxes = step(faceDetector, I);
            %             Annotate detected faces.
            
            IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
            figure, imshow(IFaces), title('Detected faces');
        end
        
        
        function  I = detectUpperbody(obj)
            %             Create a detector object and set properties.
            
            bodyDetector = vision.CascadeObjectDetector('UpperBody');
            bodyDetector.MinSize = [60 60];
            bodyDetector.MergeThreshold = 10;
            %             Read input image and detect upper body.
            
            I = imread('visionteam.jpg');
            bboxBody = step(bodyDetector, I);
            %             Annotate detected upper bodies.
            
            IBody = insertObjectAnnotation(I, 'rectangle',bboxBody,'Upper Body');
            figure, imshow(IBody), title('Detected upper bodies');
        end
        
        function I = recognizeFace(obj)
            faceDB = imageSet('att_faces','recursive');
            
            %% Show faces
            figure;
            montage(faceDB(3).ImageLocation);
            title("Faces for a person recorded");
            
            %% Query face vs All faces
            queryFace = 1;
            galleryImage = read(faceDB(queryFace),1);
            figure;
            faces = {};
            for i=1:size(faceDB,2)
                faces(i) = faceDB(i).ImageLocation(1);
            end
            galleryImage = insertObjectAnnotation(galleryImage, 'rectangle',[100 100, 100, 100],'Mathew');
            subplot(1,2,1)
            imshow(galleryImage);
            subplot(1,2,2);
            montage(faces);
            I = faces(1);
            
            
        end
        
        
        function I = rangeFilter(obj,nbhood)
            I = rangefilt(obj.frame,nbhood);
        end
           
        function I = detectHumanMovement(obj)
            
            %create object of videoReader
            vid = VideoReader('../panasonic/sample_b_1.mp4');
            
            %find number of frames in video
            %             no_of_frames = vid.NumberOfFrames;
            %             fprintf('number of frames in video : %d \n', no_of_frames);
            
            obj.frames{1} = read(vid,1);
            obj.frames{2} = read(vid,50);
            obj.frames{3} = read(vid,60);
            
            frame1gray = rgb2gray(obj.frames{2}-obj.frames{1});
            frame2gray = rgb2gray(obj.frames{3}-obj.frames{1});
            
            I = imshowpair(frame1gray,frame2gray);
        end
        
        function tableout = importfile(obj,workbookFile,sheetName,startRow,endRow)
            %IMPORTFILE スプレッドシ?[トからデ?[タをインポ?[ト
            %   DATA = IMPORTFILE(FILE) FILE という名前の Microsoft Excel スプレッドシ?[ト
            %   ファイルの?ﾅ?奄ﾌ???[クシ?[トからデ?[タを読み取り?Aテ?[ブルとして返します?B
            %
            %   DATA = IMPORTFILE(FILE,SHEET) 指定された???[クシ?[トから読み取ります?B
            %
            %   DATA = IMPORTFILE(FILE,SHEET,STARTROW,ENDROW)
            %   指定した???[クシ?[トから指定した?s間隔で読み取ります?BSTARTROW と ENDROW
            %   を連続していない?s間隔で一致するサイズのスカラ?[またはベクトルの組として指定します?Bファイルの?ﾅ後まで読み取るには?A無限の ENDROW
            %   を指定します?B%
            % 例:
            %   DefectImageList = importfile('DefectImageList.xlsx','並べ替え後',1,1000);
            %
            %   XLSREAD も参?ﾆしてください?B
            
            % MATLAB による自動?ｶ?ｬ 2017/11/05 01:34:00
            
            %% 入力の取り扱い
            
            % シ?[トが指定されていない?????A?ﾅ?奄ﾌシ?[トを読み?桙ﾝます
            if nargin == 1 || isempty(sheetName)
                sheetName = 1;
            end
            
            % ?sの始点と?I点が指定されていない?????A既定値を定義します
            if nargin <= 3
                startRow = 1;
                endRow = 1000;
            end
            
            %% デ?[タのインポ?[ト
            [~, ~, raw1] = xlsread(workbookFile, sheetName, sprintf('A%d:C%d',startRow(1),endRow(1)));
            [~, ~, raw2] = xlsread(workbookFile, sheetName, sprintf('E%d:E%d',startRow(1),endRow(1)));
            raw = [raw1,raw2];
            for block=2:length(startRow)
                [~, ~, tmpRawBlock1] = xlsread(workbookFile, sheetName, sprintf('A%d:C%d',startRow(block),endRow(block)));
                [~, ~, tmpRawBlock2] = xlsread(workbookFile, sheetName, sprintf('E%d:E%d',startRow(block),endRow(block)));
                raw = [raw;tmpRawBlock1,tmpRawBlock2]; %#ok<AGROW>
            end
            stringVectors = string(raw(:,[1,2,3,4]));
            stringVectors(ismissing(stringVectors)) = '';
            
            %% テ?[ブルの???ｬ
            tableout = table;
            
            %% インポ?[トした配列を列変?薄ｼに割り当てます
            tableout.VarName1 = categorical(stringVectors(:,1));
            tableout.VarName2 = stringVectors(:,2);
            tableout.VarName3 = categorical(stringVectors(:,3));
            tableout.VarName5 = categorical(stringVectors(:,4));
            
            
        end
        function [BW,maskedImage] = segmentImage(obj,X,pts,tol)
            %segmentImage Segment image using auto-generated code from imageSegmenter App
            %  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
            %  code from the imageSegmenter App. The final segmentation is returned in
            %  BW, and a masked image is returned in MASKEDIMAGE.
            
            % Auto-generated by imageSegmenter app on 06-Nov-2017
            %----------------------------------------------------
            
            if length(obj.gaborX) == 0
                obj.createGaborFeatures(X);
            end
            
            % テクスチャを使用した自動クラスタリング
            sz = size(obj.gaborX);
            im = reshape(obj.gaborX,sz(1)*sz(2),[]);
            s = rng;
            rng('default');
            L = kmeans(im,2,'Replicates',2);
            rng(s);
            BW = L == 2;
            BW = reshape(BW,[sz(1) sz(2)]);
            
            % テクスチャを使用した塗りつぶし
            for pp=1:length(pts)
                pt=pts(pp);
                row = pt(1);
                column = pt(2);
                tolerance = 2.500000e-01*tol;
                normGaborX = sum((obj.gaborX - obj.gaborX(row,column,:)).^2,3);
                normGaborX = mat2gray(normGaborX);
                addedRegion = grayconnected(normGaborX, row, column, tolerance);
                BW = BW | addedRegion;
            end
            
            
%             % テクスチャを使用した塗りつぶし
%             row = 100;
%             column = 100;
%             tolerance = 2.500000e-01;
%             normGaborX = sum((obj.gaborX - obj.gaborX(row,column,:)).^2,3);
%             normGaborX = mat2gray(normGaborX);
%             addedRegion = grayconnected(normGaborX, row, column, tolerance);
%             BW = BW | addedRegion;
            
            % Create masked image.
            maskedImage = X;
%             maskedImage(~BW) = 0;
            maskedImage(repmat(~BW,[1 1 3])) = 0;
            obj.maskedSegmentedImage = maskedImage;
            obj.BW = BW;
        end
        
        function gaborFeatures = createGaborFeatures(obj,im)
            
            if size(im,3) == 3
                obj.frame = obj.prepLab(im);
            else 
                obj.frame = im;
            end
            
            obj.frame = im2single(obj.frame);
            
            imageSize = size(obj.frame);
            numRows = imageSize(1);
            numCols = imageSize(2);
            
            wavelengthMin = 4/sqrt(2);
            wavelengthMax = hypot(numRows,numCols);
            n = floor(log2(wavelengthMax/wavelengthMin));
            wavelength = 2.^(0:(n-2)) * wavelengthMin;
            
            deltaTheta = 45;
            orientation = 0:deltaTheta:(180-deltaTheta);
            
            obj.gabor = gabor(wavelength,orientation);
            gabormag = imgaborfilt(obj.frame(:,:,1),obj.gabor);
            
            for i = 1:length(obj.gabor)
                sigma = 0.5*obj.gabor(i).Wavelength;
                K = 3;
                gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),K*sigma);
            end
            
            % Increases liklihood that neighboring pixels/subregions are segmented together
            X = 1:numCols;
            Y = 1:numRows;
            [X,Y] = meshgrid(X,Y);
            featureSet = cat(3,gabormag,X);
            featureSet = cat(3,featureSet,Y);
            featureSet = reshape(featureSet,numRows*numCols,[]);
            
            % Normalize feature set
            featureSet = featureSet - mean(featureSet);
            featureSet = featureSet ./ std(featureSet);
            
            gaborFeatures = reshape(featureSet,[numRows,numCols,size(featureSet,2)]);
            
            % Add color/intensity into feature set
            gaborFeatures = cat(3,gaborFeatures,obj.frame);
            obj.gaborX = gaborFeatures;
            
        end
        
        function showGabor(obj)
%             figure;
%             nn = size(obj.gabor)
% %             subplot(nn(1),nn(2),1)
%             for p = 1:length(obj.gabor)
% %                 subplot(nn(1),nn(2),p);
%                 obj.montage{p}=real(obj.gabor(p).SpatialKernel);
%                 lambda = obj.gabor(p).Wavelength;
%                 theta  = obj.gabor(p).Orientation;
%                 title(sprintf('Re[h(x,y)], \\lambda = %d, \\theta = %d',lambda,theta));
%             end
            mm=5701;
            pp = length(obj.gabor)/4
            obj.montage = zeros(mm,mm,1,pp);
            for p= 1:pp
                rows = size(obj.gabor(p).SpatialKernel,1);
                columns = rows;
                obj.montage(1:rows,1:columns,1,p)= real(obj.gabor(p).SpatialKernel);
            end
%             cmap = colormap(gray);
%             montage(obj.montage,cmap);
        end
        
        function [BW, maskedImage, Lout, cmap1] = makeSuperpixels(obj,im,N, labrange, isSuperTrue)
%             im = imresize(image,0.1);
            BW = im(:,:,1) > labrange(1) & im(:,:,1) < labrange(2) & im(:,:,2) > labrange(3) & im(:,:,2) < labrange(4) & im(:,:,3) > labrange(5) & im(:,:,3) < labrange(6);
            %             cmap1 = cmap;
            
            BW = bwareaopen(BW, 100);

            SE = strel('square',50);
            BW = imdilate(BW,SE);
%             
            BW = bwmorph(BW,'majority', 200);
%             
% %             Determine the connected components:
%             CC = bwconncomp(BW, 4);
% %             Compute the area of each component:
%             S = regionprops(CC, 'Area');
% %             Remove small objects:
%             L = labelmatrix(CC);
%             BW = ismember(L, find([S.Area] >= 25)) & ismember(L, find([S.Area] < 20000));


            maskedImage = im;
            doMaskedImage = false;
            
            if doMaskedImage

                maskedImage(repmat(~BW,[1,1,3])) = 0;
                maskedImage = lab2rgb(maskedImage);
            end
            
            
            Lout = [];
            cmap1 = [];
            if isSuperTrue
                [L,N] = superpixels(im,N,'isInputLab',true);
%                 BW1 = boundarymask(L);
                
                meanColor = zeros(size(im),'like',im);
                % meanColor = zeros(N,3);
                meanColor1 = zeros(N,3);
                idx = label2idx(L);
                numRows = size(im,1);
                numCols = size(im,2);
                for labelVal = 1:N
                    redIdx = idx{labelVal};
                    greenIdx = idx{labelVal}+numRows*numCols;
                    blueIdx = idx{labelVal}+2*numRows*numCols;
                    meanColor(redIdx) = mean(im(redIdx));
                    meanColor(greenIdx) = mean(im(greenIdx));
                    meanColor(blueIdx) = mean(im(blueIdx));
                    
                    meanColor1(labelVal,1) = mean(im(redIdx));
                    meanColor1(labelVal,2) = mean(im(greenIdx));
                    meanColor1(labelVal,3) = mean(im(blueIdx));
                end
                
                numColors = 50;
                [idx1,cmap] = kmeans(meanColor1,numColors,'replicates',2);
                cmap1 = cmap;
                cmap = lab2rgb(cmap);
                Lout = zeros(size(im,1),size(im,2));
                for i = 1:N
                    Lout(idx{i}) = idx1(i);
                end
                
                gg = cmap1(:,1) > labrange(1) & cmap1(:,1) < labrange(2) & cmap1(:,2) > labrange(3) & cmap1(:,2) < labrange(4) & cmap1(:,3) > labrange(5) & cmap1(:,3) < labrange(6);
                %             cmap1 = cmap;
                cmap1(repmat(~gg,[1,1,3])) = 0;
                %             figure;
                %             imshow(Lout,lab2rgb(cmap1));
            end
            
            
        end
        function [moviergb, moviep] = processMovie(obj,mov, frames, scale)
%             if obj.profiling == true
%                 profile on -history;
%             end
%             scale = 0.25;
%             obj.setFrame(imresize(mov(:,:,:,1),scale));
%             mysize = size(obj.frame);
%             mysize = [ mysize(1:2), length(frames)];
%             moviep = zeros(mysize,'logical');
            n = 3; m = 3;
            for ff=frames
                
                if isstruct(mov)
                    obj.setFrame(imresize(mov(ff).cdata,scale));
                else
                    obj.setFrame(imresize(mov(:,:,:,ff),scale));
                    
                end
                

                

                doSuperPixel = false;
                mylab = rgb2lab(obj.frame);
                
                if ff == 1
                    
                    moviep = zeros([ size(obj.frame,1), size(obj.frame,2), length(frames)],'double');
                    moviergb = zeros([ size(obj.frame,1), size(obj.frame,2), 3, length(frames)],'uint8');
                    obj.background = mylab(:,:,1);
                    obj.frames{1}=obj.background;
                end

                BBCHANGE = abs(mylab(:,:,1) - obj.frames{1}) > 3;
                BBCHANGE1 = abs(mylab(:,:,1) - obj.background) > 3;
                BBCHANGE1 = bwareaopen(BBCHANGE1,1600);
                BBCHANGE1 = imfill(BBCHANGE1,'holes');
                
                [BBW, maskedImage, Lout, cmap] = obj.makeSuperpixels(mylab,100, [0 100 6 30 5 40],doSuperPixel);
                
                doSkeleton = false;
                if doSkeleton
                    skeleton = bwmorph(BBW,'skel',10);
                end
                
%                 subplot(n,m,1)
%                 image(obj.frame);
%                 title('Original')
%                 
%                 subplot(n,m,2)
%                 imshow(BBW);
%                 
%                 title(ff+" : Mask")
                
                if doSuperPixel
                    subplot(n,m,3)
                    image(Lout);
                    colormap(lab2rgb(cmap));
                    title('M2 : Superpixel')
                end
                
                doMaskedImage = false;
                if doMaskedImage
                    subplot(n,m,4)
                    image(maskedImage);
                    
                    title(ff +" : Masked Image")
                    
                end
                
                if doSkeleton
                    subplot(n,m,5)
                    imshow(skeleton);
                    
                    
                    title(ff +" Skeleton ")
                end
                
%                 F = getframe(gcf);
%                 [X, Map] = frame2im(F);
                
                %                 moviep(:,:,:,ff) = imfuse(obj.frame,bb,'montage');
                moviep(:,:,ff) = mylab(:,:,1);
                zz = sum(BBCHANGE) < 5;
                moviep(:,~zz,ff) = 0;
                bg = obj.background;
                bgNOT = obj.background;
                
                bg(:,~zz) = 0;
                bgNOT(:,zz) = 0;
                
                
                alpha = 0.1;
                beta = 0.0;
                obj.background = alpha*bg + (1-alpha)*moviep(:,:,ff) + bgNOT;
% obj.background =  alpha*bg*beta + (1-alpha)*moviep(:,:,ff) + bgNOT*(1-beta);
                moviep(:,:,ff) = BBCHANGE1;
 
                
            
                myrgb = obj.frame;
%                 imshow(myrgb)
                myrgb(repmat(~BBCHANGE1,[1,1,3])) = 0;
%                 imshow(myrgb)
                moviergb(:,:,:,ff) = myrgb;
%                 imshow(moviergb(:,:,:,ff));
                
                obj.frames{1} = mylab(:,:,1);
            end
%             if obj.profiling == true
%                 obj.profile=profile('info');
%                 profile('off');
%             end
        end
        
        function F = makeMovie(obj)
            figure
            Z = peaks;
            surf(Z)
            axis tight manual
            ax = gca;
            ax.NextPlot = 'replaceChildren';
            
            
            loops = 40;
            F(loops) = struct('cdata',[],'colormap',[]);
            for j = 1:loops
                X = sin(j*pi/10)*Z;
                surf(X,Z)
                drawnow
                F(j) = getframe;
            end
        end
        
        function out = segmentFMM(obj,X)
            % Convert RGB image into L*a*b* color space.
            %             X = rgb2lab(vidFrame);
            figure;
            m = 2; n = 2;
            for i=1:m
                for j=1:n
                    subplot(m,n,(i-1)*m+j);
                    
                    % Create empty mask.
                    mask = false(size(X,1),size(X,2));
                    
                    
                    % Flood fill
                    row = size(X,1)*0.9/m*i;
                    column = size(X,2)*0.9/n*j;
                    
                    mask(row-10:row+10,column-10:column+10) = true;
                    tolerance = 1;
                    normX0 = sum((X - X(row,column,:)).^2,3);
                    normX = mat2gray(normX0);
                    weightImage = graydiffweight(normX, mask, 'GrayDifferenceCutoff', tolerance, 'RolloffFactor',.5);
                    %                     imshow(log(weightImage),[]);
                    [addedRegion, D] = imsegfmm(weightImage, column, row, 0.01);
                    
                    sigma = 1.5;
                    W = gradientweight(X(:,:,1)/100.0, sigma, 'RolloffFactor', 3, 'WeightCutoff', 0.25);
                    [addedRegion1, D] = imsegfmm(W, mask, 0.01);
                    %                     imshow(D);
                    
%                     BW1 = BW | addedRegion;
                    imshow(imfuse(addedRegion,addedRegion1,'montage'));
%                     imshow(BW1);
                    hold on;
                    plot(column+[0 size(X,2)], row*[1 1], 'r.', 'LineWidth', 1.5, 'MarkerSize',15);
                end
            end
        end
        
        
        function s = makeMovieFromFile(obj,filename,scale)
            vidObj = VideoReader(filename);
            vidHeight = vidObj.Height*scale;
            vidWidth = vidObj.Width*scale;
            s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
                'colormap',[]);
            k = 1;
            while hasFrame(vidObj)
                s(k).cdata = imresize(readFrame(vidObj),scale);
                k = k+1;
            end
            
        end
        
        %         ?
        % ????? ?????  ????? ????? ????  ????
        % ?? ??, ?? ??, ?? ??
        % ????? ?????, ???? ????
        % ?????? ?????? ??? ???
        % ???? ???? ????? ???? ????
        % ??  ??, ?????,  ?????? ??????
        % ??????????, ???? ????
        % ??? ??? ????
        % ? ?? ?????
        
        function tracks = initializeTracks(obj)
            % create an empty array of tracks
            obj.tracks = struct(...
                'id', {}, ...
                'bbox', {}, ...
                'kalmanFilter', {}, ...
                'age', {}, ...
                'totalVisibleCount', {}, ...
                'consecutiveInvisibleCount', {});
        end
        function predictNewLocationsOfTracks(obj)
            for i = 1:length(obj.tracks)
                bbox = obj.tracks(i).bbox;
                
                % Predict the current location of the track.
                predictedCentroid = predict(obj.tracks(i).kalmanFilter);
                
                % Shift the bounding box so that its center is at
                % the predicted location.
                predictedCentroid = int32(predictedCentroid) - bbox(3:4) / 2;
                obj.tracks(i).bbox = [predictedCentroid, bbox(3:4)];
            end
        end
        
        function [assignments, unassignedTracks, unassignedDetections] = ...
                detectionToTrackAssignment(obj)
            
            nTracks = length(tracks);
            nDetections = size(centroids, 1);
            
            % Compute the cost of assigning each detection to each track.
            cost = zeros(nTracks, nDetections);
            for i = 1:nTracks
                cost(i, :) = distance(tracks(i).kalmanFilter, centroids);
            end
            
            % Solve the assignment problem.
            costOfNonAssignment = 20;
            [assignments, unassignedTracks, unassignedDetections] = ...
                assignDetectionsToTracks(cost, costOfNonAssignment);
        end
        
        function updateAssignedTracks(obj)
            numAssignedTracks = size(assignments, 1);
            for i = 1:numAssignedTracks
                trackIdx = assignments(i, 1);
                detectionIdx = assignments(i, 2);
                centroid = centroids(detectionIdx, :);
                bbox = bboxes(detectionIdx, :);
                
                % Correct the estimate of the object's location
                % using the new detection.
                correct(obj.tracks(trackIdx).kalmanFilter, centroid);
                
                % Replace predicted bounding box with detected
                % bounding box.
                obj.tracks(trackIdx).bbox = bbox;
                
                % Update track's age.
                obj.tracks(trackIdx).age = tracks(trackIdx).age + 1;
                
                % Update visibility.
                obj.tracks(trackIdx).totalVisibleCount = ...
                    obj.tracks(trackIdx).totalVisibleCount + 1;
                obj.tracks(trackIdx).consecutiveInvisibleCount = 0;
            end
        end
        
        function updateUnassignedTracks(obj)
            for i = 1:length(unassignedTracks)
                ind = unassignedTracks(i);
                obj.tracks(ind).age = obj.tracks(ind).age + 1;
                obj.tracks(ind).consecutiveInvisibleCount = ...
                    obj.tracks(ind).consecutiveInvisibleCount + 1;
            end
        end
        
        function deleteLostTracks(obj)
            if isempty(obj.tracks)
                return;
            end
            
            invisibleForTooLong = 20;
            ageThreshold = 8;
            
            % Compute the fraction of the track's age for which it was visible.
            ages = [obj.tracks(:).age];
            totalVisibleCounts = [obj.tracks(:).totalVisibleCount];
            visibility = totalVisibleCounts ./ ages;
            
            % Find the indices of 'lost' tracks.
            lostInds = (ages < ageThreshold & visibility < 0.6) | ...
                [obj.tracks(:).consecutiveInvisibleCount] >= invisibleForTooLong;
            
            % Delete lost tracks.
            obj.tracks = obj.tracks(~lostInds);
        end
        
        function displayTrackingResults(obj)
            % Convert the frame and the mask to uint8 RGB.
            frame = im2uint8(obj.frame);
            mask = uint8(repmat(mask, [1, 1, 3])) .* 255;
            
            minVisibleCount = 8;
            if ~isempty(obj.tracks)
                
                % Noisy detections tend to result in short-lived tracks.
                % Only display tracks that have been visible for more than
                % a minimum number of frames.
                reliableTrackInds = ...
                    [obj.tracks(:).totalVisibleCount] > minVisibleCount;
                reliableTracks = obj.tracks(reliableTrackInds);
                
                % Display the objects. If an object has not been detected
                % in this frame, display its predicted bounding box.
                if ~isempty(reliableTracks)
                    % Get bounding boxes.
                    bboxes = cat(1, reliableTracks.bbox);
                    
                    % Get ids.
                    ids = int32([reliableTracks(:).id]);
                    
                    % Create labels for objects indicating the ones for
                    % which we display the predicted rather than the actual
                    % location.
                    labels = cellstr(int2str(ids'));
                    predictedTrackInds = ...
                        [reliableTracks(:).consecutiveInvisibleCount] > 0;
                    isPredicted = cell(size(labels));
                    isPredicted(predictedTrackInds) = {' predicted'};
                    labels = strcat(labels, isPredicted);
                    
                    % Draw the objects on the frame.
                    frame = insertObjectAnnotation(frame, 'rectangle', ...
                        bboxes, labels);
                    
                    % Draw the objects on the mask.
                    mask = insertObjectAnnotation(mask, 'rectangle', ...
                        bboxes, labels);
                end
            end
            
            % Display the mask and the frame.
            obj.maskPlayer.step(mask);
            obj.videoPlayer.step(frame);
        end
        
        function createNewTracks(obj)
            centroids = centroids(unassignedDetections, :);
            bboxes = bboxes(unassignedDetections, :);
            
            for i = 1:size(centroids, 1)
                
                centroid = centroids(i,:);
                bbox = bboxes(i, :);
                
                % Create a Kalman filter object.
                kalmanFilter = configureKalmanFilter('ConstantVelocity', ...
                    centroid, [200, 50], [100, 25], 100);
                
                % Create a new track.
                newTrack = struct(...
                    'id', nextId, ...
                    'bbox', bbox, ...
                    'kalmanFilter', kalmanFilter, ...
                    'age', 1, ...
                    'totalVisibleCount', 1, ...
                    'consecutiveInvisibleCount', 0);
                
                % Add it to the array of tracks.
                obj.tracks(end + 1) = newTrack;
                
                % Increment the next id.
                nextId = nextId + 1;
            end
        end
        
        function trackFace(obj, filename, scale,channel )
            % Create a cascade detector object.
            if isempty(filename)
                filename='visionface.avi';
                scale=0.5;
            end
            faceDetector = vision.CascadeObjectDetector();
            
            % Read a video frame and run the detector.
            videoFileReader = vision.VideoFileReader(filename);
            obj.frame      = imresize(step(videoFileReader),scale);
            bbox            = step(faceDetector,obj.frame);
            
            % Draw the returned bounding box around the detected face.
            videoOut = insertObjectAnnotation(obj.frame,'rectangle',bbox,'Face');
            figure, imshow(videoOut), title('Detected face');
            % Get the skin tone information by extracting the Hue from the video frame
            % converted to the HSV color space.
            [hueChannel,~,~] = rgb2hsv(obj.frame);
            xxlab = rgb2lab(obj.frame);
            
            bw = imquantize(xxlab(:,:,2),[4 30]);
            
            if isempty(channel)
                channel = [0 100 4 50 5 50];
            end 
            [BW maskedImage]  = obj.createMask(channel);
            
            % Display the L Channel data and draw the bounding box around the face.
%             figure, imshow(hueChannel), title('Hue channel data');
%             imshow(xxlab(:,:,1),[]), title('L channel data');
            if isempty(bbox)
                bbox = [100 100 50 50];
            end 
                
            rectangle('Position',bbox(1,:),'LineWidth',2,'EdgeColor',[1 1 0])

            % Detect the nose within the face region. The nose provides a more accurate
            % measure of the skin tone because it does not contain any background
            % pixels.
            noseDetector = vision.CascadeObjectDetector('Nose', 'UseROI', true);
            noseBBox     = step(noseDetector, obj.frame, bbox(1,:));
            
            if isempty(noseBBox)
                noseBBox = [110 110 50 50];
            end
            
            % Create a tracker object.
            tracker = vision.HistogramBasedTracker;
            hblob = vision.BlobAnalysis('MinimumBlobArea', 100);
            
            labch = 1;

             
            % Initialize the tracker histogram using the Hue channel pixels from the
            % nose.
%             feature = hueChannel;
            feature = rescale(xxlab(:,:,labch));
            initializeObject(tracker, feature, noseBBox(1,:));
            
            % Create a video player object for displaying video frames.
            videoInfo    = info(videoFileReader);
            videoPlayer  = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);


            obj.background = xxlab(:,:,1);
            obj.frames{1}=obj.background;
            
            
            
            % Track the face over successive video frames until the video is finished.
            while ~isDone(videoFileReader)

                % Extract the next video frame
                obj.frame = imresize(step(videoFileReader),scale);
                [aa,bb] = obj.createMask(channel);
                [~,CENTROID,BBOX] = step(hblob,aa);
%                 xxlab = rgb2lab(obj.frame);
% 
% 
%                 BBCHANGE = abs(xxlab(:,:,1) - obj.frames{1}) > 10;
%                 BBCHANGE1 = abs(xxlab(:,:,1) - obj.background) > 10;
%                 BBCHANGE1 = bwareaopen(BBCHANGE1,100);
%                 BBCHANGE1 = imfill(BBCHANGE1,'holes');
%                 
%                 [aa,bb] = obj.createMask;
%                 
% 
%                 
%                 % RGB -> HSV
%                 [hueChannel,~,~] = rgb2hsv(obj.frame);
%                 
%                 % Track using the Hue channel data
% %                 feature = hueChannel;
%                 feature = rescale(xxlab(:,:,labch));
%                 
%                 bbox = step(tracker, feature);
% 
% %                 bbox = step(tracker, hueChannel);
%                 
%     
%                 
%                 bw2 = imquantize(xxlab(:,:,2),[4 40]);
%                 bw3 = imquantize(xxlab(:,:,3),[6 50]);
%                 bw = bw2==2 | bw3==2;
%                 bw = bwareaopen(bw,100);
% %                 bw = BBCHANGE1;
%                 
%                 videoFrame1 = obj.frame;
%                 
%                 zz = sum(BBCHANGE) < 3;
% %                 videoFrame(:,~zz) = 0;
%                 bg = obj.background;
%                 bgNOT = obj.background;
%                 
%                 bg(:,~zz) = 0;
%                 bgNOT(:,zz) = 0;
%                 
%                 
%                 alpha = 0.5;
%                 obj.background = alpha*bg + (1-alpha)*xxlab(:,:,1) + bgNOT;
% 
%                 
%                 obj.frames{1} = xxlab(:,:,1);
%                 
%                 
%                 
% 
%                 videoFrame1(repmat(BW,[1, 1, 3]))=0;
%                 
%                 % Insert a bounding box around the object being tracked
%                 videoOut = insertObjectAnnotation(videoFrame1,'rectangle',bbox,'Face');
                
                % Display the annotated video frame using the video player object
                videoOut = insertObjectAnnotation(bb,'rectangle',BBOX,'Skin');
                step(videoPlayer, imfuse(obj.frame,videoOut,'montage'));
                %                 step(videoPlayer, videoFrame);
                %                 imshow(bw,[]);
                %                 drawnow;
                
            end
            
            % Release resources
            release(videoFileReader);
            release(videoPlayer);
        end
        function myimage = showLABColor(obj,ch)
            L = 50*ones(201);
            a = repmat(-100:100,[201 1]);
            b = -a';
            LAB(:,:,1)=L;
            LAB(:,:,2)=a;
            LAB(:,:,3)=b;
            myimage = lab2rgb(LAB);
            if isempty(ch)
                ch = [4 40 -100 10 ];
            end
            myimage = insertObjectAnnotation(myimage,'rectangle',[100+ch(1) 100+ch(3) ch(2)-ch(1) ch(4)-ch(3)],'Skin');
        end
        function myimage = showWBSColor(obj)
%             https://web.stanford.edu/~sujason/ColorBalancing/grayworld.html
%             https://en.wikipedia.org/wiki/Standard_illuminant
            myimage =zeros([201,201,3,9]);
            for i=1:9
                L = 50*ones(201);
                a = repmat(-100:100,[201 1]);
                b = -a';
                LAB(:,:,1)=L;
                LAB(:,:,2)=a;
                LAB(:,:,3)=b;
                myimage(:,:,:,i) = lab2rgb(LAB, 'WhitePoint', lab2xyz([100 0 (-100+20*i)]));
%                 if isempty(ch)
%                     ch = [4 40 -100 10 ];
%                 end
%                 myimage = insertObjectAnnotation(myimage,'rectangle',[100+ch(1) 100+ch(3) ch(2)-ch(1) ch(4)-ch(3)],'Skin');
            end
            montage(myimage);
        end
        function makeQuadBlocks(obj)
            S = qtdecomp(obj.labframe(:,:,3),10);
            blocks = repmat(uint8(0),size(S));
            for dim = [512 256 128 64 32 16 8 4 2 1];
                numblocks = length(find(S==dim));
                if (numblocks > 0)
                    values = repmat(uint8(1),[dim dim numblocks]);
                    values(2:dim,2:dim,:) = 0;
                    blocks = qtsetblk(blocks,S,dim,values);
                end
            end
            
            blocks(end,1:end) = 1;
            blocks(1:end,end) = 1;
            
            imshowpair(obj.labframe(:,:,1),blocks,'montage')
        end
        
        function makeMeasurements(obj,BW,I,mI)
            s = regionprops(BW, I, {'Centroid','WeightedCentroid','PixelValues','BoundingBox'});
%             s = obj.regions;
            imshow(mI)
            title('Weighted (red) and Unweighted (blue) Centroids');
            hold on
            numObj = numel(s);
            for k = 1 : numObj
                s(k).StandardDeviation = std(double(s(k).PixelValues));
                text(s(k).Centroid(1),s(k).Centroid(2), ...
                    sprintf('%2d %2.1f', k, s(k).StandardDeviation), ...
                    'EdgeColor','b','Color','r');
                plot(s(k).WeightedCentroid(1), s(k).WeightedCentroid(2), 'r*');
                rectangle('LineWidth',4,'EdgeColor','red','Position',(s(k).BoundingBox));
                plot(s(k).Centroid(1), s(k).Centroid(2), 'bo');
            end
            figure
            bar(1:numObj,[s.StandardDeviation]);
            xlabel('Region Label Number');
            ylabel('Standard Deviation');
            hold off
        end
        function squareImage = makeSquare(obj)
            N = pow2(floor(log2 (max(size(obj.frame))))); 
            squareImage=uint8(zeros(N,N,3)); 
            xx1 = imresize(obj.frame,[NaN,N]);
            squareImage(1:size(xx1,1),1:N,:)=xx1;
            
%             imshow(squareImage);
        end
        function sayHello(obj)
            disp('Hello');
        end
  
    end
    
    
end

