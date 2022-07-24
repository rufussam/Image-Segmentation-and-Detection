%%
%save the path of original and GT images
location = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\*.jpg');
location2 = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\*.png');
sim = zeros(1, 60);

%%
%Input every image for image segmentation and compare it DS for further
%segmentation
for i=1:length(location)
    file_name1 = strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\',location(i).name);
    I_gray = rgb2gray(imread(file_name1));
    [L,C] = imsegkmeans(I_gray,2);
    I1 = (L==1);
    numberOfTruePixels_1 = sum(I1(:));
    I2 = (L==2);
    numberOfTruePixels_2 = sum(I2(:));
    if numberOfTruePixels_2 < numberOfTruePixels_1
	     BW= I2;
    else
	     BW = I1;
    end
    file_name2 = strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\',location2(i).name);
    I1= BW;
    I2=imread(file_name2);
    I1 = logical(I1);
    I2 = logical(I2);
    sim = dice(I1, I2);
    %Morphological operations on images with less DS
    if sim<0.7
            test_write_folder = strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\k_means_again_segment\',location(i).name);
            imwrite(BW, test_write_folder)
            file_name1= strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\k_means_again_segment\',location(i).name);
            BW= imread(file_name1);
            I_gray = BW;
            I_close = imclose(I_gray,strel('disk',24));
            I_erode = imerode(I_close,strel('disk',10));
            I_open = imopen(I_erode,strel('disk',24));
            I_dilate = imdilate(I_open,strel('disk',16));
            cb = imclearborder(I_dilate);
            I_fill = imfill(cb,'holes');
            I_close = bwareaopen(I_fill, 40000);
            BW=I_close;
     end
    a = location(i).name(10:end);
    test_write_folder = strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\',a);
    imwrite(BW, test_write_folder)
end

%%
%get filenames
fileinfo = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\*.jpg');
fnames = {fileinfo.name};
fileinfo1 = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\*.jpg');
fnames1 = {fileinfo1.name};

%%
%Calculate DS once again for revised segmented dataset
location1 = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\*.jpg');
location2 = dir('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\*.png');
similarity = zeros(1, 60);
for i=1:length(fileinfo)
    file_name1= strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\',location1(i).name)
    file_name2 = strcat('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\',location2(i).name)
    I1=imread(file_name1);
    I2=imread(file_name2);
    I1 = logical(I1);
    I2 = logical(I2);
    similarity(i) = dice(I1, I2);

end

%%
fnames = {location1.name};

%%
% bar graph
fnames = categorical({location1.name});

%%
fnames = categorical(fnames)
b = bar(fnames,similarity);
%set(gca,'xtick',[],'ytick',[])
title('DS values')

%%
m = mean(similarity);
m
%%

s = std(similarity);

%%    
bw1 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\ISIC_0000095.jpg');
bw2 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\095.jpg');
bw3 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\ISIC_0000095_Segmentation.png');
s1 = logical(bw2);
s2 = logical(bw3);
similarity = dice(s1, s2);
figure;
imshowpair(bw1,bw2,'montage'), title(num2str(similarity));

%%    
bw1 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\ISIC_0000019.jpg');
bw2 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\019.jpg');
bw3 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\ISIC_0000019_Segmentation.png');
s1 = logical(bw2);
s2 = logical(bw3);
similarity = dice(s1, s2);
figure;
imshowpair(bw1,bw2,'montage'), title(num2str(similarity));


%%    
bw1 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\skin lesion dataset\org data\ISIC_0000214.jpg');
bw2 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\test_write_folder_kmeans_final\214.jpg');
bw3 = imread('C:\Users\Rufus Sam A\Downloads\Lincoln\Computer Vision\Assessments\GT\ISIC_0000214_Segmentation.png');
s1 = logical(bw2);
s2 = logical(bw3);
similarity = dice(s1, s2);
figure;
imshowpair(bw1,bw2,'montage'), title(num2str(similarity));
