modelName = "LaneFollowingTestBenchExample"; 
assSet = sltest.getAssessments(modelName); 
as = get(assSet, 1);
testAssessmentPath = string(as.BlockPath.getBlock(1));

stepTable = getAllSteps("LaneFollowingTestBenchExample", testAssessmentPath); 
