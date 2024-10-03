
modelName = "LaneFollowingTestBenchExample"; 
%% SIMCONFIG. Prendo il test assessment
assSet = sltest.getAssessments(modelName); 
as = get(assSet, 1);
testAssessmentPath = string(as.BlockPath.getBlock(1));
% in realtà questo comando mi da un indirizzo sbagliato, quindi nella
% GETALLSTEPS ho inserito manuamente il percorso per il test assessment

%% GETALLSTEPS
stepTable = getAllSteps('Scenario_1', 'LFRefMdl/Test Assessment');
stepTable = sortAss(stepTable,[],[],'Scenario_1');
[stepTable, fitTable] = getFit(stepTable);
transTable = getAllTrans(stepTable,'LFRefMdl/Test Assessment');
buildTransitionMap('LFRefMdl/Test Assessment', stepTable, transTable, fitTable);



