# Code reference: coursepack
# data
# brand: Tims=-1, Starbucks=1
brand <- c(-1,-1,-1,-1,1,1,1,1)
# temperature: Iced=-1,Hot=1
temp <- c(-1,-1,1,1,-1,-1,1,1)
# Type: Americano=-1, Latte=1
type <- c(-1,1,-1,1,-1,1,-1,1)
# response y=pH
pH <- c(4.91,6.75,4.74,6.38,6.22,6.93,5.56,6.35)
df <- data.frame(brand=brand,temp=temp,type=type,pH=pH)

# factor
df$brand <- as.factor(df$brand)
df$temp <- as.factor(df$temp)
df$type <- as.factor(df$type)

#visualization
plot.design(pH~brand+temp+type, data=df)
#remark: great variation in type, in particular, Starbucks has higher pH.

interaction.plot(df$brand,df$temp,df$pH,xlab = "Brand",trace.label = "Temperature",ylab="mean pH")
interaction.plot(df$brand,df$type,df$pH,xlab = "Brand",trace.label = "Type",ylab="mean pH")
interaction.plot(df$temp,df$type,df$pH,xlab = "Temperature",trace.label = "Type",ylab="mean pH")
#remark:slight interaction between temperature and brand; 
# great interaction between brand and type
# negiligle interaction between temperature and type

#full model, all interaction except for 3-factor interaction

#regression model
full_lm <- lm(pH~brand*temp*type, data=df)
summary(full_lm)
# remark: only 1DF for residual, only main type effect is significant at level of 0.05

#anova model
full_aov <- aov(pH~brand*temp*type, data=df)
summary(full_aov)
# similar to lm, temp:type has the least F-value and SS, could be seen negligible

# since we don't have DF for residuals, so the MSE is not good, try graphical plot
library(faraway)
full_aov_est <- coefficients(full_aov)
halfnorm(full_aov_est[-1],
         ylab = "Absolute estimated effects",
         nlab = 3,
         labs = c("brand", "temp", "type",
                  "brand:temp", "brand:type", "temp:type",
                  "brand:temp:type")) 
# type,brand are significant, brand:type is possibly significant

