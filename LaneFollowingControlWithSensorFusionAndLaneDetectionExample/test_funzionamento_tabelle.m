sz = [3 3];
varTypes = ["string", "string", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames)

Results_Table(1,:)={"Ciao","Ciao",25};

Results_Table