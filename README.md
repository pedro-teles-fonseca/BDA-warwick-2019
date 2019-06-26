# "Bayesian Digit Analysis" - O'Bayes 2019 

The goal of this repository is to share the data and the code used in the "Bayesian Digit Analysis" poster (presented in the O'Bayes 2019 conference) and to allow the replicability of obtained results. Some supplemental graphs and tables are also provided.  

## Instructions

### Prerequisites

To run all the R scripts provided in this reposirory and obtain the desired outputs it is only required that two R packages are installed:

```
install.packages("Hmisc", dependencies = TRUE)
install.packages("tidyverse", dependencies = TRUE) 
```

The *Hmisc* package is necessairy to export R tables in TeX format, and the *tidyverse* package is only used in the *plots.R* script to produce graphs. Nevertheless, it is possible to reproduce all the results of the poster in the R console using only the base R package.

### Data

The raw data can be found in the *raw-data.xls* file, stored in the *data* folder. The reorganized version of the dataset that is read by the R scripts is the *data.txt* file, stored in the same folder. 

### R Scripts and Reproducibility

Using an Rstudio project, we provide a self-contained enviroment to reproduce all the results in the poster. In order to point R to the correct working directory, the *bda-poster-warwick.Rproj* file should be run beforehand. After that, all other R scripts should run smoothly.

* The *read-data.R file is an auxilliary script that is called within other scripts to import the data. 

* The *auxiliary-functions.R*, *bin-beta-model-functions.R* and *mu-dir-model-functions.R* files are auxilliary scripts that
contain functions that we developed specifically for Bayesian digit analysis. These scripts are called within other scripts if necessairy. 

* The results in the poster can be reproduced with the *poster-tables-bin-beta.R* and *poster-tables-mu-dir.R* scripts.

### Supplementary Materials

* Plots comparing observed vs expected digit frequencies are available in the *plots* folder. The code that generates the plots can be found in the *plots.R* file.

* The *aux-tables.pdf* file in the *aux-tables* folder is a contains the tables from the poster but with higher precision (numbers rounded up to five decimal places instead of three). These tables can be reproduced with the *aux-tables-bin.beta.R* and *aux-tables-mu-dir.R* files, stored in the same folder.

## Built With

* [R](https://www.r-project.org) - Free software environment for statistical computing and graphics.
* [R Studio](https://www.rstudio.com) - Free and open-source IDE for R.
* [TeX Live](https://www.tug.org/texlive/) - Free distribution of the TeX typesetting system.
* [Texmaker](https://www.xm1math.net/texmaker/) - Cross-platform and open-source LaTeX editor.

## Authors and Contributors

* **Pedro Fonseca** ([ISEG](https://www.iseg.ulisboa.pt/aquila/instituicao/ISEG/)) - [pedro-teles-fonseca](https://github.com/pedro-teles-fonseca) 

* **Advisor: Rui Paulo** ([ISEG](https://www.iseg.ulisboa.pt/aquila/instituicao/ISEG/) and [CEMAPRE](https://cemapre.iseg.ulisboa.pt)) - [Rui Paulo](https://www.iseg.ulisboa.pt/aquila/homepage/rui)

## Acknowledgments

We would like to thank to the following institutions for the finantial support they provided:

* [CEMAPRE](https://cemapre.iseg.ulisboa.pt) - Center for Applied Mathematics and Economics
* [FCT](https://www.fct.pt/index.phtml.en) - Foundation for Science and Technology (Portugal) - Research grant reference: SFRH/BD/129918/2017 (funded by the European Social Fund and by national MCTES funds)

## Contact

pedro.teles.fonseca@outlook.com



