function result = process_dicom_image(filePath, cfg)
    % Read one DICOM image, apply cleanup pipeline, and return all stages
    
    info = dicominfo(filePath);
    img = dicomread(info);
    
    img = squeeze(img);
    img = mat2gray(double(img));
    
    if isfield(info, 'PhotometricInterpretation')
        if strcmp(info.PhotometricInterpretation, 'MONOCHROME1')
            img = imcomplement(img);
        end
    end
    
    imgDenoised = img;
    
    if cfg.cleanup.useMedianFilter
        imgDenoised = medfilt2(imgDenoised, cfg.cleanup.medianKernel);
    end
    
    if cfg.cleanup.useGaussianFilter
        imgDenoised = imgaussfilt(imgDenoised, cfg.cleanup.gaussianSigma);
    end
    
    imgEnhanced = imgDenoised;
    
    if cfg.cleanup.useAdaptiveHistEq
        imgEnhanced = adapthisteq(imgEnhanced, 'ClipLimit', cfg.cleanup.clipLimit);
    end
    
    imgClean = imgEnhanced;
    
    if cfg.cleanup.useSharpen
        imgClean = imsharpen( ...
            imgClean, ...
            'Radius', cfg.cleanup.sharpenRadius, ...
            'Amount', cfg.cleanup.sharpenAmount ...
        );
    end
    
    result.filePath = filePath;
    result.info = info;
    result.original = img;
    result.denoised = imgDenoised;
    result.enhanced = imgEnhanced;
    result.cleaned = imgClean;
end