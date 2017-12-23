classdef RoboNouMiChiClassOc < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        filename
        Property1
        frame
        labframe
        background
        frames = {};
        videoPlayer 
        videoReader 
        videoWriter 
        peopleDetector
        labImage
        gaborX
        gabor
        BW
        maskedSegmentedImage
        montage = {}
        superpix = {}
%         objects = ManavYantraClass(1,2)
        profile
        profiling = true;
        tracks
        colors = {}
        regions
    end
    
    methods
        function obj = RoboNouMiChiClassOc(inputArg1,inputArg2)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            %             obj.Property1 = inputArg1 + inputArg2;
            % %             obj.videoPlayer = vision.DeployableVideoPlayer;
            % %             obj.videoReader = vision.VideoFileReader;
            % %             obj.videoWriter = vision.VideoFileWriter;
            % %             obj.peopleDetector = vision.PeopleDetector();
            % J = imread('JapaneseMen.jpeg');
            % J = imread('IMG_1106.jpg');
            % J = imread('Japanese3.jpeg');
            %             obj.frame = imread('visionteam1.jpg');
            
            obj.colors.skin.african = [10 50 0 5 5 40];
            obj.colors.skin.asian = [0 100 0 40 3 50];
            obj.colors.skin.white = [30 100 5 25 -25 6];
            obj.colors.glassbottle.brown = [10 90 3 50 3 50];
            
        end
        
        function [BW,maskedRGBImage] = createMask(obj,op)
            %createMask  Threshold RGB image using colorThresholder.
            %  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
            %  colorThresholder. The colorspace and
            %  range for each channel of the colorspace were set in channel. The
            %  segmentation mask is returned in BW, and a composite of the mask and
            %  original RGB images is returned in maskedRGBImage.
            %------------------------------------------------------
            
            % Convert RGB image to chosen color space. frame and labframe
            % already have the rgb and lab images
            
            if isempty(op.kmeans)
                BW = zeros(size(obj.labframe(:,:,1)));
            else
                
                sz = size(obj.labframe);
                im = single(reshape(obj.labframe,sz(1)*sz(2),[]));
                im = im - mean(im);
                im = im ./ std(im);
                s = rng;
                rng('default');
                L = kmeans(im,2,'Replicates',2);
                rng(s);
                BW = L == 2;
                BW = reshape(BW,[sz(1) sz(2)]);
            end
            
            
            
            for ii=1:length(op.channels)
                channel = op.channels{ii};
                % Create mask based on chosen histogram thresholds
                sliderBW = (obj.labframe(:,:,1) >= channel(1) ) & (obj.labframe(:,:,1) <= channel(2)) & ...
                    (obj.labframe(:,:,2) >= channel(3) ) & (obj.labframe(:,:,2) <= channel(4)) & ...
                    (obj.labframe(:,:,3) >= channel(5) ) & (obj.labframe(:,:,3) <= channel(6));
                BW = BW | sliderBW;
                
                
            end
            if ~isempty (op.open)
                BW = bwareaopen(BW, open);
            end
            
            
            if ~isempty(op.regions)
                %                         Determine the connected components:
                CC = bwconncomp(BW, 4);
                %             Compute the area of each component:
                S = regionprops(CC, obj.labframe(:,:,1),'Area', 'Orientation','MajorAxisLength','MinorAxisLength','Centroid','WeightedCentroid','Eccentricity','Extent','Extrema','FilledImage','FilledImage','Perimeter','EquivDiameter','BoundingBox','PixelValues');
                %             Remove small objects:
                L = labelmatrix(CC);
                BW = ismember(L, find([S.Area] >= op.regions.minArea)) & ismember(L, find([S.Area] <= op.regions.maxArea)) & ismember(L, find([S.Orientation] < op.regions.maxOrientation)) & ismember(L, find([S.Orientation] > op.regions.minOrientation)) & ismember(L, find([S.MajorAxisLength] > op.regions.minMajorAxisLength));
                %             BW = ismember(L, find([S.Eccentricity] > 0.05)) ;
                obj.regions = S;
            end
            
            if ~isempty(op.majority)
                
                BW = bwmorph(BW,'majority', majority);
                % Initialize output masked image based on input image.
                
            end
            
            if ~isempty(op.fill)
                % 穴の塗りつぶし
                BW = imfill(BW, 'holes');
                
            end
            
            if ~isempty(op.contours)
                % 動的輪郭
                iterations = 100;
                BW = activecontour(obj.labframe, BW, iterations, 'Chan-Vese');
                
            end
            maskedRGBImage = obj.frame;
            % Set background pixels where BW is false to zero.
            maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
            
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
        
        function setFrame(obj,frame)
            obj.frame = frame;
            obj.labframe = rgb2lab(frame);
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
        
        
        function s = makeMovieFromFile(obj,filename)
            vidObj = VideoReader(filename);
            vidHeight = vidObj.Height;
            vidWidth = vidObj.Width;
            s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
                'colormap',[]);
            k = 1;
            while hasFrame(vidObj)
                s(k).cdata = readFrame(vidObj);
                k = k+1;
            end
            image(s(5).cdata)
            set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
            set(gca,'units','pixels');
            set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
            movie(s,1,vidObj.FrameRate);
            
        end
        
        function showProcessedFrames(obj,frames,scale)
            for i=1:length(frames)
                obj.setFrame(imresize(frames(:,:,:,i),scale));
                [aa,bb]=obj.createMask({obj.colors.skin.asian},100,Inf);
                imshowpair(obj.frame,bb,'montage');
                drawnow;
            end
        end
        
        function showProcessedFrames1(obj,frames,scale)
            for i=1:length(frames)
                xxlab=rgb2lab(imresize(frames(i).cdata,scale));
                imshow(imquantize(xxlab(:,:,2),[4 30]),[]);
                drawnow;
            end
        end
        
        function out = prepLab(obj,in)
            
            % Convert L*a*b* image to range [0,1]
            out = in;
            out(:,:,1)   = in(:,:,1) / 100;  % L range is [0 100].
            out(:,:,2:3) = (in(:,:,2:3) + 100) / 200;  % a* and b* range is [-100,100].
            
        end
        
    end
    
end

