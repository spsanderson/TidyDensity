# FAQ and Troubleshooting

Common questions and solutions for working with TidyDensity.

## 📋 Table of Contents

- [General Questions](#general-questions)
- [Installation Issues](#installation-issues)
- [Distribution Selection](#distribution-selection)
- [Parameter Estimation](#parameter-estimation)
- [Plotting and Visualization](#plotting-and-visualization)
- [Performance Issues](#performance-issues)
- [Data Format Questions](#data-format-questions)
- [Error Messages](#error-messages)

---

## ❓ General Questions

### What is TidyDensity?

TidyDensity is an R package for generating random data from 35+ probability distributions in a tidy tibble format, with integrated visualization and parameter estimation capabilities.

### Do I need to know statistics to use TidyDensity?

Basic knowledge is helpful, but the package is designed to be accessible:
- **Beginners**: Start with common distributions (normal, uniform)
- **Intermediate**: Explore visualization and parameter estimation
- **Advanced**: Use mixture models, bootstrap, and custom analyses

### What's the difference between TidyDensity and base R stats functions?

**Base R** (`rnorm()`, `rgamma()`, etc.):
- Returns simple vectors
- Separate functions for density, probability, quantile
- Requires manual plotting

**TidyDensity**:
- Returns tidy tibbles with all components
- Integrated visualization with `tidy_autoplot()`
- Seamless tidyverse integration
- Built-in parameter estimation

### Which distribution should I use for my data?

See our [Distribution Selection Guide](#which-distribution-should-i-use) below.

---

## 💻 Installation Issues

### Package won't install from CRAN

```r
# Try with dependencies
install.packages("TidyDensity", dependencies = TRUE)

# If that fails, check R version
R.version

# TidyDensity requires R >= 4.1.0
# Upgrade R if needed
```

### Development version installation fails

```r
# Install devtools first
install.packages("devtools")

# Then install TidyDensity
devtools::install_github("spsanderson/TidyDensity")

# If still fails, try with dependencies
devtools::install_github("spsanderson/TidyDensity", dependencies = TRUE)
```

### Missing dependencies error

```r
# Install required packages
install.packages(c(
  "dplyr", "ggplot2", "tidyr", "purrr", "magrittr",
  "rlang", "plotly", "actuar", "survival", "nloptr",
  "broom", "patchwork"
))
```

### Package loads but functions don't work

```r
# Detach and reload
detach("package:TidyDensity", unload = TRUE)
library(TidyDensity)

# Check package version
packageVersion("TidyDensity")

# Reinstall if needed
remove.packages("TidyDensity")
install.packages("TidyDensity")
```

---

## 🎯 Distribution Selection

### Which distribution should I use?

**By Data Type:**

**Continuous Positive Data:**
```r
# Symmetric: Normal, Log-Normal
# Right-skewed: Gamma, Weibull, Exponential
# Heavy tails: Cauchy, Pareto
```

**Bounded Data (0 to 1):**
```r
# Beta distribution
tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)
```

**Count Data:**
```r
# Simple counts: Poisson
# Overdispersed counts: Negative Binomial
# Binary outcomes: Bernoulli, Binomial
```

**Unknown Distribution:**
```r
# Start with empirical
tidy_empirical(.x = your_data)

# Then compare multiple distributions
util_distribution_comparison(.x = your_data)
```

### How do I compare distributions?

```r
# Method 1: Visual comparison
normal_fit <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)
normal_fit$combined_data_tbl %>% tidy_combined_autoplot()

gamma_fit <- util_gamma_param_estimate(data, .auto_gen_empirical = TRUE)
gamma_fit$combined_data_tbl %>% tidy_combined_autoplot()

# Method 2: AIC comparison
aics <- c(
  normal = util_normal_aic(.x = data),
  gamma = util_gamma_aic(.x = data),
  lognormal = util_lognormal_aic(.x = data)
)

# Lower AIC is better
best_model <- names(which.min(aics))
```

### My data doesn't match any standard distribution

**Options:**

1. **Use empirical distribution:**
```r
tidy_empirical(.x = your_data, .num_sims = 1)
```

2. **Try mixture models:**
```r
# For bimodal or multimodal data
comp1 <- tidy_normal(.n = 100, .mean = -2, .sd = 1)
comp2 <- tidy_normal(.n = 100, .mean = 2, .sd = 1)
mixture <- tidy_mixture_density(.tbl_list = list(comp1, comp2), .mixture_type = "add")
```

3. **Transform your data:**
```r
# Log transform for positive skewed data
log_data <- log(your_data)
fit <- util_normal_param_estimate(log_data)
```

---

## 📊 Parameter Estimation

### Estimates don't seem reasonable

**Check your data:**
```r
# Look for outliers
summary(data)
boxplot(data)

# Check for data entry errors
hist(data)

# Remove outliers if appropriate
Q1 <- quantile(data, 0.25)
Q3 <- quantile(data, 0.75)
IQR_val <- Q3 - Q1
clean_data <- data[data >= (Q1 - 1.5*IQR_val) & data <= (Q3 + 1.5*IQR_val)]
```

### MLE and MVUE estimates are very different

This is expected for small samples:
```r
n <- length(data)

if (n < 30) {
  message("Small sample: Use MVUE estimates")
  message("MVUE corrects for small-sample bias")
}

# For large samples, they should converge
if (n >= 100) {
  message("Large sample: MLE and MVUE should be similar")
  message("If very different, check data quality")
}
```

### Parameter estimation fails

**Common causes:**

1. **Insufficient data:**
```r
if (length(data) < 10) {
  stop("Need at least 10 observations for reliable estimation")
}
```

2. **Wrong distribution:**
```r
# Check data characteristics
summary(data)
min(data)  # Should be positive for gamma, exponential, etc.
```

3. **Numerical issues:**
```r
# Try scaling data
scaled_data <- scale(data)
fit <- util_normal_param_estimate(as.numeric(scaled_data))
```

---

## 📈 Plotting and Visualization

### Plots don't appear

```r
# Explicitly print the plot
p <- tidy_autoplot(data, .plot_type = "density")
print(p)

# Check graphics device
dev.cur()

# If issues, reset graphics device
dev.off()
```

### Plot legend is cluttered

```r
# Use more simulations (>9) to auto-hide legend
data <- tidy_normal(.n = 100, .num_sims = 15)
tidy_autoplot(data, .plot_type = "density")

# Or manually hide legend
tidy_autoplot(data, .plot_type = "density") +
  theme(legend.position = "none")
```

### Interactive plots won't display

```r
# Install plotly
install.packages("plotly")
library(plotly)

# Then create interactive plot
tidy_autoplot(data, .plot_type = "density", .interactive = TRUE)
```

### Plots look different than examples

```r
# Check ggplot2 version
packageVersion("ggplot2")

# Update if needed
install.packages("ggplot2")

# Also check TidyDensity version
packageVersion("TidyDensity")
```

### How do I save high-quality plots?

```r
library(ggplot2)

# Create plot
p <- tidy_autoplot(data, .plot_type = "density")

# Save high resolution
ggsave("my_plot.png", p, width = 10, height = 6, dpi = 300)

# Save vector format (publication quality)
ggsave("my_plot.pdf", p, width = 10, height = 6)
ggsave("my_plot.svg", p, width = 10, height = 6)
```

---

## ⚡ Performance Issues

### Functions are running slowly

**For bootstrap:**
```r
# Reduce number of simulations for testing
boot_test <- tidy_bootstrap(.x = data, .num_sims = 1000)  # Fast

# Increase for final analysis
boot_final <- tidy_bootstrap(.x = data, .num_sims = 10000)  # Slower but more accurate
```

**For visualizations:**
```r
# Reduce number of simulations
quick_viz <- tidy_normal(.n = 100, .num_sims = 5)  # Fast
final_viz <- tidy_normal(.n = 100, .num_sims = 50)  # Slower
```

**For large datasets:**
```r
# Sample your data
if (length(data) > 10000) {
  sampled_data <- sample(data, 5000)
  fit <- util_normal_param_estimate(sampled_data)
}
```

### Memory issues with large simulations

```r
# Generate data in batches
n_total_sims <- 10000
batch_size <- 1000
n_batches <- n_total_sims / batch_size

results <- list()
for (i in 1:n_batches) {
  results[[i]] <- tidy_normal(.n = 100, .num_sims = batch_size)
}

# Combine
all_results <- bind_rows(results)
```

---

## 📝 Data Format Questions

### What format should my data be in?

**Input data:**
```r
# Simple numeric vector
data <- c(1.2, 3.4, 5.6, 2.1, 4.5)

# From data frame
data <- mtcars$mpg

# From tibble
data <- my_tibble %>% pull(my_column)
```

**Not accepted:**
```r
# Character vectors
data <- c("1", "2", "3")  # Convert: as.numeric(data)

# Data frames
data <- data.frame(x = 1:10)  # Extract: data$x

# Lists
data <- list(1, 2, 3)  # Convert: unlist(data)
```

### How do I convert tidy_ output to other formats?

```r
# Get just the random values
data <- tidy_normal(.n = 100)
values <- data$y

# Get as matrix
values_matrix <- matrix(data$y, ncol = 1)

# Get as time series
ts_data <- ts(data$y)

# Export to CSV
write.csv(data, "my_data.csv", row.names = FALSE)
```

### Can I use TidyDensity output with other packages?

**Yes! The tidy format integrates well:**

```r
library(dplyr)
library(ggplot2)
library(tidyr)

# Generate data
data <- tidy_normal(.n = 100, .num_sims = 5)

# Use dplyr
summary_stats <- data %>%
  group_by(sim_number) %>%
  summarise(
    mean = mean(y),
    sd = sd(y)
  )

# Use ggplot2 directly
ggplot(data, aes(x = y)) +
  geom_density(aes(color = sim_number))
```

---

## ⚠️ Error Messages

### "Error: '.n' must be of class integer"

**Cause:** Non-integer value passed to `.n` parameter

**Solution:**
```r
# Wrong
tidy_normal(.n = 50.5)

# Correct
tidy_normal(.n = 50)
tidy_normal(.n = as.integer(50))
```

### "Error: '.x' must be a numeric vector"

**Cause:** Non-numeric data passed to estimation or bootstrap functions

**Solution:**
```r
# Check data type
class(your_data)

# Convert if needed
your_data <- as.numeric(your_data)

# Remove NA values
your_data <- na.omit(your_data)
```

### "Error: '.x' must contain at least two non-missing distinct values"

**Cause:** Insufficient unique values in data

**Solution:**
```r
# Check unique values
length(unique(your_data))

# Check for missing values
sum(is.na(your_data))

# Ensure sufficient data
if (length(unique(na.omit(your_data))) < 2) {
  stop("Not enough variation in data for estimation")
}
```

### "Error in tidy_autoplot: The .data parameter must be a valid data.frame"

**Cause:** Incorrect input to plotting function

**Solution:**
```r
# Generate data first
data <- tidy_normal(.n = 100)

# Then plot
tidy_autoplot(data, .plot_type = "density")

# Don't pass raw values
# Wrong: tidy_autoplot(c(1,2,3))
```

### "Warning: Removed rows containing missing values"

**Cause:** NA values in your data

**Solution:**
```r
# Remove NAs before analysis
clean_data <- na.omit(your_data)

# Or handle explicitly
if (any(is.na(your_data))) {
  warning("Data contains NAs. Removing...")
  your_data <- na.omit(your_data)
}
```

---

## 🔧 Advanced Troubleshooting

### Reproducibility Issues

**Set seed for reproducible results:**
```r
set.seed(123)
data1 <- tidy_normal(.n = 100)

set.seed(123)
data2 <- tidy_normal(.n = 100)

# data1 and data2 will be identical
all.equal(data1, data2)
```

### Conflicts with Other Packages

```r
# Explicit package references
TidyDensity::tidy_normal(.n = 100)

# Check for conflicts
conflicts(detail = TRUE)

# Load TidyDensity last to avoid conflicts
library(conflicting_package)
library(TidyDensity)  # Load last
```

### Session Info for Bug Reports

```r
# Gather info for bug reports
sessionInfo()

# Package versions
packageVersion("TidyDensity")
packageVersion("ggplot2")
packageVersion("dplyr")
```

---

## 📚 Getting More Help

### Still having issues?

1. **Check the documentation:**
```r
?tidy_normal
?tidy_autoplot
?util_normal_param_estimate
```

2. **Browse package vignettes:**
```r
vignette("getting-started", package = "TidyDensity")
```

3. **Visit the package website:**
   - https://www.spsanderson.com/TidyDensity/

4. **Ask on GitHub:**
   - https://github.com/spsanderson/TidyDensity/issues
   - https://github.com/spsanderson/TidyDensity/discussions

5. **Provide a reproducible example:**
```r
# Good bug report includes:
library(TidyDensity)
set.seed(123)

# Minimal example that reproduces the issue
data <- tidy_normal(.n = 10)
tidy_autoplot(data)  # Error occurs here

# Session info
sessionInfo()
```

---

## 💡 Best Practices to Avoid Issues

### 1. Always Check Your Data First
```r
summary(data)
hist(data)
str(data)
```

### 2. Start Simple
```r
# Test with small examples first
test <- tidy_normal(.n = 10, .num_sims = 2)
tidy_autoplot(test, .plot_type = "density")

# Then scale up
full <- tidy_normal(.n = 1000, .num_sims = 50)
```

### 3. Visualize Early and Often
```r
# Always plot to check
tidy_autoplot(data, .plot_type = "density")
```

### 4. Read Error Messages Carefully
```r
# Error messages usually indicate the problem
# Look for parameter names and requirements
```

### 5. Keep Packages Updated
```r
# Check for updates
update.packages(ask = FALSE)

# Update TidyDensity
install.packages("TidyDensity")
```

---

**Can't find your question?** Ask on [GitHub Discussions](https://github.com/spsanderson/TidyDensity/discussions)!
