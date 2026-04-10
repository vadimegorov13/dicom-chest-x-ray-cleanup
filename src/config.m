function cfg = config()
    % High-level configuration for DICOM cleanup demo

    % Paths
    cfg.rootPath = fullfile('.');
    cfg.dataPath = fullfile('data', 'MIDRC-RICORD-1c-manifest-Jan-2021', 'midrc_ricord_1c');
    cfg.outputPath = fullfile(cfg.rootPath, 'processed_output');
    
    % Subject selection:
    % If empty, process all detected subjects
    cfg.subjectIDs = { ...
        'MIDRC-RICORD-1C-419639-000025', ...
        'MIDRC-RICORD-1C-419639-000214' ...
    };
    
    
    % For each subject, choose which image indices to process.
    % Example: cfg.subjectImageIndices.('MIDRC_RICORD_1C_419639_000025') = [1 2];
    % If a subject is not listed here, the script will use the first cfg.defaultNumImagesPerSubject images for that subject.

    cfg.defaultNumImagesPerSubject = 2;

    % Subject field names cannot contain '-', replace with '_'
    cfg.subjectImageIndices = struct();
    cfg.subjectImageIndices.MIDRC_RICORD_1C_419639_000025 = [1 2];
    cfg.subjectImageIndices.MIDRC_RICORD_1C_419639_000214 = [1 2];
    
    
    cfg.filePattern = '*.dcm';
    
    % Cleanup settings
    cfg.cleanup.useMedianFilter = true;      % true, false
    % Apply median filtering for basic denoising.
    % Good for small speckle noise and salt-and-pepper-like noise.
    
    cfg.cleanup.medianKernel = [3 3];        % [3 3], [5 5], [7 7]
    % Neighborhood size for the median filter.
    % Larger kernel = stronger denoising, but can remove more detail.
    
    cfg.cleanup.useGaussianFilter = false;   % true, false
    % Apply Gaussian smoothing after/beside median filtering.
    % Useful for soft noise reduction, but too much can blur edges.
    
    cfg.cleanup.gaussianSigma = 0.8;         % 0.5, 0.8, 1.0, 1.5
    % Strength of Gaussian blur.
    % Higher sigma = smoother image, but more blur.
    
    cfg.cleanup.useAdaptiveHistEq = true;    % true, false
    % Apply adaptive histogram equalization (CLAHE).
    % Improves local contrast and can make structures more visible.
    
    cfg.cleanup.clipLimit = 0.01;            % 0.005, 0.01, 0.02, 0.03
    % Contrast enhancement strength for CLAHE.
    % Lower = more subtle, higher = stronger local contrast boost.
    
    cfg.cleanup.useSharpen = true;           % true, false
    % Apply sharpening after denoising and contrast enhancement.
    % Can make edges look clearer, but too much may create artifacts.
    
    cfg.cleanup.sharpenRadius = 1.0;         % 0.5, 1.0, 1.5, 2.0
    % Radius of sharpening effect.
    % Larger radius affects wider edge regions.
    
    cfg.cleanup.sharpenAmount = 0.6;         % 0.2, 0.4, 0.6, 0.8, 1.0
    % Strength of sharpening.
    % Higher = crisper result, but too high can look artificial.
    
    % Save settings
    cfg.saveIndividualStages = true;
    cfg.saveComparisonMontage = true;
    cfg.savePipelineFigure = true;
end