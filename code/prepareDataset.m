function [] = prepareDataset()
    clc;
    clear;
    
    dirEyes = dir('DataFaces/outEyes/*.jpg');
    dirNoEyes = dir('DataFaces/outNoEyes/*.jpg');
    
    numEyeStrips = length(dirEyes);
    numNoEyeStrips = length(dirNoEyes);
    
    eyeStripMat = zeros([90,450,numEyeStrips]);
    neyeStripMat = zeros([90,450,numNoEyeStrips]);
    
    for i = 1:numEyeStrips
        currentFilename = dirEyes(i).name;
        Im = rgb2gray(imread(['DataFaces/outEyes/' currentFilename]));
        if i == 1 
            imshow(Im);
        eyeStripMat(:,:,i) = Im;
    end
    
    for i = 1:numNoEyeStrips
        currentFilename = dirNoEyes(i).name;
        Im = rgb2gray(imread(['DataFaces/outNoEyes/' currentFilename]));
        neyeStripMat(:,:,i) = Im;
    end
    
    trainingEyes = eyeStripMat(:,:,1:(numEyeStrips*0.9));
    trainingNotEyes = neyeStripMat(:,:,1:(numNoEyeStrips*0.9));
    
    testingEyes = eyeStripMat(:,:,(numEyeStrips*0.9+1):end);
    testingNotEyes = neyeStripMat(:,:,(numNoEyeStrips*0.9+1):end); 

    % save to file
    save('DataFaces/trainData.mat', 'trainingEyes','trainingNotEyes','-v7.3');
    save('DataFaces/testData.mat', 'testingEyes','testingNotEyes','-v7.3');
    
    end