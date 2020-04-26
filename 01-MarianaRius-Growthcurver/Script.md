Setup
=====

1.  Requirements:

[R](https://www.r-project.org/)

[RStudio](https://rstudio.com/products/rstudio/download/)

In console run:

``` r
knitr::opts_knit$set(root.dir = 'C:/Users/alexg/Google Drive/05-Proyectos/restlab_workshop/01-MarianaRius-Growthcurver/')

#Or setwd() 
#setwd('C:/Users/alexg/Google Drive/05-Proyectos/restlab_workshop/01-MarianaRius-Growthcurver/')
```

Install the packages

``` r
install.packages("tidyverse")
install.packages("rlist")
install.packages("growthcurver")
install.packages("lubridate")
```

1.  Download datasets or locate your own data you would like to use.

IMPORTANT: For the script to run properly an independent folder
containing the data file is

-   Datasets provided:

    -   LAA-E2.xlsx
        -   OD data - Single reads per well
        -   LAA = Laby Antibiotic Assay
        -   [plate
            setup](https://docs.google.com/presentation/d/1jRHy32pm0gParXaoHVKo8pyVgZAvbHmZJvZlcpzZYKc/edit?usp=sharing)
        -   96 wells
        -   16 time points
        -   No media blank
        -   Excel file
            -   sheets arranged reverse chronologically (most recent
                **first** )
            -   OD reads start at row 27 (header = row 26)
            -   Date and time on row 23
            -   Last sheet is not blank
    -   NGE-E1-P3.xlsx
        -   OD Data - Multiple reads per well
        -   NGE = Nutrient Growth Experiment
        -   [plate
            setup](https://docs.google.com/presentation/d/1Fe_pQ2ebTqtWHqC9wkUPmBWrXytWQm8loQvxyXw0EWs/edit?usp=sharing)
        -   96 wells
        -   6 time points
        -   No media blank
        -   Excel file
            -   Sheets arranged reverse chronologically (most recent
                **first** )
            -   OD reads start at row 48 (header = row 47)
            -   Date and time on row 25
            -   Last sheet is blank

Growthcurver Intro
==================

Growth phases of a culture
--------------------------

![](figures/Fig1.png)

Logistic equation (used by growthcurver)

$$N\_{t}=\\frac{K}{1+\\frac{K-N\_{0}}{N\_{0}}e^{-rt}}$$

*N*<sub>*t*</sub> = population at time *t*

*K* = carrying capacity

*N*<sub>0</sub> = initial population size

*r* = intrinsic growth rate

![](figures/Fig2.png)

R/ RStudio Orientation
======================

-   Script, Console, Environment, Help
-   R basics
    -   making objects
    -   Object types
        -   numeric, character, factor, vector, data.frame, list
    -   for loop
    -   functions
        -   c() and trick to building a recursive vector
        -   head() and tail()

Pipeline
========

We will be following this vignette:
[Growthcurver](https://cran.r-project.org/web/packages/growthcurver/vignettes/Growthcurver-vignette.html)

Pipeline breakdown:
-------------------

1.  Setup script
2.  Load data
3.  Organize data for growthcurver
4.  Run growthcurver
5.  Plot growthcurver output
6.  PCA & plot
7.  Sigma histogram
8.  Plot parameters

LAA-E2.xlsx
-----------

### 1. Setup script

``` r
options(stringsAsFactors = F)
#total wells
tw<-96
#filename
fn<-"data/LAA-E2.xlsx"
#replicates?
x<-3
#number of antibiotic concentrations
nc<-12
#number of strains #JUST AURLI
ns<-1
```

############ 

### 2. Load data

``` r
library("tidyverse")
```

    ## -- Attaching packages ----------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.0     v purrr   0.3.3
    ## v tibble  2.1.3     v dplyr   0.8.5
    ## v tidyr   1.0.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts -------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library("readxl")

sheets <- excel_sheets(fn)


exceltable <- sheets  %>%
  as.list() %>% 
  map(read_excel,path=fn,col_names = FALSE) %>% 
  map(as_tibble)
```

    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems

    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems
    ## New names:
    ## * `` -> ...1
    ## * `` -> ...2
    ## * `` -> ...3
    ## * `` -> ...4
    ## * `` -> ...5
    ## * ... and 8 more problems

``` r
names(exceltable) <- paste("t-", sheets, sep = "")


sheetslist <- exceltable %>% 
  map(slice,27:34) %>% #This selects the OD values
  map(select,-1)



for (i in 1:length(sheetslist)){
  colnames(sheetslist[[i]]) <- as.character(c(paste0(0,1:9),10:12))
  sheetslist[[i]]$rows <- LETTERS[1:8]
  sheetslist[[i]] <- sheetslist[[i]] %>% gather(1:12,key="column",value="OD")
}

sheetslist <- sheetslist %>%
  map(as.tibble) %>% 
  map(mutate,well=paste0(rows,column)) %>% 
  map(mutate,OD=as.numeric(OD))
```

AllSheets is a list of dataframes. Each dataframe contains a value for
OD, well, row and column.

``` r
sheetslist[[1]]
```

    ## # A tibble: 96 x 4
    ##    rows  column     OD well 
    ##    <chr> <chr>   <dbl> <chr>
    ##  1 A     01     0.120  A01  
    ##  2 B     01     0.114  B01  
    ##  3 C     01     0.155  C01  
    ##  4 D     01     0.117  D01  
    ##  5 E     01     0.0792 E01  
    ##  6 F     01     0.0966 F01  
    ##  7 G     01     0.230  G01  
    ##  8 H     01     0.245  H01  
    ##  9 A     02     0.105  A02  
    ## 10 B     02     0.103  B02  
    ## # ... with 86 more rows

You can filter your wells using the filter condition, by row, column or
both.

``` r
#Select only the first 3 rows
allSheets <- sheetslist %>% 
 map(filter,rows==c("A","B","C")) %>% 
  map(arrange,well)

allSheets[[1]]
```

    ## # A tibble: 12 x 4
    ##    rows  column     OD well 
    ##    <chr> <chr>   <dbl> <chr>
    ##  1 A     01     0.120  A01  
    ##  2 A     04     0.0416 A04  
    ##  3 A     07     0.0818 A07  
    ##  4 A     10     0.0405 A10  
    ##  5 B     01     0.114  B01  
    ##  6 B     04     0.0419 B04  
    ##  7 B     07     0.0513 B07  
    ##  8 B     10     0.0399 B10  
    ##  9 C     01     0.155  C01  
    ## 10 C     04     0.0424 C04  
    ## 11 C     07     0.319  C07  
    ## 12 C     10     0.0412 C10

### 3. Organize data for growthcurver

``` r
#calculate difference in time
timelist <- exceltable  %>% 
  map(select,2) %>% 
  map(slice,23:24)

vec <- timelist %>%
  unlist() 
vec <- vec[!is.na(vec)]

library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

``` r
time <- data.frame(ID=sheets,
                   time = mdy_hms(vec)) %>% 
  as_tibble() %>% 
  arrange(time)%>%
  mutate(dur = time - time[1]) 

dur<-time$dur %>%
  map_dfc(dseconds)
```

what does time look like?

``` r
time
```

    ## # A tibble: 16 x 3
    ##    ID               time                dur        
    ##    <chr>            <dttm>              <drtn>     
    ##  1 LAA-E2-S1-T01-P1 2015-11-13 12:49:00      0 secs
    ##  2 LAA-E2-S1-T02-P1 2015-11-13 12:51:19    139 secs
    ##  3 LAA-E2-S1-T03-P1 2015-11-13 12:53:06    246 secs
    ##  4 LAA-E2-S1-T04-P1 2015-11-13 22:55:33  36393 secs
    ##  5 LAA-E2-S1-T05-P1 2015-11-14 15:27:31  95911 secs
    ##  6 LAA-E2-S1-T06-P1 2015-11-14 21:30:52 117712 secs
    ##  7 LAA-E2-S1-T07-P1 2015-11-15 15:26:55 182275 secs
    ##  8 LAA-E2-S1-T08-P1 2015-11-15 23:24:34 210934 secs
    ##  9 LAA-E2-S1-T09-P1 2015-11-16 13:42:21 262401 secs
    ## 10 LAA-E2-S1-T10-P1 2015-11-16 18:05:13 278173 secs
    ## 11 LAA-E2-S1-T11-P1 2015-11-16 19:41:59 283979 secs
    ## 12 LAA-E2-S1-T12-P1 2015-11-17 09:24:00 333300 secs
    ## 13 LAA-E2-S1-T13-P1 2015-11-18 10:41:47 424367 secs
    ## 14 LAA-E2-S1-T14-P1 2015-11-18 20:53:13 461053 secs
    ## 15 LAA-E2-S1-T15-P1 2015-11-19 10:02:12 508392 secs
    ## 16 LAA-E2-S1-T16-P1 2015-11-19 17:44:07 536107 secs

``` r
allSheets1 <- allSheets %>%
  map(select,well,OD)%>%
  map(spread,key="well",value="OD")

df <- bind_rows(allSheets1, .id = "ID") %>%
  arrange(ID) %>% 
  as.data.frame()

t <- time %>% 
  arrange(ID)%>%
  select(-ID) %>%
  as.data.frame()

final <- cbind(t,df) %>%
  as_tibble() %>%
  select(-ID,-time) %>%
  rename(time=dur) %>%
  mutate(time=as.numeric(time))%>%
  as.data.frame()
```

what does final look like?

``` r
head(final)
```

    ##     time    A01    A04    A07    A10    B01    B04    B07    B10    C01    C04
    ## 1      0 0.0374 0.0443 0.0385 0.0387 0.0406 0.0464 0.0394 0.0393 0.0418 0.0474
    ## 2    139 0.0389 0.0449 0.0385 0.0379 0.0394 0.0463 0.0385 0.0395 0.0457 0.0482
    ## 3    246 0.0391 0.0462 0.0395 0.0385 0.0402 0.0495 0.0393 0.0400 0.0417 0.0499
    ## 4  36393 0.0412 0.0440 0.0391 0.0393 0.0406 0.0439 0.0389 0.0390 0.0429 0.0443
    ## 5  95911 0.0722 0.0431 0.0400 0.0397 0.2426 0.0450 0.0395 0.0394 0.2355 0.0451
    ## 6 117712 0.2557 0.0433 0.0396 0.0396 0.3796 0.0441 0.0536 0.0384 0.3752 0.0441
    ##      C07    C10
    ## 1 0.0422 0.0402
    ## 2 0.0404 0.0395
    ## 3 0.0402 0.0404
    ## 4 0.0403 0.0398
    ## 5 0.0412 0.0404
    ## 6 0.0419 0.0400

``` r
table1 <- final %>% as_tibble() %>% 
  gather(2:dim(final)[2],key = "ID",value="OD")
table1
```

    ## # A tibble: 192 x 3
    ##      time ID        OD
    ##     <dbl> <chr>  <dbl>
    ##  1      0 A01   0.0374
    ##  2    139 A01   0.0389
    ##  3    246 A01   0.0391
    ##  4  36393 A01   0.0412
    ##  5  95911 A01   0.0722
    ##  6 117712 A01   0.256 
    ##  7 182275 A01   0.361 
    ##  8 210934 A01   0.321 
    ##  9 262401 A01   0.309 
    ## 10 278173 A01   0.206 
    ## # ... with 182 more rows

``` r
table1 %>% ggplot(aes(x=time,y=OD,color=ID))+
  geom_point()+
  facet_wrap(.~ID)+
  theme_minimal()+
  geom_smooth(se=FALSE)+
  labs(title = "Growth Experiments",
              subtitle = "Plots of Optical Density as a function of time",
              caption = "Data source: LAA-E2.xlsx")
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](Script_files/figure-markdown_github/unnamed-chunk-10-1.png)

### 4.Run growthcurver

``` r
library("growthcurver")
gc_out <- SummarizeGrowthByPlate(final)
```

what does gc\_out look like?

``` r
head(gc_out)
```

    ##   sample           k           n0            r     t_mid     t_gen      auc_l
    ## 1    A01 0.168750024 1.820308e-17 3.689265e-04  99655.63  1878.822 73651.1798
    ## 2    A04 0.001499999 3.240612e-03 1.627278e-05 -38194.17 42595.512   875.1569
    ## 3    A07 0.068173104 3.520222e-17 1.599017e-04 220133.44  4334.832 21540.8987
    ## 4    A10 0.002071613 5.131656e-04 4.066062e-05  27319.97 17047.137  1039.5081
    ## 5    B01 0.197766522 4.334260e-04 9.957878e-05  61468.19  6960.792 93863.3095
    ## 6    B04 0.001599999 5.273290e-03 1.341780e-05 -26946.78 51658.776   999.9254
    ##        auc_e        sigma                      note
    ## 1 74388.2824 0.0787372299                          
    ## 2   701.9883 0.0008217618 questionable fit (k < n0)
    ## 3 19153.5438 0.0254531983                          
    ## 4  1062.3295 0.0004539442                          
    ## 5 90079.2799 0.1010223269                          
    ## 6   883.6990 0.0011102852 questionable fit (k < n0)

Additional parameters provided in gc\_out

t\_mid *= t, ½ K,* the time at which the population density reaches half
the carrying capacity

t\_gen = doubling time, the least amount of time required to double the
population

auc\_l = the area under the modeled logistic curve (integral of the
logistic equation)

auc\_e = the area under the curve obtained from the optical density
readings data

sigma = residual standard deviation, the estimated standard deviation of
the errors // residual sum of squares from the fit of the logistic curve
to the data, so larger values mean poorer fits, a parameter used to
evaluate the ‘goodness of fit’

``` r
write.csv(gc_out,file="results/aurli_growthcurver_output.csv") 
save(gc_out,file="results/aurli_growthcurver_output.rda")
```

### 6. Plot growthcurver output

``` r
d<-final #renames our data to match growthcurver's provided script

num_analyses <- length(names(d)) - 1
d_gc <- data.frame(sample = character(num_analyses),
                   k = numeric(num_analyses),
                   n0  = numeric(num_analyses),
                   r = numeric(num_analyses),
                   t_mid = numeric(num_analyses),
                   t_gen = numeric(num_analyses),
                   auc_l = numeric(num_analyses),
                   auc_e = numeric(num_analyses),
                   sigma = numeric(num_analyses),
                   stringsAsFactors = FALSE)

trim_at_time<- as.numeric(dur[length(dur)])#set our preferred plotting range based on tdif


#pdf("results/LAA-E2_growthcurver_r.pdf", height = 8.5, width = 11) 

par(mfrow = c(8,12))
par(mar = c(0.25,0.25,0.25,0.25))
y_lim_max <- max(d[,setdiff(names(d), "time")]) - min(d[,setdiff(names(d), "time")])

n <- 1    # keeps track of the current row in the output data frame
for (col_name in names(d)) {
  
  # Don't process the column called "time". 
  # It contains time and not absorbance data.
  if (col_name != "time") {
    
    # Create a temporary data frame that contains just the time and current col
    d_loop <- d[, c("time", col_name)]
    
    # Do the background correction.
    # Background correction option 1: subtract the minimum value in a column
    #                                 from all measurements in that column
    min_value <- min(d_loop[, col_name])
    d_loop[, col_name] <- d_loop[, col_name] - min_value
    # Background correction option 2: subtract the mean value of blank wells
    #                                 over the course the experiment
    #                                 (Replace B2, D8, G11 with the column
    #                                  names of your media-only wells)
    #d$blank <- apply(d[, c("B2", "D8", "G11")], 1, mean)
    #d$A1 <- d$A1 - d$blank
    
    # Now, call Growthcurver to calculate the metrics using SummarizeGrowth
    gc_fit <- SummarizeGrowth(data_t = d_loop[, "time"], 
                              data_n = d_loop[, col_name],
                              t_trim = trim_at_time,
                              bg_correct = "none")
    
    # Now, add the metrics from this column to the next row (n) in the 
    # output data frame, and increment the row counter (n)
    d_gc$sample[n] <- col_name
    d_gc[n, 2:9] <- c(gc_fit$vals$k,
                      gc_fit$vals$n0,
                      gc_fit$vals$r,
                      gc_fit$vals$t_mid,
                      gc_fit$vals$t_gen,
                      gc_fit$vals$auc_l,
                      gc_fit$vals$auc_e,
                      gc_fit$vals$sigma)
    n <- n + 1
    
    # Finally, plot the raw data and the fitted curve
    # Here, I'll just print some of the data points to keep the file size smaller
    n_obs <- length(gc_fit$data$t)
    idx_to_plot <- 1:20 / 20 * n_obs
    plot(gc_fit$data$t[idx_to_plot], gc_fit$data$N[idx_to_plot], 
         pch = 20, 
         xlim = c(0, trim_at_time), 
         ylim = c(0, y_lim_max),
         cex = 0.6, xaxt = "n", yaxt = "n")
    text(x = trim_at_time / 4, y = y_lim_max, labels = col_name, pos = 1)
    if (gc_fit$model=="") {
      gc_fit$model<-rep(0,length(tdif[1:grep(trim_at_time, tdif)])-1)
      lines(gc_fit$data$t, rep(0,length(tdif[1:grep(trim_at_time, tdif)])-1), col = "indianred3")
    }
    else #I added 'if...else' for data where no model was fit plots line at y=0
      lines(gc_fit$data$t, predict(gc_fit$model), col = "indianred3")
  }
}
```

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

    ## Warning in if (gc_fit$model == "") {: the condition has length > 1 and only the
    ## first element will be used

``` r
#dev.off()
```

![](Script_files/figure-markdown_github/unnamed-chunk-14-1.png)

### 6. PCA and plot

``` r
# Load dplyr, ggplot2, and the sample data
library(dplyr)
library(ggplot2)
pca_gc_out <- as_data_frame(gc_out) 
```

    ## Warning: `as_data_frame()` is deprecated, use `as_tibble()` (but mind the new semantics).
    ## This warning is displayed once per session.

``` r
# Prepare the gc_out data for the PCA
rownames(pca_gc_out) <- pca_gc_out$sample
```

    ## Warning: Setting row names on a tibble is deprecated.

``` r
# Do the PCA
pca.res <- prcomp(pca_gc_out %>% select(k:sigma), center=TRUE, scale=TRUE)
# Plot the results
as_data_frame(list(PC1=pca.res$x[,1],
                   PC2=pca.res$x[,2],
                   samples = rownames(pca.res$x))) %>% 
  ggplot(aes(x=PC1,y=PC2, label=samples)) + 
  geom_text(size = 3)
```

![](Script_files/figure-markdown_github/unnamed-chunk-15-1.png)

``` r
# Do the PCA with percentages in axes
pca.res <- prcomp(pca_gc_out %>% select(k:sigma), center=TRUE, scale=TRUE)
percentage <- round(pca.res$sdev / sum(pca.res$sdev) * 100, 2)
df_out <- as.data.frame(pca.res$x)
percentage <- paste( colnames(df_out), "(", paste( as.character(percentage), "%", ")", sep="") )
# Plot the results
as_data_frame(list(PC1=pca.res$x[,1],
                   PC2=pca.res$x[,2],
                   samples = rownames(pca.res$x))) %>% 
  ggplot(aes(x=PC1,y=PC2, label=samples)) + geom_text(size = 3) + xlab(percentage[1]) + ylab(percentage[2])
```

![](Script_files/figure-markdown_github/unnamed-chunk-15-2.png)

### 7. Sigma histogram

``` r
par(mfrow=c(1,1),mar = c(3.8,3.8,2,2))
# Plot a histogram of the sigma values in order to check for outliers
gc_out %>% 
  ggplot(aes(x=sigma))+
  theme_minimal()+
  labs(title = "Histogram of sigma values",
              caption = "Data source: LAA-E2.xlsx")+
  geom_histogram(fill="lightblue",col="darkblue")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](Script_files/figure-markdown_github/unnamed-chunk-16-1.png)

### 8. Plot parameters

``` r
gc_out %>%
  gather(2:9,key="parameter",value = "value") %>% 
  select(-note) %>% 
  ggplot(aes(y=value,x=parameter))+
  theme_minimal()+
  facet_wrap(.~parameter,scales="free_y")+
  labs(title = "Distribution of the parameter",
              caption = "Data source: LAA-E2.xlsx")+
  geom_boxplot()
```

![](Script_files/figure-markdown_github/unnamed-chunk-17-1.png)
