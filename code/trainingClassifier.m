function [] = trainingClassifier()
    
    % Setting the directory for the training dataset
    trainingDir = fullfile('Dataset');
    trainingSet = imageDatastore(trainingDir,'IncludeSubfolders',true,'LabelSource','foldernames');
    % trainingSet
    
    % Declaring sizes and variables
    cellSize = [32 32];
    
    img = readimage(trainingSet, 1);
    [hog_, ~] = extractHOGFeatures(img,'CellSize',cellSize);
  
    hogFeatureSize = length(hog_);
  
    sizeTrainingSet = numel(trainingSet.Files);
    trainingFeatures = zeros(sizeTrainingSet,hogFeatureSize,'single');
    
    % Extracting the HOG features for each image
    for i = 1:sizeTrainingSet
        img = readimage(trainingSet,i);
        img = im2gray(img);
        trainingFeatures(i, :) = extractHOGFeatures(img,'CellSize',cellSize);  
    end

    % Get labels for each image
    trainingLabels = trainingSet.Labels;
    
    % Join train features and labels
    trainingLabels = grp2idx(trainingLabels);
    
    % Check size
    size(trainingLabels)
    size(trainingFeatures)
    
    % Concatenate label column at the end
    labeledFeatures = [trainingFeatures trainingLabels];

    % Saves the matrix as a csv file
    csvwrite('Dataset/trainLabelFeatures.csv',labeledFeatures);
    
    % Fits a SVM model
    %Classifier = fitcsvm(trainingFeatures, trainingLabels);
    
    % Saving the classifier
    %save('Dataset/eyeClass.mat', 'Classifier', '-v7.3');

end

