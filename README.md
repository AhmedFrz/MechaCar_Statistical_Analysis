# MechaCar Statistical Analysis

<p align="center">
  <img src="https://img.shields.io/badge/R-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white" alt="R Badge"/>
  <img src="https://img.shields.io/badge/Statistics-Data_Analysis-blue?style=for-the-badge" alt="Statistics Badge"/>
  <img src="https://img.shields.io/badge/Automotive-Analysis-red?style=for-the-badge" alt="Automotive Badge"/>
</p>

## 📊 Overview

This project uses R to perform statistical analysis on automotive data for MechaCar, a fictional automotive company. The analysis focuses on understanding factors affecting vehicle performance (MPG) and manufacturing quality (suspension coil specifications), using statistical methods including linear regression, summary statistics, and hypothesis testing.

<details>
<summary><b>📌 Problem Statement & Research Questions</b></summary>

### Why This Project?

The automotive industry relies heavily on data-driven decision making for product development and quality control. This project addresses critical manufacturing and performance challenges faced by MechaCar:

1. **Performance Metrics**: Which vehicle design factors significantly predict MPG performance?
2. **Manufacturing Consistency**: Does the suspension coil production meet quality control specifications?
3. **Statistical Validation**: Are there statistically significant differences in suspension coil performance across manufacturing lots?

### Expected Learning Outcomes

- Apply linear regression modeling to identify significant variables affecting vehicle performance
- Use descriptive statistics to assess manufacturing consistency
- Implement hypothesis testing to validate manufacturing quality control
- Develop data-driven recommendations to improve vehicle design and manufacturing processes

</details>

<details>
<summary><b>🛠️ Tools & Technologies</b></summary>

### Technologies Used

- **R**: Primary programming language for statistical analysis
- **RStudio**: IDE for R development
- **dplyr**: R package for data manipulation and transformation
- **ggplot2**: Data visualization (referenced in preparatory code)
- **Statistical Methods**: Linear regression, t-tests, summary statistics

### Alternative Technologies

- **Python + Pandas/SciPy/NumPy**: Could offer similar statistical capabilities with different syntax
- **JMP or SPSS**: Commercial statistical software with more guided UI but less flexibility
- **Tableau**: For more advanced visualization of final results
- **Excel**: For basic analysis with limited statistical power

</details>

## 🔬 Project Structure

### Phase 1: Linear Regression to Predict MPG
- Import and analyze MechaCar MPG test results
- Develop multiple linear regression model
  <details>
  <summary>View Code</summary>
  
  ```r
  # Load required packages
  library(dplyr)
  
  # Import dataset
  mecha_mpg <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)
  
  # Perform linear regression
  lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha_mpg)
  
  # Generate summary statistics
  summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha_mpg))
  ```
  </details>
- Identify statistically significant variables
- Interpret regression results and model effectiveness

### Phase 2: Summary Statistics on Suspension Coils
- Collect and analyze suspension coil test data
  <details>
  <summary>View Code</summary>
  
  ```r
  # Import dataset
  suspension_coil <- read.csv(file='Suspension_Coil.csv', check.names = F, stringsAsFactors = F)
  ```
  </details>
- Generate summary statistics for entire dataset
  <details>
  <summary>View Code</summary>
  
  ```r
  # Create total summary statistics
  total_Summary <- suspension_coil %>% summarise(Mean_PSI=mean(PSI), 
                                               Median_PSI=median(PSI), 
                                               Var_PSI=var(PSI), 
                                               Std_Dev_PSI=sd(PSI),
                                               Num_Coil=n(), 
                                               .groups = 'keep')
  ```
  </details>
- Create lot-by-lot statistical breakdown
  <details>
  <summary>View Code</summary>
  
  ```r
  # Group by manufacturing lot and generate statistics
  lot_summary <- suspension_coil %>% group_by(Manufacturing_Lot) %>% 
                summarise(Mean_PSI=mean(PSI), 
                          Median_PSI=median(PSI), 
                          Var_PSI=var(PSI), 
                          Std_Dev_PSI=sd(PSI),
                          Num_Coil=n(), 
                          .groups = 'keep')
  ```
  </details>
- Assess manufacturing consistency against specifications

### Phase 3: T-Tests on Suspension Coils
- Perform t-tests comparing all manufacturing data to population mean
  <details>
  <summary>View Code</summary>
  
  ```r
  # T-test for all manufacturing lots against population mean
  t.test(suspension_coil$PSI, mu= 1500)
  ```
  </details>
- Conduct individual t-tests on each manufacturing lot
  <details>
  <summary>View Code</summary>
  
  ```r
  # T-test for Lot 1
  lot1 <- subset(suspension_coil, Manufacturing_Lot=="Lot1")
  t.test(lot1$PSI, mu=1500)
  
  # T-test for Lot 2
  lot2 <- subset(suspension_coil, Manufacturing_Lot=="Lot2")
  t.test(lot2$PSI, mu=1500)
  
  # T-test for Lot 3
  lot3 <- subset(suspension_coil, Manufacturing_Lot=="Lot3")
  t.test(lot3$PSI, mu=1500)
  ```
  </details>
