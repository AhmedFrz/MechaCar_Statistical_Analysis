### Deliverable 1:

# 3. Use the library() function to load the dplyr package.
library(dplyr)

# 4. Import and read in the MechaCar_mpg.csv file as a data frame.

mecha_mpg <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)


# 5. Perform linear regression using the lm() function. 
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha_mpg)

# 6. Using the summary() function, determine the p-value and the r-squared value for the linear regression model.
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha_mpg))


# Deliverable 2

# 2. Import and read in the Suspension_Coil.csv file as a table.
suspension_coil <- read.csv(file='Suspension_Coil.csv', check.names = F, stringsAsFactors = F)



# 3. Write an RScript that creates a total_summary dataframe using the summarize() function to get the mean, 
#median, variance, and standard deviation of the suspension coil’s PSI column.
total_Summary <- suspension_coil %>% summarise(Mean_PSI=mean(PSI), Median_PSI=median(PSI), Var_PSI=var(PSI), Std_Dev_PSI=sd(PSI),
                                               Num_Coil=n(), .groups = 'keep')  

# 4. Write an RScript that creates a lot_summary dataframe using the group_by() and the summarize() functions 
# to group each manufacturing lot by the mean, median, variance, and standard deviation of the suspension coil’s PSI column. 
lot_summary <- suspension_coil %>% group_by(Manufacturing_Lot) %>% summarise(Mean_PSI=mean(PSI), Median_PSI=median(PSI), 
                                                                             Var_PSI=var(PSI), Std_Dev_PSI=sd(PSI),
                                                                             Num_Coil=n(), .groups = 'keep')

# Deliverable 3

# 1. Write an RScript using the t.test() function to determine if the PSI across all manufacturing lots is statistically different 
# from the population mean of 1,500 pounds per square inch.
t.test(suspension_coil$PSI, mu= 1500)


# 2. write three more RScripts in your MechaCarChallenge.RScript using the t.test() function and its subset() argument to determine 
# if the PSI for each manufacturing lot is statistically different from the population mean of 1,500 pounds per square inch.
lot1 <- subset(suspension_coil, Manufacturing_Lot=="Lot1")
t.test(lot1$PSI,mu=1500)

lot2 <- subset(suspension_coil, Manufacturing_Lot=="Lot2")
t.test(lot2$PSI,mu=1500)

lot3 <- subset(suspension_coil, Manufacturing_Lot=="Lot3")
t.test(lot3$PSI,mu=1500)



