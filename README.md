# DICOM Chest X-Ray Cleanup in MATLAB

## Description

This is a MATLAB preprocessing pipeline for DICOM chest X-ray images. The pipeline reads DICOM files, extracts image metadata, applies a cleanup, and saves the generated outputs for visual comparison. The main goal is to improve image quality in a simple and reproducible way.

### What the pipeline does

For each selected DICOM image:

- read the DICOM image and metadata
- normalize the image for processing and display
- reduce noise using median filtering
- optionally apply Gaussian smoothing
- improve local contrast using adaptive histogram equalization
- optionally sharpen the final image
- save all generated stages for comparison

### Processing stages

The saved outputs can include:

- **Original** — the source image loaded from the DICOM file
- **Denoised** — the image after noise reduction
- **Enhanced** — the image after local contrast improvement
- **Cleaned** — the final processed result
- **Pipeline figure** — a multi-panel summary showing the main stages
- **Comparison figure** — a side-by-side view of original vs cleaned image

### Configurable processing options

The cleanup pipeline is configurable through the **config.m** file.

The current implementation supports the following options:

- **Median filter**
  - used for basic denoising
  - configurable kernel size

- **Gaussian filter**
  - optional smoothing step
  - useful for reducing softer noise patterns
  - configurable sigma value

- **Adaptive histogram equalization**
  - improves local contrast
  - helps make images easier to see
  - configurable clip limit

- **Sharpening**
  - enhances edges after denoising and contrast adjustment
  - configurable radius and amount

### Subject and image selection

The project is designed so that processing does not have to be done on all files at once. Instead, the config file allows the user to:

- choose specific subject IDs
- choose specific image indices for each subject
- control how many images are processed by default

## Requirments

- MATLAB
- Image Processing Toolbox Add-on in MATLAB
- NBIA Data Retriever for downloading the dataset
- DICOM chest X-ray data from **TCIA**

## Dataset

This project uses the **MIDRC-RICORD-1C** dataset from The Cancer Imaging Archive (TCIA).

The dataset is downloaded using **NBIA Data Retriever**.

### How to Get the Data

1. Install **NBIA Data Retriever**.
2. Open the download instructions page:  
   
   link: https://wiki.cancerimagingarchive.net/display/NBIA/Downloading+TCIA+Images
3. In NBIA Data Retriever, provide the path to the manifest file (already in repo):

   `repopath/data/MIDRC-RICORD-1c-manifest-Jan-2021.tcia`

   link: https://www.cancerimagingarchive.net/collection/midrc-ricord-1c/
4. Choose the download location as:

   `repopath/data`

After download, the data folder structure should look like this:

```text
data/
    MIDRC-RICORD-1c-manifest-Jan-2021.tcia
    MIDRC-RICORD-1c-manifest-Jan-2021/
        midrc_ricord_1c/
        metadata/
```

## Usage

1. Open repo in MATLAB
2. Open run_cleanup.m
3. Click Run button

This should generate images and the folder structure would look like this:

```text
processed_output/
    run_yyyy_mm_dd_hh_mm_ss/
        MIDRC-RICORD-1C-419639-subjectId/
            img_001_pipeline.png
            ...
```