- Determine statistical significance of differences
- Identify problematic manufacturing lots

<details>
<summary><b>📈 Analysis Methodology</b></summary>

### Workflow

```
Data Import → Data Cleaning → Exploratory Analysis → Statistical Modeling → Hypothesis Testing → Interpretation
```

### Why This Methodology?

This approach combines both descriptive and inferential statistics to address the research questions:

1. **Multiple Linear Regression**: Chosen to identify relationships between multiple vehicle design variables and MPG performance simultaneously, allowing isolation of significant factors while controlling for others.

2. **Summary Statistics by Grouping**: Used to quantify manufacturing consistency across different production lots, enabling targeted quality improvement.

3. **T-Tests**: Selected for statistical comparison against design specifications, providing objective evidence of compliance or deviation from standards.

This statistical framework provides a robust, data-driven approach to identify both performance factors and manufacturing issues.

</details>

<details>
<summary><b>📊 Results & Discussion</b></summary>

### Linear Regression to Predict MPG

The analysis revealed that vehicle length and ground clearance are statistically significant predictors of MPG performance (p < 0.05). The multiple R-squared value indicates the model explains a substantial portion of the variation in MPG, suggesting these design elements should be prioritized in vehicle development.

<details>
<summary>View Sample Output</summary>

```r
# Sample output from model summary
# Coefficients:
#                   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)      -1.040e+02  1.585e+01  -6.559 5.08e-08 ***
# vehicle_length    6.267e+00  6.553e-01   9.563 2.60e-12 ***
# vehicle_weight    1.245e-03  6.890e-04   1.807   0.0776 .  
# spoiler_angle     6.877e-02  6.653e-02   1.034   0.3069    
# ground_clearance  3.546e+00  5.412e-01   6.551 5.21e-08 ***
# AWD              -3.411e+00  2.535e+00  -1.346   0.1852    
# ---
# Multiple R-squared:  0.7149, Adjusted R-squared:  0.6825 
```
</details>

### Suspension Coil Analysis

Summary statistics demonstrated that while overall manufacturing variance falls within the 100 PSI specification limit, lot-by-lot analysis revealed Lot 3 significantly exceeds acceptable variance levels. This indicates a targeted quality improvement opportunity.

<details>
<summary>View Sample Output</summary>

```r
# Sample output from total_Summary
#   Mean_PSI Median_PSI  Var_PSI Std_Dev_PSI Num_Coil
# 1  1498.78       1500 62.29356    7.892627      150

# Sample output from lot_summary
#   Manufacturing_Lot Mean_PSI Median_PSI   Var_PSI Std_Dev_PSI Num_Coil
# 1              Lot1  1500.00       1500  0.979592   0.9897433       50
# 2              Lot2  1500.20       1500  7.469388   2.7330181       50
# 3              Lot3  1496.14       1498 170.286122  13.0493725       50
```
</details>

### T-Test Results

Statistical testing showed:
- Overall manufacturing meets design specifications (p > 0.05)
- Lots 1 and 2 are statistically consistent with specifications
- Lot 3 shows statistically significant deviation from the target 1,500 PSI (p < 0.05)

<details>
<summary>View Sample Output</summary>

```r
# Sample output from t-tests
# All lots:
# t = -1.8931, df = 149, p-value = 0.06028
# mean of x = 1498.78
#
# Lot 1:
# t = 0, df = 49, p-value = 1
# mean of x = 1500
#
# Lot 2:
# t = 0.51745, df = 49, p-value = 0.6072
# mean of x = 1500.2
#
# Lot 3:
# t = -2.0916, df = 49, p-value = 0.04168
# mean of x = 1496.14
```
</details>

### Alternative Approaches

- **ANOVA testing**: Could compare means across all lots simultaneously
- **Machine learning approaches**: Could identify more complex, non-linear relationships in the MPG data
- **Time series analysis**: Could track manufacturing quality over production periods to identify trends

</details>

<details>
<summary><b>💼 Business Impact</b></summary>

### Organizational Benefits

1. **Cost Reduction**:
   - Identifying critical design factors eliminates unnecessary design complexity
   - Targeting specific manufacturing lots for improvement reduces overall quality control costs
   - Pre-identifying performance issues before full production prevents costly recalls

2. **Efficiency Improvements**:
   - Statistical validation of manufacturing processes reduces testing time
   - Data-driven design decisions accelerate the development cycle
   - Focused quality improvement efforts optimize resource allocation

3. **Quality Enhancements**:
   - Understanding key MPG factors leads to more fuel-efficient vehicles
   - Identifying problematic manufacturing lots improves component reliability
   - Statistical process control enables consistent quality across production runs

</details>

## 🚀 Future Work

- Develop statistical models for additional performance metrics (acceleration, braking, etc.)
- Implement time-series analysis to track manufacturing quality trends
- Create comparative analysis with competitor vehicle data
- Develop predictive models for component failure rates

---
