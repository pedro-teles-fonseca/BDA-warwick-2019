# Bayesian Digit Analysis - O'Bayes 2019 

This repository accompanies the "Bayesian Digit Analysis" [poster](https://github.com/pedro-teles-fonseca/bda-poster-warwick/blob/master/poster.pdf), to be presented in the O'Bayes 2019 conference taking place in the University of Warwick (UK). Here we share the data and the code used to develop the poster, allowing the replicability of obtained results. Some supplementary materials are also provided.  

## Instructions

### Prerequisites

To run all the R scripts provided in this reposirory and obtain the desired outputs it is required that two R packages are installed:

```
install.packages("Hmisc", dependencies = TRUE)
install.packages("tidyverse", dependencies = TRUE) 
```
Nevertheless, it is possible to reproduce all the results in the poster in the R console using only the base R package, since the *Hmisc* package is only used to export R tables in TeX format and the *tidyverse* package is only used in the *plots.R* script to produce graphs, which are supplementary material. 

### Data

The raw data can be found in the *raw-data.xls* file, stored in the *data* folder. The reorganized version of the dataset that is imported by the R scripts is the *data.txt* file, stored in the same folder. 

### Reproducibility

Using an Rstudio project, we provide a self-contained enviroment to reproduce all the results in the poster. In order to direct R to the correct working directory, the *bda-poster-warwick.Rproj* file should be run beforehand. After that, all R scripts should run smoothly.

### R Scripts

* *read-data.R* is an auxilliary script that is called within other scripts to import the data. 

* *auxiliary-functions.R*, *bin-beta-model-functions.R* and *mu-dir-model-functions.R* are auxilliary scripts that
contain functions that we developed specifically for Bayesian digit analysis. These scripts are called within other scripts if necessairy. 

* The tables in the poster can be reproduced with the *poster-tables-bin-beta.R* and *poster-tables-mu-dir.R* scripts.

### Supplementary Materials

* Plots comparing observed versus expected digit frequencies can be found in the *plots* folder. The code that generates the plots can be found in the *plots.R* file.

* Tables similar to the ones in the poster but with five decimal places instead of three can be found in the *aux-tables.pdf* file, stored in the *aux-tables* folder. These tables can be reproduced with the *aux-tables-bin.beta.R* and *aux-tables-mu-dir.R* files, stored in the same folder.

## Built With

* [R](https://www.r-project.org) - Free software environment for statistical computing and graphics.
* [R Studio](https://www.rstudio.com) - Free and open-source IDE for R.
* [TeX Live](https://www.tug.org/texlive/) - Free distribution of the TeX typesetting system.
* [Texmaker](https://www.xm1math.net/texmaker/) - Cross-platform and open-source LaTeX editor.

## Authors and Contributors

* **Pedro Fonseca** ([ISEG](https://www.iseg.ulisboa.pt/aquila/instituicao/ISEG/)) - [pedro-teles-fonseca](https://github.com/pedro-teles-fonseca) 

* **Advisor: Rui Paulo** ([ISEG](https://www.iseg.ulisboa.pt/aquila/instituicao/ISEG/) and [CEMAPRE](https://cemapre.iseg.ulisboa.pt)) - [Rui Paulo](https://www.iseg.ulisboa.pt/aquila/homepage/rui)

## Acknowledgments

This project was partially funded by:

* [CEMAPRE](https://cemapre.iseg.ulisboa.pt) - Center for Applied Mathematics and Economics
* [FCT](https://www.fct.pt/index.phtml.en) - Foundation for Science and Technology (Portugal) - Research grant reference: SFRH/BD/129918/2017 (funded by the European Social Fund and by national MCTES funds)

We would like the aforementioned institutions for the finantial support they provided.

## Contact

pedro.teles.fonseca@outlook.com



