# Bootstrap Analysis

Bootstrap resampling is a powerful statistical technique for robust inference. TidyDensity provides integrated bootstrap functionality with seamless visualization and analysis tools.

## 📋 Table of Contents

- [What is Bootstrap?](#what-is-bootstrap)
- [Bootstrap in TidyDensity](#bootstrap-in-tidydensity)
- [Basic Bootstrap Analysis](#basic-bootstrap-analysis)
- [Bootstrap Statistics](#bootstrap-statistics)
- [Confidence Intervals](#confidence-intervals)
- [Bootstrap Augmentation Functions](#bootstrap-augmentation-functions)
- [Advanced Bootstrap Techniques](#advanced-bootstrap-techniques)
- [Visualization](#visualization)
- [Best Practices](#best-practices)

---

## 🎯 What is Bootstrap?

### Concept

**Bootstrap resampling** is a non-parametric method for:
- Estimating sampling distributions
- Calculating confidence intervals
- Assessing parameter uncertainty
- Making inferences without distributional assumptions

### How It Works

1. **Resample** your data with replacement
2. **Calculate** statistic of interest for each resample
3. **Repeat** process many times (typically 1000-10000)
4. **Analyze** distribution of bootstrap statistics

### When to Use Bootstrap

- ✅ Unknown or complex sampling distributions
- ✅ Small to medium sample sizes
- ✅ When parametric assumptions questionable
- ✅ For robust confidence intervals
- ✅ Complex statistics (median, trimmed mean, etc.)

---

## 🔧 Bootstrap in TidyDensity

### Main Function: `tidy_bootstrap()`

Generate bootstrap samples in tidy format:

```r
tidy_bootstrap(
  .x,                    # Your data vector
  .num_sims = 2000,      # Number of bootstrap samples
  .proportion = 1,       # Proportion to sample (default = 1)
  .distribution_type = "continuous"  # continuous or discrete
)
```

### Return Value

Returns a tidy tibble with:
- `sim_number` - Bootstrap sample identifier
- `x` - Observation index
- `y` - Bootstrapped value
- Additional density, probability, and quantile columns

---

## 💻 Basic Bootstrap Analysis

### Simple Bootstrap Example

```r
library(TidyDensity)
library(dplyr)

# Your data
data <- mtcars$mpg

# Perform bootstrap
bootstrap_data <- tidy_bootstrap(
  .x = data,
  .num_sims = 2000
)

# View structure
head(bootstrap_data)
```

### Visualizing Bootstrap Distribution

```r
# Density plot of bootstrap distribution
tidy_autoplot(bootstrap_data, .plot_type = "density")

# Probability plot
tidy_autoplot(bootstrap_data, .plot_type = "probability")

# Quantile plot
tidy_autoplot(bootstrap_data, .plot_type = "quantile")
```

### Quick Statistics

```r
# Get basic statistics
summary(bootstrap_data$y)

# Count simulations
length(unique(bootstrap_data$sim_number))
```

---

## 📊 Bootstrap Statistics

### Unnesting Bootstrap Data

Use `bootstrap_unnest_tbl()` to work with bootstrap samples:

```r
# Unnest the bootstrap data
unnested <- bootstrap_data %>%
  bootstrap_unnest_tbl()

# Now you can calculate statistics
head(unnested)
```

### Calculating Bootstrap Statistics

```r
library(dplyr)

# Calculate statistics for each bootstrap sample
bootstrap_stats <- bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  group_by(sim_number) %>%
  summarise(
    mean = mean(y),
    median = median(y),
    sd = sd(y),
    q25 = quantile(y, 0.25),
    q75 = quantile(y, 0.75)
  )

# View distribution of means
summary(bootstrap_stats$mean)
hist(bootstrap_stats$mean, main = "Bootstrap Distribution of Mean")
```

### Overall Bootstrap Statistics

```r
# Calculate overall statistics from all bootstrap samples
overall_stats <- bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  summarise(
    mean_est = mean(y),
    sd_est = sd(y),
    median_est = median(y),
    skewness = moments::skewness(y),
    kurtosis = moments::kurtosis(y)
  )

overall_stats
```

---

## 📐 Confidence Intervals

### Bootstrap Percentile Method

Most common and intuitive method:

```r
# Calculate 95% confidence intervals
ci_level <- 0.95
alpha <- 1 - ci_level

bootstrap_ci <- bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  summarise(
    lower_ci = quantile(y, alpha/2),
    upper_ci = quantile(y, 1 - alpha/2),
    point_estimate = mean(y)
  )

bootstrap_ci
```

### Confidence Intervals for Multiple Statistics

```r
# Calculate CI for mean, median, and sd
ci_stats <- bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  group_by(sim_number) %>%
  summarise(
    mean = mean(y),
    median = median(y),
    sd = sd(y)
  ) %>%
  summarise(
    across(
      everything(),
      list(
        lower = ~quantile(., 0.025),
        estimate = ~mean(.),
        upper = ~quantile(., 0.975)
      )
    )
  )

ci_stats
```

### Bias-Corrected Accelerated (BCa) Intervals

For more sophisticated intervals:

```r
library(boot)

# Define statistic function
stat_fun <- function(data, indices) {
  mean(data[indices])
}

# Perform bootstrap using boot package
boot_result <- boot(data, stat_fun, R = 2000)

# Calculate BCa intervals
boot.ci(boot_result, type = "bca")
```

### Visualizing Confidence Intervals

```r
library(ggplot2)

# Create visualization
bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  ggplot(aes(x = y)) +
  geom_density(fill = "lightblue", alpha = 0.5) +
  geom_vline(xintercept = quantile(bootstrap_data$y, 0.025), 
             linetype = "dashed", color = "red") +
  geom_vline(xintercept = quantile(bootstrap_data$y, 0.975), 
             linetype = "dashed", color = "red") +
  geom_vline(xintercept = mean(bootstrap_data$y), 
             linetype = "solid", color = "darkblue", size = 1) +
  labs(
    title = "Bootstrap Distribution with 95% CI",
    x = "Bootstrap Statistic",
    y = "Density"
  ) +
  theme_minimal()
```

---

## 🔬 Bootstrap Augmentation Functions

### Augment Density

Add density calculations to bootstrap data:

```r
# Augment with density information
augmented_density <- bootstrap_data %>%
  tidy_bootstrap_density_augment()

head(augmented_density)
```

### Augment Probability

Add cumulative probability:

```r
# Augment with probability information
augmented_prob <- bootstrap_data %>%
  tidy_bootstrap_p_augment()

head(augmented_prob)
```

### Augment Quantile

Add quantile information:

```r
# Augment with quantile information
augmented_quantile <- bootstrap_data %>%
  tidy_bootstrap_q_augment()

head(augmented_quantile)
```

---

## 🎨 Advanced Bootstrap Techniques

### Bootstrap for Difference of Means

```r
# Two groups
group1 <- mtcars$mpg[mtcars$am == 0]
group2 <- mtcars$mpg[mtcars$am == 1]

# Bootstrap function for difference
bootstrap_diff <- function(n_sims = 2000) {
  diffs <- numeric(n_sims)
  
  for (i in 1:n_sims) {
    boot_g1 <- sample(group1, length(group1), replace = TRUE)
    boot_g2 <- sample(group2, length(group2), replace = TRUE)
    diffs[i] <- mean(boot_g2) - mean(boot_g1)
  }
  
  return(diffs)
}

# Run bootstrap
diff_dist <- bootstrap_diff(2000)

# Calculate CI
quantile(diff_dist, c(0.025, 0.975))

# Visualize
hist(diff_dist, main = "Bootstrap Distribution of Difference in Means",
     xlab = "Difference in Means", breaks = 50)
abline(v = quantile(diff_dist, c(0.025, 0.975)), 
       col = "red", lty = 2)
```

### Bootstrap for Regression Coefficients

```r
# Fit model
model <- lm(mpg ~ wt + hp, data = mtcars)

# Bootstrap function
boot_coef <- function(n_sims = 2000) {
  coefs <- matrix(NA, nrow = n_sims, ncol = 3)
  
  for (i in 1:n_sims) {
    boot_indices <- sample(nrow(mtcars), replace = TRUE)
    boot_data <- mtcars[boot_indices, ]
    boot_model <- lm(mpg ~ wt + hp, data = boot_data)
    coefs[i, ] <- coef(boot_model)
  }
  
  colnames(coefs) <- names(coef(model))
  return(coefs)
}

# Run bootstrap
boot_results <- boot_coef(2000)

# CI for each coefficient
apply(boot_results, 2, quantile, probs = c(0.025, 0.975))
```

### Bootstrap for Correlation

```r
# Original correlation
cor_original <- cor(mtcars$mpg, mtcars$wt)

# Bootstrap correlations
boot_cor <- function(x, y, n_sims = 2000) {
  cors <- numeric(n_sims)
  n <- length(x)
  
  for (i in 1:n_sims) {
    indices <- sample(n, replace = TRUE)
    cors[i] <- cor(x[indices], y[indices])
  }
  
  return(cors)
}

# Run bootstrap
cor_dist <- boot_cor(mtcars$mpg, mtcars$wt, 2000)

# CI for correlation
cor_ci <- quantile(cor_dist, c(0.025, 0.975))
cat("95% CI for correlation:", cor_ci, "\n")

# Visualize
hist(cor_dist, main = "Bootstrap Distribution of Correlation",
     xlab = "Correlation Coefficient", breaks = 50)
abline(v = cor_ci, col = "red", lty = 2)
abline(v = cor_original, col = "blue", lwd = 2)
```

### Stratified Bootstrap

For grouped data:

```r
# Stratified bootstrap by group
stratified_bootstrap <- function(data, group_var, value_var, n_sims = 2000) {
  results <- list()
  
  for (i in 1:n_sims) {
    boot_sample <- data %>%
      group_by({{ group_var }}) %>%
      slice_sample(prop = 1, replace = TRUE) %>%
      ungroup()
    
    results[[i]] <- boot_sample %>%
      summarise(mean_value = mean({{ value_var }}))
  }
  
  bind_rows(results, .id = "sim")
}

# Example
library(dplyr)
boot_strat <- stratified_bootstrap(mtcars, am, mpg, n_sims = 1000)
```

---

## 📈 Visualization

### Multiple Visualizations

```r
library(patchwork)

# Generate bootstrap data
boot_data <- tidy_bootstrap(mtcars$mpg, .num_sims = 2000)

# Create multiple plots
p1 <- tidy_autoplot(boot_data, .plot_type = "density")
p2 <- tidy_autoplot(boot_data, .plot_type = "probability")
p3 <- tidy_autoplot(boot_data, .plot_type = "quantile")
p4 <- tidy_autoplot(boot_data, .plot_type = "qq")

# Combine
(p1 | p2) / (p3 | p4)
```

### Interactive Bootstrap Visualization

```r
# Interactive plot
tidy_autoplot(boot_data, .plot_type = "density", .interactive = TRUE)
```

### Custom Visualization with CI

```r
library(ggplot2)

# Calculate statistics
ci <- quantile(boot_data$y, c(0.025, 0.5, 0.975))

# Create plot
ggplot(data.frame(y = boot_data$y), aes(x = y)) +
  geom_density(fill = "skyblue", alpha = 0.5) +
  geom_vline(xintercept = ci[1], linetype = "dashed", color = "red") +
  geom_vline(xintercept = ci[2], linetype = "solid", color = "darkblue", size = 1.5) +
  geom_vline(xintercept = ci[3], linetype = "dashed", color = "red") +
  annotate("text", x = ci[1], y = 0, label = "2.5%", vjust = -1) +
  annotate("text", x = ci[2], y = 0, label = "Median", vjust = -1) +
  annotate("text", x = ci[3], y = 0, label = "97.5%", vjust = -1) +
  labs(
    title = "Bootstrap Distribution with Confidence Interval",
    x = "Statistic Value",
    y = "Density"
  ) +
  theme_minimal()
```

---

## 💡 Best Practices

### 1. Choose Appropriate Number of Simulations

```r
# General guidelines:
# - Exploratory: 1000 simulations
# - Standard analysis: 2000-5000 simulations
# - Publication/Critical: 10000+ simulations

# Quick check
bootstrap_quick <- tidy_bootstrap(data, .num_sims = 1000)

# Standard analysis
bootstrap_standard <- tidy_bootstrap(data, .num_sims = 2000)

# High precision
bootstrap_precise <- tidy_bootstrap(data, .num_sims = 10000)
```

### 2. Verify Bootstrap Convergence

```r
# Check stability with different numbers of simulations
n_sims_vec <- c(500, 1000, 2000, 5000)
convergence <- data.frame(
  n_sims = n_sims_vec,
  mean_est = NA,
  ci_lower = NA,
  ci_upper = NA
)

for (i in seq_along(n_sims_vec)) {
  boot <- tidy_bootstrap(data, .num_sims = n_sims_vec[i])
  stats <- boot %>%
    bootstrap_unnest_tbl() %>%
    summarise(
      mean = mean(y),
      lower = quantile(y, 0.025),
      upper = quantile(y, 0.975)
    )
  
  convergence[i, 2:4] <- as.numeric(stats)
}

convergence
```

### 3. Consider Sample Size

```r
n <- length(data)

if (n < 20) {
  warning("Small sample size. Bootstrap may be unreliable.")
  message("Consider: n >= 30 for bootstrap")
}

if (n < 10) {
  stop("Sample size too small for meaningful bootstrap.")
}
```

### 4. Check for Independence

Bootstrap assumes independent observations:

```r
# If time series or spatial data, consider block bootstrap
# or other specialized methods

# For independent data:
bootstrap_data <- tidy_bootstrap(data, .num_sims = 2000)
```

### 5. Understand Limitations

**Bootstrap works well for:**
- Means, medians, quantiles
- Standard errors
- Confidence intervals

**Bootstrap may struggle with:**
- Extreme values (min/max)
- Very small samples
- Heavily dependent data
- Some complex statistics

---

## 🔍 Troubleshooting

### Issue: CI Too Wide

**Causes:**
- High variability in data
- Small sample size
- Insufficient bootstrap samples

**Solutions:**
```r
# Increase bootstrap samples
tidy_bootstrap(data, .num_sims = 10000)

# Check data variability
sd(data) / mean(data)  # Coefficient of variation

# Collect more data if possible
```

### Issue: Biased Estimates

**Solution:** Use bias-corrected methods

```r
library(boot)

# BCa intervals correct for bias
boot_result <- boot(data, function(d, i) mean(d[i]), R = 2000)
boot.ci(boot_result, type = "bca")
```

### Issue: Long Computation Time

**Solutions:**
```r
# Reduce number of simulations for exploration
tidy_bootstrap(data, .num_sims = 1000)

# Use parallel processing (outside TidyDensity)
library(parallel)
cl <- makeCluster(detectCores() - 1)
# ... parallel bootstrap code ...
stopCluster(cl)
```

---

## 🎓 Next Steps

- **[Advanced Features](Advanced-Features.md)** - Mixture models and more
- **[Parameter Estimation](Parameter-Estimation.md)** - Combine with bootstrap
- **[Examples and Use Cases](Examples-and-Use-Cases.md)** - Real-world applications

---

**Ready for more?** Check out [Advanced Features](Advanced-Features.md) or [Examples and Use Cases](Examples-and-Use-Cases.md)!
