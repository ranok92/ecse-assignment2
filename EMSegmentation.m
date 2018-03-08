function [updated_labels] = EMSegmentation(feature_matrix, no_of_classes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%the initial parameters
[ mew , sigma , weights ] = initialParameters(feature_matrix,no_of_classes);
current_labels = ones(size(feature_matrix,1),no_of_classes);
updated_labels = zeros(size(current_labels));
total = size(current_labels,1);

% mew = dimension of feature space * no of classes

% sigma = dimension of feature space * dimension of feature space * no of
% classes

%weights = no of classes * 1

%updated_labels = no of feature points x no of classes
    

    disp("sigma");
    disp(sigma);
    

    disp("weights");
    disp(weights);
iterator = 0;
while(sum(sum(updated_labels==current_labels))~= total)
    
   if (mod(iterator,50)==0)
        disp(iterator);
        disp("%%%%%%%%%");
        disp("sigma");
        disp(sigma);
        disp("weights");
        disp(weights);
        disp("means");
        disp(mew);
        disp(sum(sum(updated_labels==current_labels)));
        xaxis = linspace(1,255);
        figure;
        plot(mvnpdf(xaxis',mew(:,1)',sigma(:,:,1)));hold on;
        plot(mvnpdf(xaxis',mew(:,2)',sigma(:,:,2)));
        plot(mvnpdf(xaxis',mew(:,3)',sigma(:,:,3)));
        plot(mvnpdf(xaxis',mew(:,4)',sigma(:,:,4)));
        pause;
        close all;
    end
    
    
    
    iterator = iterator+1;
    current_labels = updated_labels;
    %The Expectation step
    for i = 1:no_of_classes
        class_mu = mew(:,i)';%class_mu has a dimension of 1x2
        class_sigma = sigma(:,:,i);
        updated_labels(:,i) = mvnpdf(feature_matrix,class_mu,class_sigma);
    end
    %disp("The labels");
    %disp(updated_labels(1:30,:));
    updated_labels = updated_labels.*(weights');
    updated_labels = updated_labels./sum(updated_labels,2);
    %disp("The labels");
    %disp(updated_labels(1:30,:));
    
    %The Maximization step
    
    %update the weights of the classes
    weights = sum(updated_labels,1)./size(updated_labels,1);
    weights = weights/sum(weights); %added this line to keep the sum to 1 not provided in the slides
    weights = weights';
    %update the mean of the classes
    for i=1:no_of_classes
        mew(:,i) = sum(feature_matrix.*updated_labels(:,i))/sum(updated_labels(:,i));
    end
    
    %update the sigma of the classes
    for j = 1:no_of_classes
        diff_mat = feature_matrix-mew(:,j)'; %here mew(:,j)' is of size 1 x dimension of feature space
        %diff_mat has dimensions  m x dimension of feature space
        sigma_sum = zeros(size(diff_mat,2)); % sigma matrix should be a square matrix with dimension = dimension of the feature space
        for i = 1:size(feature_matrix,1) %looping over all the features
            temp_sigma = diff_mat(i,:)*diff_mat(i,:)';
            sigma_sum = sigma_sum + temp_sigma.*updated_labels(i,j);
        end
        sigma(:,:,j) = sigma_sum./sum(updated_labels(:,j));
    end

end
    
    
    

end

