function som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
    [M,N] = size(trainingData);
    weightmatrix = randn(neuronCount,N);
   
    for t=0:trainingSteps
        ita = startLearningRate*exp(-t/1000);
        sigma = startRadius*exp(-t/(1000/log(startRadius)));
        i = randi(M);
        dist = sqrt(sum((weightmatrix-repmat(trainingData(i,:),neuronCount,1)).^2,2));
        [dist_array,index] = sort(dist);
        wj = weightmatrix(index(1),:);
%         neighbor = (index(1)-fix(sigma)):(index(1)+fix(sigma));
%         neighbor = neighbor';
%         if neighbor(end)>neuronCount neighbor = neighbor(1:size(neighbor)-neighbor(end)+neuronCount);end
%         if neighbor(1)<1 neighbor = neighbor((2-neighbor(1)):size(neighbor));end
%         for j=neighbor(1):neighbor(end)
%             h = exp(-eucdist(wj,weightmatrix(j,:))/(2*sigma^2));
%             weightmatrix(j,:) = weightmatrix(j,:) + ita*h*(trainingData(i,:)-weightmatrix(j,:));
%         end
        for j=1:neuronCount
             d = abs(index(1)-j);
             h = exp(-d^2/(2*sigma^2));
             weightmatrix(j,:) = weightmatrix(j,:) + ita*h*(trainingData(i,:)-weightmatrix(j,:));
        end
    end
    som = weightmatrix;
end

% som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 1D SOM i.e. A SOM where the neurons are arranged
%             in a single line. 
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <neuronCount> number of neurons 
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size

% TODO:
% The student will need to complete this function so that it returns
% a matrix 'som' containing the weights of the trained SOM.
% The weight matrix should be arranged as follows, where
% N is the number of features and M is the number of neurons:
%
% Neuron1_Weight1 Neuron1_Weight2 ... Neuron1_WeightN
% Neuron2_Weight1 Neuron2_Weight2 ... Neuron2_WeightN
% ...
% NeuronM_Weight1 NeuronM_Weight2 ... NeuronM_WeightN
%
% It is important that this format is maintained as it is what
% lab_vis(...) expects.
%
% Some points that you need to consider are:
%   - How should you randomise the weight matrix at the start?
%   - How do you decay both the learning rate and radius over time?
%   - How does updating the weights of a neuron effect those nearby?
%   - How do you calculate the distance of two neurons when they are
%     arranged on a single line?
