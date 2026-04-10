function save_result_images(result, outFolder, baseName, imageLabel, cfg)
    % Save processed images and comparison figures
    
    if ~exist(outFolder, 'dir')
        mkdir(outFolder);
    end
    
    if cfg.savePipelineFigure
        fig1 = figure('Visible', 'off');
        subplot(2,2,1);
        imshow(result.original, []);
        title('Original');
    
        subplot(2,2,2);
        imshow(result.denoised, []);
        title('Denoised');
    
        subplot(2,2,3);
        imshow(result.enhanced, []);
        title('Contrast Enhanced');
    
        subplot(2,2,4);
        imshow(result.cleaned, []);
        title('Final Cleaned');
    
        sgtitle(imageLabel, 'Interpreter', 'none');
    
        exportgraphics(fig1, fullfile(outFolder, [baseName '_pipeline.png']));
        close(fig1);
    end
    
    if cfg.saveIndividualStages
        imwrite(result.original, fullfile(outFolder, [baseName '_original.png']));
        imwrite(result.denoised, fullfile(outFolder, [baseName '_denoised.png']));
        imwrite(result.enhanced, fullfile(outFolder, [baseName '_enhanced.png']));
        imwrite(result.cleaned, fullfile(outFolder, [baseName '_cleaned.png']));
    end
    
    if cfg.saveComparisonMontage
        fig2 = figure('Visible', 'off');
        imshowpair(result.original, result.cleaned, 'montage');
        title(sprintf('%s - Original vs Cleaned', imageLabel), 'Interpreter', 'none');
    
        exportgraphics(fig2, fullfile(outFolder, [baseName '_comparison.png']));
        close(fig2);
    end
end