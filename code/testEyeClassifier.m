function [] = testEyeClassifier()
    
    eyeClassifier = matfile('DataFaces/eyeClass.mat');

    testData = matfile('DataFaces/testData.mat');
    testDataEye = testData.testingEyes;
    testDataNotEye = testData.testingNotEyes;
    
    numDataEye = length(testDataEye);
    numDataNotEye = length(testDataNotEye);
    numFeatures = length(extractHOGFeatures(testDataEye(:,:,1)));
    
    featuresData = zeros(numDataEye+numDataNotEye, numFeatures);
    
    for i = 1:numDataEye
        currIm = testDataEye(:,:,i);
        imshow(currIm);
        featuresData(i,:) = extractHOGFeatures(currIm);
    end
    
    for i = (numDataEye+1):(numDataNotEye)
        currIm = testDataNotEye(:,:,i-numDataEye);
        featuresData(i,:) = extractHOGFeatures(currIm);
    end
    
    [label, score] = predict(eyeClassifier.eyeClass, featuresData);
    T = table(eyeClassifier.ClassNames,label,max(score,[],2),'VariableNames',{'Name','Label','Score'});
    T

end

