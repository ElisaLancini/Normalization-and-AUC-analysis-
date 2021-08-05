[![ResearchGate][researchgate-shield]][researchgate-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Twitter][Twitter-shield]][Twitter-url]

<!-- PROJECT LOGO -->
<p align="center">
  <h2 align="center">Codes for data normalization and AUC calculation</h3>
</p>
<p align="center">
  <h6 align="center">Elisa Lancini, Natalia Waal</h3>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-task">About The Task</a>
      </ul>
        <li><a href="#the-code">The Code</a></li>
      <ul>
          <li><a href="#outputs">Outputs</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#r-version">R version</a></li>
        <li><a href="#r-packages-installation">R packages installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#contact">Affiliations</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE TASK -->
## About The Task 
R-based code for normalising data and measuring the AUC.

1. A suction cup is removing a liquid from a falcon from top to bottom and passing it trough a UV-meter and then directly into Eppendorf tubes. After a specific volume the data which was passed through the UV-meter is marked as fraction 1 and the arm which puts the liquid into the eppendorf tubes moves to the second one, so that the next volume unit is measured and put into the new tube. and so on till 13. The rest (after fraction 13) is still measured but remains in the tubing so it can be dismissed. The absorbances before the first number which do not have a assinged fraction number belong to fraction 1. everything after fraction number one till number 2 ( line 220-389) belong to fracion number 2.
2. The data related to the buffer needs to be removed. However, not every datasheet will report the data related to the buffer in the same rows. Therefore the fractions that belongs to the buffer needs to be specified manually per each datasheet.
3. Within the absorption values, the smallest value is to be determined. Then this value is to be used as addition or subtraction factor, so that the smallest absorption value is fixed as 0.
4. Normalize "Absorbance" data.
5. Plot in the X axis "Position(mm)" and "Fraction number" and in Y axis the "Absorbance".
6. Adjust the y-axis manually, as for visual comparison all the graphs should have the same y-value.
7. Calculate the area underneath the curve of specific fractions.

<!-- THE CODE -->
## The Code

1. Replace NaN in "Fraction number" column with the correct fraction number the row belongs to (see point 1 of data sheet explanation).
2. Remove fraction numbers specified in "Individual Parameters", as they belong to the buffer. 
3. The minimum value from "Absorbance" column is determined and is added or subtracted, based on the decision made in the "Individual Parameters"
4. Normalization of "Absorbance" data by multiplying it to the normalization factor specified in "Individual Parameters"
5. Define X axis as "Position(mm)" and "Fraction number" and Y axis as "Absorbance", normalized
6. Plot with the Y axis range specified in "Individual Parameters".
7. Calculate AUC for every fraction section specified in "Individual Parameters".

<!-- OUTPUTS -->
### Outputs

- Figure with "Position(mm)" and "Fraction number" on X axis and "Absorbance" values, normalized, on Y axis. The range of Y axis values is adjustable.
The plots are saved in PDF format.

<img src="https://github.com/ElisaLancini/images/blob/c6067f4077b2eac2a35e6ffde27222c1d6e5c1b2/Screenshot%202021-08-05%20at%2013.41.17.png" alt="workshop logo" width="600" style="margin:0 0 0 0"/>

- The results of AUC calculation are saved as xlsx files.


<!-- GETTING STARTED -->
## Getting Started

Important: Once you have downloaded the scripts, you will need to adapt the paths to the folder where they are located on your PC.
The current scripts have been adapted to our data set and the type of analysis we were interested in, so there may be a better pipeline that fits your specific data. 
### R version

To get a local copy up and running install R software (version R i386 3.4.2) (R Core Team, 2017).

### R Packages installation

We used various R packages.

* readxl
* openxlsx
* writexl
* dplyr

You can install them writing the following line in your R console

  ```sh
install.packages(c("readxl", "openxlsx", "writexl","dplyr")).
  ```
  
<!-- CONTACT -->
## Contact

Elisa Lancini, MSc

* elisa.lancini@dzne.de
* [Twitter](https://twitter.com/e_lancini/)
* [ResearchGate](https://www.researchgate.net/profile/Elisa-Lancini?ev=hdr_xprf)


<!-- AFFILIATIONS -->
## Authors affiliations:

- Otto-von-Guericke-Universität Magdeburg 
- Institute for Cognitive Neurology and Dementia Research (IKND)
- Deutsches Zentrum für Neurodegenerative Erkrankungen (DZNE)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [AUC calculation](https://stackoverflow.com/questions/4954507/calculate-the-area-under-a-curve/)
* Calida Pereira


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[researchgate-shield]: https://img.shields.io/badge/-ResearchGate-black.svg?style=for-the-badge&logo=ResearchGate&colorB=555
[researchgate-url]: https://www.researchgate.net/profile/Elisa-Lancini?ev=hdr_xprf
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/elisa-lancini/
[twitter-shield]: https://img.shields.io/badge/-Twitter-black.svg?style=for-the-badge&logo=Twitter&colorB=555
[twitter-url]: https://twitter.com/e_lancini
