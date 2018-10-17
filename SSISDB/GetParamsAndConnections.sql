USE SSISDB;

SELECT pr.name AS projectName, pr.project_id, pr.folder_id, 
CASE 
	WHEN par.object_type = 20 THEN 'Project'
	WHEN par.object_type = 30 THEN 'Package'
END AS level,
CASE 
	WHEN par.parameter_name LIKE 'CM.%' THEN 'Connection Manager'
    ELSE 'Parameter'     
END as type , 
par.parameter_name AS parameterName, 
par.parameter_data_type AS parameterDataType,
CASE
	WHEN par.referenced_variable_name IS NOT NULL THEN 1
	ELSE 0
END AS hasEnvironmentalVariable,
par.referenced_variable_name AS environmentalVariableName
FROM internal.projects pr
JOIN internal.object_parameters par ON par.project_id = pr.project_id
WHERE pr.project_id = 17 --OR change to pr.name = '' to get differernt projects
;
