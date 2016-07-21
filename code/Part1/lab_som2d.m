function [som,grid] = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
    [M,N] = size(trainingData);
    weightmatrix = randn(neuronCountH*neuronCountW,N);
    k=1;
    for i=1:neuronCountW
        for j=1:neuronCountH
            grid(k,:) = [i,j];
            k=k+1;
        end
    end
    for t=0:trainingSteps
        ita = startLearningRate*exp(-t/1000);
        sigma = startRadius*exp(-t/(1000/log(startRadius)));
        i = randi(M); 
        dist = sqrt(sum((weightmatrix-repmat(trainingData(i,:),neuronCountH*neuronCountW,1)).^2,2));
        [dist_array,index] = sort(dist);
        wj = weightmatrix(index(1),:);

        for j=1:neuronCountH*neuronCountW
                d = eucdist(grid(index(1),:),grid(j,:));
                h = exp(-d^2/(2*sigma^2));
                weightmatrix(j,:) = weightmatrix(j,:) + ita*h*(trainingData(i,:)-weightmatrix(j,:));
        end
%         lab_vis2d(weightmatrix,grid,trainingData);
    end
    som = weightmatrix;
end
% som = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 2D SOM, which consists of a grid of
%             (neuronCountH * neuronCountW) neurons.
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <grid> returns the location of the neurons in the grid
% -- <neuronCountW> number of neurons along width
% -- <neuronCountH> number of neurons along height
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size
%

% TODO:
% The student will need to copy their code from lab_som() and
% update it so that it uses a 2D grid of neurons, rather than a 
% 1D line of neurons.
% 
% Your function will still return the a weight matrix 'som' with
% the same format as described in lab_som().
%
% However, it will additionally return a vector 'grid' that will
% state where each neuron is located in the 2D SOM grid. 
% 
% grid(n, :) contains the grid location of neuron 'n'
%
% For example, if grid = [[1,1];[1,2];[2,1];[2,2]] then:
% 
%   - som(1,:) are the weights for the neuron at position x=1,y=1 in the grid
%   - som(2,:) are the weights for the neuron at position x=2,y=1 in the grid
%   - som(3,:) are the weights for the neuron at position x=1,y=2 in the grid 
%   - som(4,:) are the weights for the neuron at position x=2,y=2 in the grid
%
% It is important to return the grid in the correct format so that
% lab_vis2d() can render the SOM correctly

