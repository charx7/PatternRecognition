% Clean outputs
clc;
clear;

% Prior of receiving Spam
priorSpam = 0.9;

% Prior Not receiving spam
priorNotSpam = 0.1;

% Variables dump
antiAgingSpam = 0.00062;
antiAgingNotSpam = 0.000000035;

customersSpam = 0.005;
customersNotSpam = 0.0001;

funSpam = 0.00015;
funNotSpam = 0.0007;

groningenSpam = 0.00001;
groningenNotSpam = 0.001;

lectureSpam = 0.000015;
lectureNotSpam = 0.0008;

moneySpam = 0.002;
moneyNotSpam = 0.0005;

vacationSpam = 0.00025;
vacationNotSpam = 0.00014;

viagraSpam = 0.001;
viagraNotSpam = 0.0000003;

watchesSpam = 0.0003;
watchesNotSpam = 0.000004;

% prob of “We offer our dear customers a wide selection of classy watches.”
% being spam

probSpam = customersSpam * watchesSpam * priorSpam;
probNotSpam = customersNotSpam * watchesNotSpam * priorNotSpam;

probRatio = probSpam / probNotSpam;

fprintf('The probability of Spam is: \n');
disp(probSpam);
fprintf('The probability of not Spam is: \n');
disp(probNotSpam);

fprintf('The ration of spam to Not spam is: \n');
disp(probRatio);

disp('The other phrase');

probSpam = funSpam * vacationSpam * priorSpam;
probNotSpam = funNotSpam * vacationNotSpam * priorNotSpam;

probRatio = probSpam / probNotSpam;

fprintf('The probability of Spam is: \n');
disp(probSpam);
fprintf('The probability of not Spam is: \n');
disp(probNotSpam);

fprintf('The ration of spam to Not spam is: \n');
disp(probRatio);
