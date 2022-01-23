function [] = saveLBPdescriptor()
    % Setting the directory for the training dataset
    dir = fullfile('Dataset');
    set = imageDatastore(dir,'IncludeSubfolders',true,'LabelSource','foldernames');

    % Declaring sizes and variables
    cellSize = [16 16];

    % Declaring sizes and variables
    img = readimage(set, 1);
    lbpFeatures = extractLBPFeatures(img,'CellSize',[16 16]);
    lbpFeatureSize = length(lbpFeatures);
    
    sizeSet = numel(trainingSet.Files);
    
    featuresLBP = zeros(sizeSet,lbpFeatureSize,'single');
    
    % Extracting the HOG and LBP features for each image
    for i = 1:sizeTrainingSet
        img = readimage(set,i);
        img = im2gray(img);
        featuresLBP(i, :) = extractLBPFeatures(img,'CellSize',cellSize); 
    end

    % Get labels for each image
    labels = grp2idx(trainingSet.Labels);
    
    % Join train features and labels
    labeledFeaturesLBP = [trainingFeaturesLBP labels];
    
    % Saves the matrix as a csv file
    csvwrite('Dataset/labeledFeaturesLBP.csv',labeledFeaturesLBP);
end

