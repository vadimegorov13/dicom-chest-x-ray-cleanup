# DICOM Chest X-Ray Cleanup in MATLAB

## Description

This project demonstrates a simple MATLAB pipeline for reading DICOM chest X-ray images, inspecting their metadata, applying basic image cleanup and enhancement, and saving the processed outputs for comparison. It treats artifacts and noise in DICOM radiographic images as anomalies or data quality issues and applies MATLAB-based preprocessing to improve image quality before downstream analysis.

## What This Project Uses

- MATLAB **REQUIRED**
- Image Processing Toolbox Add-on in MATLAB **REQUIRED**
- DICOM chest X-ray data from **TCIA** **REQUIRED**
- NBIA Data Retriever for downloading the dataset **REQUIRED**

## Dataset

This project uses the **MIDRC-RICORD-1C** dataset from The Cancer Imaging Archive (TCIA).

The dataset is downloaded using **NBIA Data Retriever**.

## How to Get the Data

1. Install **NBIA Data Retriever**.
2. Open the download instructions page:  
   https://wiki.cancerimagingarchive.net/display/NBIA/Downloading+TCIA+Images
3. In NBIA Data Retriever, provide the path to the manifest file:

   `repopath/data/MIDRC-RICORD-1c-manifest-Jan-2021.tcia`

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

