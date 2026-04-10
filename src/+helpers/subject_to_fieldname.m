function fieldName = subject_to_fieldname(subjectID)
    fieldName = strrep(subjectID, '-', '_');
    fieldName = matlab.lang.makeValidName(fieldName);
end