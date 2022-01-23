function [] = saveHOGdescriptor()
    % Setting the directory for the training dataset
    dir = fullfile('Dataset');
    set = imageDatastore(dir,'IncludeSubfolders',true,'LabelSource','foldernames');

    % Declaring sizes and variables
    cellSize = [16 16];

    % Declaring sizes and variables
    img = readimage(set, 1);
    [hog_, ~] = extractHOGFeatures(img,'CellSize',cellSize);
    
    hogFeatureSize = length(hog_);
    
    sizeSet = numel(set.Files);
    trainingFeaturesHOG = zeros(sizeSet,hogFeatureSize,'single');
    
    % Extracting the HOG and LBP features for each image
    for i = 1:sizeSet
        img = readimage(set,i);
        img = im2gray(img);
        trainingFeaturesHOG(i, :) = extractHOGFeatures(img,'CellSize',cellSize); 
    end

    % Get labels for each image
    labels = grp2idx(set.Labels);
    
    % Join train features and labels
    labeledFeaturesHOG = [trainingFeaturesHOG labels];
    
    % Saves the matrix as a csv file
    csvwrite('Dataset/labeledFeaturesHOG.csv',labeledFeaturesHOG);
end