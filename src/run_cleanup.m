clc; clear; close all;

cfg = config();

runName = ['run_' datestr(now, 'yyyy_mm_dd_HH_MM_SS')];
runFolder = fullfile(cfg.outputPath, runName);

if ~exist(runFolder, 'dir')
    mkdir(runFolder);
end

subjectMap = helpers.collect_subject_files(cfg.dataPath, cfg.filePattern);
allSubjects = sort(keys(subjectMap));

fprintf('Detected %d subject(s).\n', numel(allSubjects));

if isempty(cfg.subjectIDs)
    selectedSubjects = allSubjects;
else
    selectedSubjects = cfg.subjectIDs;
end

for s = 1:numel(selectedSubjects)
    subjectID = selectedSubjects{s};

    if ~isKey(subjectMap, subjectID)
        fprintf('\nSkipping subject %s (not found).\n', subjectID);
        continue;
    end

    subjectFiles = subjectMap(subjectID);
    subjectOutputPath = fullfile(runFolder, subjectID);

    if ~exist(subjectOutputPath, 'dir')
        mkdir(subjectOutputPath);
    end

    subjectField = helpers.subject_to_fieldname(subjectID);

    if isfield(cfg.subjectImageIndices, subjectField)
        requestedImageIdx = cfg.subjectImageIndices.(subjectField);
    else
        requestedImageIdx = 1:min(cfg.defaultNumImagesPerSubject, numel(subjectFiles));
    end

    requestedImageIdx = requestedImageIdx(requestedImageIdx >= 1 & requestedImageIdx <= numel(subjectFiles));

    fprintf('\n=== SUBJECT: %s ===\n', subjectID);
    fprintf('Total files available: %d\n', numel(subjectFiles));
    fprintf('Processing image indices: %s\n', mat2str(requestedImageIdx));

    for i = 1:numel(requestedImageIdx)
        imageIdx = requestedImageIdx(i);
        imagePath = subjectFiles{imageIdx};

        try
            result = helpers.process_dicom_image(imagePath, cfg);
            info = result.info;

            fprintf('\nImage index: %d\n', imageIdx);
            fprintf('File: %s\n', imagePath);

            if isfield(info, 'PatientID')
                fprintf('PatientID: %s\n', string(info.PatientID));
            end
            if isfield(info, 'Modality')
                fprintf('Modality: %s\n', string(info.Modality));
            end
            if isfield(info, 'Rows') && isfield(info, 'Columns')
                fprintf('Size: %d x %d\n', info.Rows, info.Columns);
            end

            baseName = sprintf('img_%03d', imageIdx);
            imageLabel = sprintf('%s - image %d', subjectID, imageIdx);

            helpers.save_result_images(result, subjectOutputPath, baseName, imageLabel, cfg);

        catch ME
            fprintf('Failed to process file %s\n', imagePath);
            fprintf('Reason: %s\n', ME.message);
        end
    end
end

fprintf('\nDone.\nRun output folder:\n%s\n', runFolder);