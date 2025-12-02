# Core Concepts

Understanding the fundamental concepts behind TidyDensity will help you use the package effectively.

## 📋 Table of Contents

- [Tidy Data Philosophy](#tidy-data-philosophy)
- [Probability Distributions](#probability-distributions)
- [Distribution Functions (d, p, q, r)](#distribution-functions-d-p-q-r)
- [Random Number Generation](#random-number-generation)
- [Parameter Estimation](#parameter-estimation)
- [Statistical Inference](#statistical-inference)
- [Tidyverse Integration](#tidyverse-integration)

---

## 🎯 Tidy Data Philosophy

### What is Tidy Data?

**Tidy data** follows three principles:

1. **Each variable is a column**
2. **Each observation is a row**
3. **Each type of observational unit is a table**

### Why Tidy Data Matters

```r
# Traditional approach (base R)
x <- rnorm(100)
# Just a vector - limited functionality

# TidyDensity approach
data <- tidy_normal(.n = 100)
# A tibble with structure:
# - sim_number: simulation ID
# - x: observation number
# - y: random value
# - dx, dy: density values
# - p: cumulative probability
# - q: quantile
```

### Benefits of Tidy Format

**1. Pipeable:**
```r
library(TidyDensity)
library(dplyr)

tidy_normal(.n = 100) |>
  filter(y > 0) |>
  summarise(mean = mean(y), sd = sd(y))
```

**2. Visualization-ready:**
```r
tidy_normal(.n = 100) |>
  tidy_autoplot(.plot_type = "density")
```

**3. Analysis-friendly:**
```r
tidy_normal(.n = 100, .num_sims = 10) |>
  group_by(sim_number) |>
  summarise(mean = mean(y))
```

---

## 📊 Probability Distributions

### What is a Probability Distribution?

A probability distribution describes how values of a random variable are distributed.

### Types of Distributions

#### Continuous Distributions

**Values can take any real number within a range:**

```r
# Normal distribution
tidy_normal(.n = 100, .mean = 0, .sd = 1)
# Can produce: -2.34, 0.52, 1.89, etc.

# Uniform distribution
tidy_uniform(.n = 100, .min = 0, .max = 1)
# Can produce: 0.234, 0.789, 0.456, etc.
```

#### Discrete Distributions

**Values can only take specific integers:**

```r
# Poisson distribution
tidy_poisson(.n = 100, .lambda = 5)
# Can only produce: 3, 5, 7, etc. (whole numbers)

# Binomial distribution
tidy_binomial(.n = 100, .size = 10, .prob = 0.5)
# Can only produce: 0, 1, 2, ..., 10
```

### Distribution Characteristics

**Location (Center):**
- Where the distribution is centered
- Examples: mean, median, mode

**Scale (Spread):**
- How spread out the values are
- Examples: standard deviation, variance, IQR

**Shape:**
- Form of the distribution
- Examples: skewness, kurtosis, modality

```r
# Normal: Symmetric, bell-shaped
tidy_normal(.n = 100, .mean = 0, .sd = 1)

# Gamma: Right-skewed
tidy_gamma(.n = 100, .shape = 2, .scale = 1)

# Uniform: Flat, all values equally likely
tidy_uniform(.n = 100, .min = 0, .max = 1)
```

---

## 🔢 Distribution Functions (d, p, q, r)

Every probability distribution has four related functions:

### 1. Density Function (d)

**Probability Density Function (PDF) for continuous distributions:**
- How likely is a specific value?
- In TidyDensity: `dy` column

```r
data <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
# dy column contains density values
```

**Probability Mass Function (PMF) for discrete distributions:**
- Probability of each specific value
- In TidyDensity: `dy` column

### 2. Probability Function (p)

**Cumulative Distribution Function (CDF):**
- What's the probability of getting a value ≤ x?
- In TidyDensity: `p` column

```r
data <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
# p column contains cumulative probabilities
# p = 0.5 means 50% of values are below this point
```

### 3. Quantile Function (q)

**Inverse of CDF (Quantile Function):**
- What value corresponds to a given probability?
- In TidyDensity: `q` column

```r
data <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
# q column contains quantile values
# q at p=0.5 gives the median
```

### 4. Random Generation Function (r)

**Generate random values:**
- Simulate data from the distribution
- In TidyDensity: `y` column

```r
data <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
# y column contains randomly generated values
```

### Visual Comparison

```r
library(patchwork)

data <- tidy_normal(.n = 100, .num_sims = 1)

# Density plot (d function)
p1 <- tidy_autoplot(data, .plot_type = "density")

# CDF plot (p function)
p2 <- tidy_autoplot(data, .plot_type = "probability")

# Quantile plot (q function)
p3 <- tidy_autoplot(data, .plot_type = "quantile")

# Combined view
(p1 | p2) / p3
```

---

## 🎲 Random Number Generation

### Pseudorandom Numbers

**Computer-generated "random" numbers are actually pseudorandom:**
- Deterministic algorithm
- Appears random but reproducible with same seed
- Good enough for most applications

### Setting Seeds for Reproducibility

```r
# Set seed for reproducible results
set.seed(123)
data1 <- tidy_normal(.n = 10)

set.seed(123)
data2 <- tidy_normal(.n = 10)

# data1 and data2 are identical
all.equal(data1$y, data2$y)  # TRUE
```

### Multiple Simulations

**Why use multiple simulations?**

```r
# Single simulation - might not represent true distribution
single <- tidy_normal(.n = 100, .num_sims = 1)

# Multiple simulations - better understanding of variability
multiple <- tidy_normal(.n = 100, .num_sims = 20)
```

**Use cases:**
- Assess sampling variability
- Monte Carlo simulation
- Sensitivity analysis
- Uncertainty quantification

---

## 📈 Parameter Estimation

### What is Parameter Estimation?

**Goal:** Estimate distribution parameters from observed data

```r
# Observed data
observed <- c(10.2, 9.8, 10.5, 10.1, 9.9)

# Estimate parameters
fit <- util_normal_param_estimate(observed)

# Get estimates
fit$parameter_tbl
# Returns: mean ≈ 10.1, sd ≈ 0.29
```

### Estimation Methods

#### Maximum Likelihood Estimation (MLE)

**Concept:** Find parameters that maximize probability of observing the data

**Characteristics:**
- Asymptotically efficient
- Best for large samples (n > 30)
- Most commonly used

```r
fit <- util_normal_param_estimate(data)
mle_estimates <- fit$parameter_tbl |>
   filter(grepl("MME|MLE", method))
```

#### Method of Moments Estimation (MME)

**Concept:** Match sample moments to theoretical moments

**Characteristics:**
- Simpler computation
- Often same as MLE for common distributions
- Intuitive approach

#### Minimum Variance Unbiased Estimation (MVUE)

**Concept:** Unbiased estimates with minimum variance

**Characteristics:**
- Best for small samples
- Corrects for small-sample bias
- Theoretically optimal when available

```r
fit <- util_normal_param_estimate(data$y)
mvue_estimates <- fit$parameter_tbl |>
   filter(grepl("MVU", method))
```

### Model Selection

**Akaike Information Criterion (AIC):**
- Balances fit quality with model complexity
- Lower AIC = better model
- Used to compare distributions

```r
# Compare multiple distributions
normal_aic <- util_normal_aic(.x = data$y)
cauchy_aic <- util_cauchy_aic(.x = data$y)
logistic_aic <- util_logistic_aic(.x = data$y)

# Choose distribution with lowest AIC
best_model <- which.min(c(normal_aic, cauchy_aic, logistic_aic))
print(best_model)
```

---

## 🔬 Statistical Inference

### Hypothesis Testing

**Using distributions for hypothesis tests:**

```r
# Test if sample mean differs from 0
observed_data <- rnorm(100, mean = 0.5, sd = 1)

# Generate null distribution
null_dist <- tidy_normal(.n = 100, .mean = 0, .sd = 1, .num_sims = 1000)

# Calculate test statistic
observed_mean <- mean(observed_data)

# P-value: proportion of null dist more extreme than observed
p_value <- mean(abs(null_dist$y) >= abs(observed_mean))

cat("The mean of observed data is:", observed_mean, "\n")
cat("The p-value is:", p_value)
```

### Confidence Intervals

**Bootstrap confidence intervals:**

```r
# Bootstrap resampling
boot_data <- tidy_bootstrap(.x = observed_data, .num_sims = 2000)

# Calculate 95% CI
ci <- boot_data |>
  bootstrap_unnest_tbl() |>
  summarise(
    lower = quantile(y, 0.025),
    upper = quantile(y, 0.975)
  )

cat("95% Confidence Interval:", ci$lower, "to", ci$upper)
```

### Power Analysis

**Determining required sample size:**

```r
# Simulate to estimate power
simulate_test <- function(n, effect_size, alpha = 0.05) {
  group1 <- rnorm(n, mean = 0, sd = 1)
  group2 <- rnorm(n, mean = effect_size, sd = 1)
  t.test(group1, group2)$p.value < alpha
}

# Run many simulations
n_sims <- 1000
power <- mean(replicate(n_sims, simulate_test(n = 50, effect_size = 0.5)))
cat("Power:", power)
```

---

## 🔗 Tidyverse Integration

### Works with dplyr

```r
tidy_normal(.n = 100, .num_sims = 5) |>
  group_by(sim_number) |>
  summarise(
    mean = mean(y),
    sd = sd(y),
    median = median(y)
  ) %>%
  arrange(desc(mean))
```

### Works with ggplot2

```r
library(ggplot2)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Custom ggplot
ggplot(data, aes(x = y, color = sim_number)) +
  geom_density() +
  theme_minimal()

# Or use built-in
tidy_autoplot(data, .plot_type = "density")
```

### Works with tidyr

```r
library(tidyr)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Widen data
wide_data <- data %>%
  select(sim_number, x, y) %>%
  pivot_wider(names_from = sim_number, values_from = y, names_prefix = "sim_")

head(wide_data)
```

### Works with purrr

```r
library(purrr)

# Generate multiple distributions
distributions <- list(
  normal = tidy_normal(.n = 100),
  gamma = tidy_gamma(.n = 100, .shape = 2, .scale = 1),
  beta = tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)
)

# Map over distributions
distributions |>
  map(~ summarise(., mean = mean(y), sd = sd(y)))
```

---

## 🎓 Key Takeaways

### 1. Tidy Format Enables Analysis
Every TidyDensity function returns a structured tibble that works with tidyverse tools.

### 2. Four Functions (d, p, q, r)
Understanding these four functions is key to working with distributions.

### 3. Multiple Methods Available
Use MLE for large samples, MVUE for small samples, compare with AIC.

### 4. Reproducibility Matters
Always set seed for reproducible random number generation.

### 5. Visualization is Essential
Always plot your data and fitted distributions to validate assumptions.

---

## 📚 Further Reading

- **Distributions**: [Supported Distributions](Supported-Distributions.md) - Complete list
- **Estimation**: [Parameter Estimation](Parameter-Estimation.md) - Detailed guide
- **Visualization**: [Visualization and Plotting](Visualization-and-Plotting.md) - Plotting techniques
- **Examples**: [Examples and Use Cases](Examples-and-Use-Cases.md) - Real-world applications

---

**Ready to apply these concepts?** Check out [Installation and Quick Start](Installation-and-Quick-Start.md) to begin!
