# Advanced Features

TidyDensity offers powerful advanced features including mixture models, empirical distributions, random walks, and multi-distribution comparisons.

## 📋 Table of Contents

- [Mixture Models](#mixture-models)
- [Empirical Distributions](#empirical-distributions)
- [Multi-Distribution Comparison](#multi-distribution-comparison)
- [Random Walk Generation](#random-walk-generation)
- [Distribution Combinations](#distribution-combinations)
- [Quantile Normalization](#quantile-normalization)
- [Advanced Plotting](#advanced-plotting)

---

## 🎨 Mixture Models

### What are Mixture Models?

Mixture models combine multiple probability distributions to model complex data patterns:
- **Multimodal** distributions (multiple peaks)
- **Heterogeneous** populations
- **Complex** real-world phenomena

### Creating Mixture Models

#### Basic Mixture Creation

```r
library(TidyDensity)

dist1 <- tidy_normal(.n = 100, .mean = -2, .sd = 0.5)
dist2 <- tidy_normal(.n = 100, .mean = 2, .sd = 0.5)

# Create mixture
mixture <- tidy_mixture_density(
  dist1,
  dist2,
  .combination_type = "add"
)

# Visualize
mixture$plots
```

### Mixture Types

#### 1. Addition Mixture (`"add"`)

Combines distributions by adding their densities:

```r
mixture_add <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "add"
)
```

**Use Case:** Modeling populations with two distinct groups

#### 2. Multiplication Mixture (`"multiply"`)

Multiplies distributions:

```r
mixture_mult <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "multiply"
)
```

**Use Case:** Modeling joint effects or constraints

#### 3. Subtraction Mixture (`"subtract"`)

Subtracts second from first:

```r
mixture_sub <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "subtract"
)
```

**Use Case:** Modeling differences between groups

#### 4. Division Mixture (`"divide"`)

Divides first by second:

```r
mixture_div <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "divide"
)
```

**Use Case:** Ratios of distributions

#### 5. Stack Mixture (`"stack"`)

Stacks distributions vertically:

```r
mixture_stack <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "stack"
)
```

**Use Case:** Combining separate populations side-by-side

### Complex Mixture Example

```r
# Three-component mixture
dist1 <- tidy_normal(.n = 100, .mean = -3, .sd = 0.5)
dist2 <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
dist3 <- tidy_normal(.n = 100, .mean = 3, .sd = 0.5)

# Create mixture
complex_mixture <- tidy_mixture_density(
  dist1, dist2, dist3,
  .combination_type = "add"
)

# Visualize
complex_mixture$plots
```

### Weighted Mixtures

Create weighted combinations:

```r
# Generate components with different sizes
dist1 <- tidy_normal(.n = 300, .mean = -2, .sd = 0.5)  # 75% weight
dist2 <- tidy_normal(.n = 100, .mean = 2, .sd = 0.5)   # 25% weight

# Create mixture
weighted_mixture <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "add"
)

weighted_mixture$plots
```

### Different Distribution Types

Mix different distribution families:

```r
# Mix normal and gamma
normal <- tidy_normal(.n = 100, .mean = 5, .sd = 1)
gamma <- tidy_gamma(.n = 100, .shape = 2, .rate = 0.5)

# Create mixture
mixed_family <- tidy_mixture_density(
  normal, gamma,
  .combination_type = "add"
)

mixed_family$plots
```

---

## 📊 Empirical Distributions

### What are Empirical Distributions?

Work directly with your observed data without assuming a distribution:

```r
# Your observed data
observed_data <- mtcars$mpg

# Create empirical distribution
empirical <- tidy_empirical(
  .x = observed_data,
  .num_sims = 1
)

# Visualize
tidy_autoplot(empirical, .plot_type = "density")
```

### Multiple Empirical Simulations

Generate multiple resamples:

```r
# Multiple bootstrap-like samples
empirical_multi <- tidy_empirical(
  .x = observed_data,
  .num_sims = 10
)

tidy_autoplot(empirical_multi, .plot_type = "density")
```

### Comparing Empirical with Theoretical

```r
# Observed data
data <- mtcars$mpg

# Empirical distribution
empirical <- tidy_empirical(.x = data, .num_sims = 1)

# Fitted theoretical distribution
theoretical <- tidy_normal(
  .n = length(data),
  .mean = mean(data),
  .sd = sd(data)
)

# Combine for comparison
combined <- tidy_combine_distributions(empirical, theoretical)

# Plot
tidy_combined_autoplot(combined)
```

### Empirical Bootstrap

Combine empirical with bootstrap:

```r
# Bootstrap from empirical data
boot_empirical <- tidy_bootstrap(
  .x = observed_data,
  .num_sims = 2000
)

# Visualize bootstrap distribution
bootstrap_stat_plot(boot_empirical, .value = y, .stat = "cmean")
```

---

## 🔄 Multi-Distribution Comparison

### Compare Same Distribution with Different Parameters

```r
# Compare normal distributions with different parameters
comparison <- tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    .n = 100,
    .mean = c(-2, 0, 2),
    .sd = 1,
    .num_sims = 5,
    .return_tibble = TRUE
  )
)

# Visualize
tidy_multi_dist_autoplot(comparison)
```

### Compare Different Distributions

```r
# Generate different distributions
normal <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
cauchy <- tidy_cauchy(.n = 100, .location = 0, .scale = 1)
logistic <- tidy_logistic(.n = 100, .location = 0, .scale = 1)

# Combine
combined <- tidy_combine_distributions(normal, cauchy, logistic)

# Visualize
tidy_combined_autoplot(combined)
```

---

## 🚶 Random Walk Generation

### Basic Random Walk

```r
# Generate random walk
tidy_normal(.sd = .1, .num_sims = 25) %>%
  tidy_random_walk()
```

### Random Walk Analysis

```r
library(dplyr)

# Analyze random walk endpoints
rw_analysis <- rw %>%
  group_by(sim_number) %>%
  summarise(
    final_position = last(y),
    max_position = max(y),
    min_position = min(y),
    range = max(y) - min(y)
  )

rw_analysis
```

---

## 🔗 Distribution Combinations

### Combining Multiple Distributions

```r
# Create several distributions
dist1 <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
dist2 <- tidy_gamma(.n = 100, .shape = 2, .scale = 1)
dist3 <- tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)

# Combine into one tibble
combined <- tidy_combine_distributions(dist1, dist2, dist3)

# Visualize all together
tidy_combined_autoplot(combined)
```

### Multi-Single Distribution Table

Create comparison table for same distribution:

```r
# Generate multiple parameter sets
multi <- tidy_multi_single_dist(
  .tidy_dist = "tidy_beta",
  .param_list = list(
    .n = 100,
    .shape1 = c(1, 2, 5, 5),
    .shape2 = c(1, 5, 2, 5),
    .ncp = 0,
    .num_sims = 5,
    .return_tibble = TRUE
  )
)

# Visualize
tidy_autoplot(combined_multi)
```

---

## 📏 Quantile Normalization

### What is Quantile Normalization?

Transform data to have a specific distribution while preserving ranks:

```r
# Your data
data <- c(5, 2, 8, 3, 9, 1, 7, 4, 6)

# Normalize to range [0, 1]
normalized <- tidy_scale_zero_one_vec(data)

normalized
```

### Advanced Quantile Normalization

```r
# Compare original and normalized
comparison <- data.frame(
  original = data,
  normalized = normalized
)

comparison
```

---

## 📈 Advanced Plotting

### Four-Panel Plots

View multiple plot types simultaneously:

```r
library(patchwork)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Create all plot types
p1 <- tidy_autoplot(data, .plot_type = "density")
p2 <- tidy_autoplot(data, .plot_type = "probability")
p3 <- tidy_autoplot(data, .plot_type = "quantile")
p4 <- tidy_autoplot(data, .plot_type = "qq")

# Combine in 2x2 grid
(p1 | p2) / (p3 | p4) +
  plot_annotation(
    title = "Four-Panel Distribution Analysis",
    theme = theme(plot.title = element_text(size = 16, face = "bold"))
  )
```

### Specialized Triangular Plots

```r
# Triangular distribution
tri <- tidy_triangular(
  .n = 100,
  .min = 0,
  .max = 10,
  .mode = 7
)

# Use specialized plotting
tidy_autoplot(tri)
triangle_plot(tri)
```

### Interactive Multi-Distribution Plots

```r
# Multiple distributions
multi <- tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    .n = 100,
    .mean = c(-2, 0, 2),
    .sd = 1,
    .num_sims = 1,
    .return_tibble = TRUE
  )
)

# Interactive plot
tidy_multi_dist_autoplot(multi, .plot_type = "density", .interactive = TRUE)
```

---

## 🎯 Real-World Examples

### Example 1: Modeling Bimodal Data

```r
# Simulate bimodal data (two age groups)
young <- tidy_normal(.n = 200, .mean = 25, .sd = 3)
old <- tidy_normal(.n = 150, .mean = 65, .sd = 5)

# Create mixture model
age_distribution <- tidy_mixture_density(
  young, old,
  .combination_type = "add"
)

age_distribution$plots
```

### Example 2: Income Distribution

```r
# Most people earn moderate income (normal)
# Few earn very high income (pareto tail)
moderate_income <- tidy_lognormal(.n = 300, .meanlog = 4, .sdlog = 0.5)
high_income <- tidy_pareto(.n = 50, .shape = 2, .scale = 100)

# Create mixture
income_model <- tidy_mixture_density(
  moderate_income, high_income,
  .combination_type = "add"
)

income_model$plots
```

### Example 3: Quality Control

```r
# Good products (tight distribution)
# Defective products (wider distribution)
good <- tidy_normal(.n = 95, .mean = 100, .sd = 2)
defective <- tidy_normal(.n = 5, .mean = 100, .sd = 10)

# Mixture model
qc_distribution <- tidy_mixture_density(
  good, defective,
  .combination_type = "add"
)

qc_distribution$plots
```

### Example 4: Financial Returns

```r
# Normal market (most days)
# Fat tails (extreme events)
normal_days <- tidy_normal(.n = 200, .mean = 0.001, .sd = 0.01)
extreme_events <- tidy_cauchy(.n = 10, .location = 0, .scale = 0.05)

# Model returns
returns_model <- tidy_mixture_density(
  normal_days, extreme_events,
  .combination_type = "add"
)

returns_model$plots
```

---

## 💡 Advanced Tips and Tricks

### Tip 1: Save Complex Models

```r
# Create complex model
complex_model <- tidy_mixture_density(
  dist1, dist2, dist3,
  .combination_type = "add"
)

# Save to file
saveRDS(complex_model, "complex_mixture_model.rds")

# Load later
loaded_model <- readRDS("complex_mixture_model.rds")
```

### Tip 2: Validate Mixture Models

```r
# Create mixture
mixture <- tidy_mixture_density(
  dist1, dist2,
  .combination_type = "add"
)

# Extract key statistics
mixture_stats <- mixture$data$dist_tbl |>
  summarise(
    mean = mean(y),
    sd = sd(y),
    median = median(y),
    skewness = moments::skewness(y),
    kurtosis = moments::kurtosis(y)
  )

mixture_stats
```

### Tip 3: Custom Mixture Weights

```r
# Control relative weights by .n parameter
heavy_left <- tidy_normal(.n = 300, .mean = -2, .sd = 0.5)  # 75%
light_right <- tidy_normal(.n = 100, .mean = 2, .sd = 0.5)  # 25%

# Create weighted mixture
weighted <- tidy_mixture_density(
  heavy_left, light_right,
  .combination_type = "add"
)

weighted$plots
```

---

## 🔍 Troubleshooting

### Issue: Mixture Doesn't Look Right

**Check:**
- Are component distributions on appropriate scales?
- Are mixture weights (via `.n`) appropriate?
- Is the mixture type correct?

```r
# Debug by plotting components separately
tidy_autoplot(dist1, .plot_type = "density")
tidy_autoplot(dist2, .plot_type = "density")
```

### Issue: Empirical Distribution Too Noisy

**Solution:** Use smoothing or increase observations:

```r
# Increase sample size via resampling
empirical_smooth <- tidy_empirical(.x = data$y, .num_sims = 10)
```

### Issue: Multi-Distribution Plots Cluttered

**Solution:**
- Reduce number of comparisons
- Use interactive plots
- Facet by parameter

```r
# Interactive helps with clutter
tidy_multi_dist_autoplot(multi, .interactive = TRUE)
```

---

## 🎓 Next Steps

- **[Examples and Use Cases](Examples-and-Use-Cases.md)** - Real-world applications
- **[Function Reference](Function-Reference.md)** - Complete function documentation
- **[FAQ and Troubleshooting](FAQ-and-Troubleshooting.md)** - Common questions

---

**Ready to see it all in action?** Check out [Examples and Use Cases](Examples-and-Use-Cases.md) for complete workflows!
