function subjectMap = collect_subject_files(dataPath, filePattern)
    % Collect DICOM files grouped by subject folder name
    
    files = dir(fullfile(dataPath, '**', filePattern));
    files = files(~[files.isdir]);
    
    subjectMap = containers.Map('KeyType', 'char', 'ValueType', 'any');
    
    for k = 1:numel(files)
        fullPath = fullfile(files(k).folder, files(k).name);
    
        % Find subject folder from path
        parts = strsplit(files(k).folder, filesep);
    
        subjectID = '';
        for p = 1:numel(parts)
            if startsWith(parts{p}, 'MIDRC-RICORD-1C-')
                subjectID = parts{p};
                break;
            end
        end
    
        if isempty(subjectID)
            continue;
        end
    
        if ~isKey(subjectMap, subjectID)
            subjectMap(subjectID) = {fullPath};
        else
            subjectMap(subjectID) = [subjectMap(subjectID), {fullPath}];
        end
    end
    
    % Sort file lists for stable ordering
    keysList = keys(subjectMap);
    for i = 1:numel(keysList)
        sid = keysList{i};
        fileList = subjectMap(sid);
        fileList = sort(fileList);
        subjectMap(sid) = fileList;
    end
end