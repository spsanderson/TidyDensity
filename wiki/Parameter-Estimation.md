# Parameter Estimation

TidyDensity provides comprehensive parameter estimation capabilities to fit probability distributions to empirical data using multiple statistical methods.

## 📋 Table of Contents

- [Overview](#overview)
- [Estimation Methods](#estimation-methods)
- [Available Functions](#available-functions)
- [Basic Usage](#basic-usage)
- [Comparing Methods](#comparing-methods)
- [Model Selection with AIC](#model-selection-with-aic)
- [Visualization of Fitted Distributions](#visualization-of-fitted-distributions)
- [Advanced Techniques](#advanced-techniques)
- [Best Practices](#best-practices)

---

## 🎯 Overview

Parameter estimation allows you to:
- **Fit distributions** to your empirical data
- **Estimate distribution parameters** from observed values
- **Compare** theoretical vs empirical distributions
- **Select best-fitting** distribution using AIC
- **Validate** distributional assumptions

### General Pattern

All parameter estimation functions follow this pattern:

```r
util_[distribution]_param_estimate(
  .x,                           # Your data vector
  .auto_gen_empirical = TRUE    # Auto-generate comparison data
)
```

---

## 📊 Estimation Methods

TidyDensity uses three primary estimation methods:

### 1. Maximum Likelihood Estimation (MLE)

**What it is:**
- Finds parameters that maximize the likelihood of observing your data
- Most commonly used method
- Asymptotically efficient

**When to use:**
- Large sample sizes (n > 30)
- When you need optimal statistical properties
- Default choice for most applications

**Characteristics:**
- Asymptotically unbiased
- Minimum variance for large samples
- Requires iterative computation

### 2. Method of Moments Estimation (MME)

**What it is:**
- Matches sample moments (mean, variance) to theoretical moments
- Often produces same results as MLE for common distributions
- Computationally simpler

**When to use:**
- Quick approximations needed
- Educational purposes
- When MLE is computationally expensive

**Characteristics:**
- Easy to compute
- Intuitive interpretation
- May be less efficient than MLE

### 3. Minimum Variance Unbiased Estimation (MVUE)

**What it is:**
- Provides unbiased estimates with minimum variance
- Uses correction factors for small samples
- Often same as MLE for large samples

**When to use:**
- Small sample sizes
- When unbiasedness is critical
- Comparing with MLE

**Characteristics:**
- Unbiased for any sample size
- Minimum variance among unbiased estimators
- May differ from MLE for small samples

---

## 🔧 Available Functions

### Continuous Distributions

| Distribution | Function |
|-------------|----------|
| Normal | `util_normal_param_estimate()` |
| Log-Normal | `util_lognormal_param_estimate()` |
| Exponential | `util_exponential_param_estimate()` |
| Gamma | `util_gamma_param_estimate()` |
| Beta | `util_beta_param_estimate()` |
| Weibull | `util_weibull_param_estimate()` |
| Pareto | `util_pareto_param_estimate()` |
| Cauchy | `util_cauchy_param_estimate()` |
| Logistic | `util_logistic_param_estimate()` |
| Uniform | `util_uniform_param_estimate()` |
| Triangular | `util_triangular_param_estimate()` |
| Chi-Square | `util_chisquare_param_estimate()` |
| F-Distribution | `util_f_param_estimate()` |
| t-Distribution | `util_t_param_estimate()` |
| Generalized Pareto | `util_generalized_pareto_param_estimate()` |
| Generalized Beta | `util_generalized_beta_param_estimate()` |
| Inverse Gamma | `util_inverse_gamma_param_estimate()` |
| Inverse Weibull | `util_inverse_weibull_param_estimate()` |
| Inverse Pareto | `util_inverse_pareto_param_estimate()` |
| Inverse Burr | `util_inverse_burr_param_estimate()` |
| Burr | `util_burr_param_estimate()` |
| Paralogistic | `util_paralogistic_param_estimate()` |

### Discrete Distributions

| Distribution | Function |
|-------------|----------|
| Bernoulli | `util_bernoulli_param_estimate()` |
| Binomial | `util_binomial_param_estimate()` |
| Geometric | `util_geometric_param_estimate()` |
| Hypergeometric | `util_hypergeometric_param_estimate()` |
| Negative Binomial | `util_negative_binomial_param_estimate()` |
| Poisson | `util_poisson_param_estimate()` |
| Zero-Truncated Binomial | `util_zero_truncated_binomial_param_estimate()` |
| Zero-Truncated Geometric | `util_zero_truncated_geometric_param_estimate()` |
| Zero-Truncated Poisson | `util_zero_truncated_poisson_param_estimate()` |
| Zero-Truncated Negative Binomial | `util_zero_truncated_negative_binomial_param_estimate()` |

---

## 💻 Basic Usage

### Simple Parameter Estimation

```r
library(TidyDensity)

# Your empirical data
data <- mtcars$mpg

# Estimate normal distribution parameters
result <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)

# View parameter estimates
result$parameter_tbl
```

**Output:**
```
# A tibble: 2 × 8
  dist_type samp_size   min   max method              mu stan_dev shape_ratio
  <chr>         <int> <dbl> <dbl> <chr>            <dbl>    <dbl>       <dbl>
1 Gaussian         32  10.4  33.9 EnvStats_MME_MLE  20.1     5.93        3.39
2 Gaussian         32  10.4  33.9 EnvStats_MVUE     20.1     6.03        3.33
```

### Understanding the Output

The function returns a list with several components:

```r
names(result$parameter_tbl)
[1] "dist_type"   "samp_size"   "min"         "max"         "method"      "mu"         
[7] "stan_dev"    "shape_ratio"
```

### Visualizing the Fit

```r
# Plot empirical vs fitted distribution
result$combined_data_tbl |>
  tidy_combined_autoplot()
```

This creates a plot comparing:
- Your empirical data (density plot)
- Fitted distribution from MLE/MME
- Fitted distribution from MVUE

---

## 📈 Comparing Methods

### Example: Normal Distribution

```r
# Generate some sample data
set.seed(123)
sample_data <- rnorm(100, mean = 50, sd = 10)

# Estimate parameters
estimates <- util_normal_param_estimate(sample_data)

# View both methods
estimates$parameter_tbl
```

### Understanding Differences

**For Normal Distribution:**
- **MLE/MME**: Uses sample standard deviation with n-1 denominator
- **MVUE**: Corrects for bias in small samples

**When n is large:** MLE and MVUE converge

**When n is small:** MVUE provides better unbiased estimate

### Example: Gamma Distribution

```r
# Generate gamma-distributed data
sample_data <- rgamma(50, shape = 2, rate = 0.5)

# Estimate parameters
estimates <- util_gamma_param_estimate(sample_data, .auto_gen_empirical = TRUE)

# Compare estimates
estimates$parameter_tbl

# Visualize fit
estimates$combined_data_tbl |>
  tidy_combined_autoplot()
```

### Example: Exponential Distribution

```r
# Generate exponential data
sample_data <- rexp(75, rate = 0.5)

# Estimate rate parameter
estimates <- util_exponential_param_estimate(sample_data, .auto_gen_empirical = TRUE)

estimates$parameter_tbl
```

---

## 🎯 Model Selection with AIC

### What is AIC?

**Akaike Information Criterion (AIC)** helps compare different distribution models:
- **Lower AIC = Better fit**
- Balances goodness-of-fit with model complexity
- Used for model selection

### AIC Functions

Pattern: `util_[distribution]_aic()`

```r
# Example data
data <- mtcars$mpg

# Calculate AIC for different distributions
normal_aic <- util_normal_aic(.x = data)
gamma_aic <- util_gamma_aic(.x = data)
lognormal_aic <- util_lognormal_aic(.x = data)
weibull_aic <- util_weibull_aic(.x = data)

# Compare
aic_comparison <- data.frame(
  Distribution = c("Normal", "Gamma", "Log-Normal", "Weibull"),
  AIC = c(normal_aic, gamma_aic, lognormal_aic, weibull_aic)
)

# Sort by AIC (lower is better)
aic_comparison[order(aic_comparison$AIC), ]
```

### Automated Distribution Comparison

```r
# Use util_distribution_comparison for automated comparison
comparison <- tidy_distribution_comparison(.x = data)

# This function tests multiple distributions and returns AIC values
comparison
```

---

## 📊 Visualization of Fitted Distributions

### Basic Visualization

```r
# Estimate parameters
data <- rnorm(100, mean = 50, sd = 10)
fit <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)

# Plot combined (empirical + fitted)
fit$combined_data_tbl |>
  tidy_combined_autoplot()
```

### Customizing the Comparison Plot

```r
library(ggplot2)

# Get the plot
p <- fit$combined_data_tbl |>
  tidy_combined_autoplot()

# Customize
p +
  theme_minimal() +
  labs(
    title = "Empirical vs Fitted Normal Distribution",
    subtitle = "Comparison of MLE/MME and MVUE estimates",
    x = "Value",
    y = "Density"
  )
```

### Multiple Distribution Overlay

```r
# Fit multiple distributions
normal_fit <- util_normal_param_estimate(data, .auto_gen_empirical = FALSE)
gamma_fit <- util_gamma_param_estimate(data, .auto_gen_empirical = FALSE)

# Extract parameters and create comparison
n <- length(data)

# Generate fitted distributions
fitted_normal <- tidy_normal(
  .n = n,
  .mean = normal_fit$parameter_tbl$mu[1],
  .sd = normal_fit$parameter_tbl$stan_dev[1]
)

fitted_gamma <- tidy_gamma(
  .n = n,
  .shape = gamma_fit$parameter_tbl$shape[1],
  .scale = gamma_fit$parameter_tbl$scale[1]
)

# Plot separately or combine
tidy_autoplot(fitted_normal, .plot_type = "density")
tidy_autoplot(fitted_gamma, .plot_type = "density")
```

---

## 🔬 Advanced Techniques

### 1. Bootstrap Confidence Intervals

Combine parameter estimation with bootstrap for confidence intervals:

```r
library(dplyr)

# Your data
data <- mtcars$mpg

# Bootstrap function
bootstrap_params <- function(data, indices) {
  sample_data <- data[indices]
  est <- util_normal_param_estimate(sample_data, .auto_gen_empirical = FALSE)
  c(mean = est$parameter_tbl$mu[1], 
    sd = est$parameter_tbl$stan_dev[1])
}

# Perform bootstrap
library(boot)
boot_results <- boot(data, bootstrap_params, R = 1000)

# Get confidence intervals
boot.ci(boot_results, type = "perc", index = 1)  # For mean
boot.ci(boot_results, type = "perc", index = 2)  # For SD
```

### 2. Goodness-of-Fit Tests

Validate the fitted distribution:

```r
# Fit distribution
data <- rnorm(100, mean = 50, sd = 10)
fit <- util_normal_param_estimate(data, .auto_gen_empirical = FALSE)

# Extract parameters
estimated_mean <- fit$parameter_tbl$mu[1]
estimated_sd <- fit$parameter_tbl$stan_dev[1]

# Kolmogorov-Smirnov test
ks.test(data, "pnorm", mean = estimated_mean, sd = estimated_sd)

# Shapiro-Wilk test (for normality)
shapiro.test(data)
```

### 3. QQ Plot Validation

```r
# Generate data for QQ plot
theoretical <- tidy_normal(
  .n = length(data),
  .mean = estimated_mean,
  .sd = estimated_sd
)

# Create QQ plot
tidy_autoplot(theoretical, .plot_type = "qq")
```

### 4. Residual Analysis

```r
# Calculate residuals
empirical <- tidy_empirical(.x = data, .num_sims = 1)
fitted <- tidy_normal(.n = length(data), .mean = estimated_mean, .sd = estimated_sd)

# Compare values
comparison <- data.frame(
  observed = data,
  expected = fitted$y[1:length(data)],
  residual = data - fitted$y[1:length(data)]
)

# Plot residuals
ggplot(comparison, aes(x = expected, y = residual)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residual Plot", x = "Fitted Values", y = "Residuals")
```

---

## 📋 Statistics Tables

### Distribution Statistics

Get summary statistics for fitted distributions:

```r
# Pattern: util_[distribution]_stats_tbl()

# For normal distribution
util_normal_stats_tbl(tidy_normal()) |>
  glimpse()

# For gamma distribution  
util_gamma_stats_tbl(tidy_gamma()) |>
  glimpse()

# For Poisson distribution
util_poisson_stats_tbl(tidy_poisson()) |>
  glimpse()
```

**Output includes:**
- Mean
- Variance
- Standard deviation
- Skewness
- Kurtosis
- Mode (when applicable)
- Other distribution-specific statistics

---

## 💡 Best Practices

### 1. Always Visualize

```r
# Don't just look at parameters
fit <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)

# Always plot the comparison
fit$combined_data_tbl |>
  tidy_combined_autoplot()
```

### 2. Check Sample Size

```r
n <- length(data)

if (n < 30) {
  message("Small sample size. Consider MVUE estimates.")
  message("Be cautious with MLE asymptotic properties.")
}

if (n < 10) {
  warning("Very small sample. Parameter estimates may be unreliable.")
}
```

### 3. Try Multiple Distributions

```r
# Don't assume a distribution
# Try several and compare AIC

data <- your_data

distributions <- c("normal", "lognormal", "gamma", "weibull")
aic_values <- numeric(length(distributions))

for (i in seq_along(distributions)) {
  aic_func <- get(paste0("util_", distributions[i], "_aic"))
  aic_values[i] <- aic_func(.x = data)
}

best_dist <- distributions[which.min(aic_values)]
message("Best fitting distribution: ", best_dist)
```

### 4. Validate Assumptions

```r
# Check distributional assumptions

# 1. Visual check
fit <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)
fit$combined_data_tbl |>
  tidy_combined_autoplot()

# 2. QQ plot
tidy_normal(.n = length(data), .mean = mean(data), .sd = sd(data)) %>%
  tidy_autoplot(.plot_type = "qq")

# 3. Statistical test
shapiro.test(data)  # For normality
```

### 5. Consider Data Characteristics

**For positive continuous data:**
- Try: Gamma, Weibull, Log-Normal, Exponential

**For bounded data (0 to 1):**
- Try: Beta distribution

**For count data:**
- Try: Poisson, Negative Binomial

**For data with heavy tails:**
- Try: Cauchy, Pareto, t-distribution

### 6. Document Your Process

```r
# Good practice: Document your analysis

# Data source and characteristics
data <- mtcars$mpg
summary(data)

# Try multiple distributions
normal_aic <- util_normal_aic(.x = data)
lognormal_aic <- util_lognormal_aic(.x = data)

# Select best fit
if (normal_aic < lognormal_aic) {
  best_fit <- util_normal_param_estimate(data, .auto_gen_empirical = TRUE)
  message("Normal distribution selected (AIC = ", round(normal_aic, 2), ")")
} else {
  best_fit <- util_lognormal_param_estimate(data, .auto_gen_empirical = TRUE)
  message("Log-normal distribution selected (AIC = ", round(lognormal_aic, 2), ")")
}

# Visualize final fit
best_fit$combined_data_tbl |>
  tidy_combined_autoplot()
```

---

## 🔍 Common Issues and Solutions

### Issue: Parameters Don't Make Sense

**Solution:** Check your data for:
- Outliers
- Incorrect data type
- Missing values
- Inappropriate distribution choice

```r
# Data diagnostics
summary(data)
hist(data)
boxplot(data)
```

### Issue: Large Difference Between MLE and MVUE

**Cause:** Small sample size

**Solution:**
- Use MVUE for small samples
- Collect more data if possible
- Be cautious with interpretations

### Issue: Poor Fit Quality

**Solution:**
- Try different distributions
- Check for mixture distributions
- Consider transforming data
- Look for outliers

```r
# Check fit quality with multiple distributions
comparison <- tidy_distribution_comparison(.x = data)
comparison
```

---

## 🎓 Next Steps

- **[Bootstrap Analysis](Bootstrap-Analysis.md)** - Add robustness to your estimates
- **[Advanced Features](Advanced-Features.md)** - Mixture models and more
- **[Examples and Use Cases](Examples-and-Use-Cases.md)** - Real-world applications

---

**Ready for more advanced techniques?** Continue to [Bootstrap Analysis](Bootstrap-Analysis.md) or [Advanced Features](Advanced-Features.md)!
