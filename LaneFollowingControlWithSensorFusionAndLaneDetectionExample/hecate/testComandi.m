
modelName = "LaneFollowingTestBenchExample"; 
%% SIMCONFIG. Prendo il test assessment
assSet = sltest.getAssessments(modelName); 
as = get(assSet, 1);
testAssessmentPath = string(as.BlockPath.getBlock(1));
% in realtà questo comando mi da un indirizzo sbagliato, quindi nella
% GETALLSTEPS ho inserito manuamente il percorso per il test assessment

%% GETALLSTEPS
stepTable = getAllSteps('Scenario_1', 'LFRefMdl/Test Assessment'); 
[stepTableTA, fitTable] = getFit(stepTable);
