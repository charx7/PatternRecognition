clear

%create test set indices for Class A
SetAIndices = [];
List = linspace(1,100);

while size(SetAIndices,1) < 10 
    candidateIndices = datasample(List,10,'Replace', false);
    [Indx, ~] = ismember(List,candidateIndices);
    List(Indx) = [];
    SetAIndices = [SetAIndices;candidateIndices];
end


%create test set indices for Class B
SetBIndices = [];
List = linspace(101,200);

while size(SetBIndices,1) < 10 
    candidateIndices = datasample(List,10,'Replace', false);
    [Indx, ~] = ismember(List,candidateIndices);
    List(Indx) = [];
    SetBIndices = [SetBIndices;candidateIndices];
end


%create random row numbers to choose from set A
randomRowNumbersForSetA = randperm(10);
randomRowNumbersForSetB = randperm(10);

%create random test sets using random row numbers and setA and setB indices
allTestSets=[];
for i=1:10
   currentTestSetIndices = [SetAIndices(randomRowNumbersForSetA(i), :) SetBIndices(randomRowNumbersForSetB(i), :)];
   allTestSets = [allTestSets ; currentTestSetIndices ];
end

tenDisjointSets = allTestSets;

tenDisjointSets
