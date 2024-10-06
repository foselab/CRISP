
%% SIMCONFIG. Prendo il test assessment
%assSet = sltest.getAssessments(modelName); 
%as = get(assSet, 1);
%testAssessmentPath = string(as.BlockPath.getBlock(1));
% in realtà questo comando mi da un indirizzo sbagliato, quindi nella
% GETALLSTEPS ho inserito manuamente il percorso per il test assessment

%% GETALLSTEPS
AssessmentScenario = "Scenario_1";
assessmentPath = "LFRefMdl/Test Assessment";
stepTableTA = getAllSteps(AssessmentScenario, assessmentPath);
stepTableTA = sortAss(stepTableTA,[],[], AssessmentScenario);
[stepTableTA, fitTable] = getFit(stepTableTA);
transTable = getAllTrans(stepTableTA,assessmentPath);
buildTransitionMap(assessmentPath, stepTableTA, transTable, fitTable);



