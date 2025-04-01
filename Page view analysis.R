#  Prior Product Knowledge & Page View Analysis

# Load dataset
ecomm.df <- read.csv("~/Downloads/ecommerce-data-5 (2).csv")

# 🔹 Compare prior product knowledge between Parents and Teachers
with(subset(ecomm.df, profile %in% c("Parent", "Teacher") & 
              productKnewWhatWanted %in% c("No", "Yes"))
     prop.table(table(profile, productKnewWhatWanted), margin = 1))

# Without proportions
with(subset(ecomm.df, profile %in% c("Parent", "Teacher") & 
              productKnewWhatWanted %in% c("No", "Yes"))
     table(profile, productKnewWhatWanted))

# 🔹 Visualize Product Knowledge by Profile
library(lattice)
with(subset(ecomm.df, profile %in% c("Parent", "Teacher") & 
              productKnewWhatWanted %in% c("No", "Yes"))
     histogram(~ productKnewWhatWanted | profile))

# 🔹 Why limit to Yes/No responses?
# Avoids inflating results with missing or "Somewhat" values

# 🔹 Repeat without filtering to Yes/No
with(subset(ecomm.df, profile %in% c("Parent", "Teacher"))
     prop.table(table(profile, productKnewWhatWanted), margin = 1))

# 🔹 Chi-square test to check if knowledge differs significantly
prod.table <- with(subset(ecomm.df, profile %in% c("Parent", "Teacher") & 
                            productKnewWhatWanted %in% c("No", "Yes"))
                   table(profile, productKnewWhatWanted))

chisq.test(prod.table)

# 🔹 Proportions
prop.table(prod.table, margin = 1)

# 🔹 Binomial Test: Is Teacher rate different from Parent rate?
binom.test(prod.table["Teacher", "Yes"],
           sum(prod.table["Teacher", c("No", "Yes")]),
           p = prop.table(prod.table, margin = 1)["Parent", "Yes"])

# 🔹 Page View Integer Conversion
pageViewInt <- rep(NA, length(ecomm.df$behavPageviews))
pageViewInt[ecomm.df$behavPageviews == "0"] <- 0
pageViewInt[ecomm.df$behavPageviews == "1"] <- 1
pageViewInt[ecomm.df$behavPageviews == "2 to 3"] <- 2
pageViewInt[ecomm.df$behavPageviews == "4 to 6"] <- 4
pageViewInt[ecomm.df$behavPageviews == "7 to 9"] <- 7
pageViewInt[ecomm.df$behavPageviews == "10+"] <- 10
ecomm.df$pageViewInt <- pageViewInt
rm(pageViewInt)

# 🔹 Compare Page View Means: Parents vs Teachers
with(subset(ecomm.df, profile %in% c("Parent", "Teacher"))
     t.test(pageViewInt ~ profile))

# 🔹 One-way ANOVA across all profiles
library(multcomp)
prof.aov <- aov(pageViewInt ~ profile, data = ecomm.df)
anova(prof.aov)

# 🔹 Multiple Comparisons
summary(glht(prof.aov, linfct = mcp(profile = "Tukey")))

# 🔹 Plot 95% CI for all profile comparisons
par(mar = c(6, 10, 2, 2))
plot(glht(prof.aov), xlab = "Page Views", main = "Average Page Views by Profile (95% CI)")

# 🔹 Repeat ANOVA for only Parents and Teachers
prof.aov2 <- aov(pageViewInt ~ 0 + profile,
                 data = subset(ecomm.df, profile %in% c("Parent", "Teacher")))

# 🔹 Plot CI: Teachers vs Parents
par(mar = c(6, 10, 2, 2))
plot(glht(prof.aov2), xlab = "Page Views",
     main = "Average Page Views – Teachers vs Parents (95% CI)")
