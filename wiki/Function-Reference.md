# Function Reference

Comprehensive reference guide to all TidyDensity functions organized by category.

## 📋 Quick Navigation

- [Distribution Generation Functions](#distribution-generation-functions)
- [Visualization Functions](#visualization-functions)
- [Parameter Estimation Functions](#parameter-estimation-functions)
- [Statistics Functions](#statistics-functions)
- [Bootstrap Functions](#bootstrap-functions)
- [Utility Functions](#utility-functions)
- [Helper Functions](#helper-functions)

---

## 🎲 Distribution Generation Functions

### Continuous Distributions

All continuous distribution functions follow the pattern: `tidy_[distribution]()`

**Common Parameters:**
- `.n` - Number of observations
- `.num_sims` - Number of simulations
- `.return_tibble` - Return as tibble (default: TRUE)

#### Normal Family
- **`tidy_normal()`** - Normal/Gaussian distribution
  - Parameters: `.mean`, `.sd`
- **`tidy_lognormal()`** - Log-normal distribution
  - Parameters: `.meanlog`, `.sdlog`
- **`tidy_inverse_normal()`** - Inverse Gaussian distribution
  - Parameters: `.mean`, `.shape`

#### Exponential Family
- **`tidy_exponential()`** - Exponential distribution
  - Parameters: `.rate`
- **`tidy_inverse_exponential()`** - Inverse exponential distribution
  - Parameters: `.rate`

#### Gamma Family
- **`tidy_gamma()`** - Gamma distribution
  - Parameters: `.shape`, `.rate` or `.scale`
- **`tidy_inverse_gamma()`** - Inverse gamma distribution
  - Parameters: `.shape`, `.rate` or `.scale`

#### Beta Family
- **`tidy_beta()`** - Beta distribution
  - Parameters: `.shape1`, `.shape2`, `.ncp`
- **`tidy_generalized_beta()`** - Generalized beta distribution
  - Parameters: `.shape1`, `.shape2`, `.shape3`, `.scale`, `.rate`

#### Weibull Family
- **`tidy_weibull()`** - Weibull distribution
  - Parameters: `.shape`, `.scale`
- **`tidy_inverse_weibull()`** - Inverse Weibull distribution
  - Parameters: `.shape`, `.scale`

#### Pareto Family
- **`tidy_pareto()`** - Pareto distribution
  - Parameters: `.shape`, `.scale`
- **`tidy_inverse_pareto()`** - Inverse Pareto distribution
  - Parameters: `.shape`, `.scale`
- **`tidy_pareto_single_parameter()`** - Single parameter Pareto
  - Parameters: `.shape`
- **`tidy_generalized_pareto()`** - Generalized Pareto distribution
  - Parameters: `.location`, `.scale`, `.shape`

#### Burr Family
- **`tidy_burr()`** - Burr distribution
  - Parameters: `.shape1`, `.shape2`, `.scale`
- **`tidy_inverse_burr()`** - Inverse Burr distribution
  - Parameters: `.shape1`, `.shape2`, `.scale`

#### Other Continuous
- **`tidy_cauchy()`** - Cauchy distribution
  - Parameters: `.location`, `.scale`
- **`tidy_chisquare()`** - Chi-square distribution
  - Parameters: `.df`, `.ncp`
- **`tidy_f()`** - F-distribution
  - Parameters: `.df1`, `.df2`, `.ncp`
- **`tidy_t()`** - Student's t-distribution
  - Parameters: `.df`, `.ncp`
- **`tidy_logistic()`** - Logistic distribution
  - Parameters: `.location`, `.scale`
- **`tidy_paralogistic()`** - Paralogistic distribution
  - Parameters: `.shape`, `.scale`
- **`tidy_triangular()`** - Triangular distribution
  - Parameters: `.min`, `.max`, `.mode`
- **`tidy_uniform()`** - Uniform distribution
  - Parameters: `.min`, `.max`

### Discrete Distributions

#### Count Data
- **`tidy_bernoulli()`** - Bernoulli distribution
  - Parameters: `.prob`
- **`tidy_binomial()`** - Binomial distribution
  - Parameters: `.size`, `.prob`
- **`tidy_geometric()`** - Geometric distribution
  - Parameters: `.prob`
- **`tidy_hypergeometric()`** - Hypergeometric distribution
  - Parameters: `.m`, `.nn`, `.k`
- **`tidy_negative_binomial()`** - Negative binomial distribution
  - Parameters: `.size`, `.prob` or `.mu`
- **`tidy_poisson()`** - Poisson distribution
  - Parameters: `.lambda`

#### Zero-Truncated Variants
- **`tidy_zero_truncated_binomial()`** - Zero-truncated binomial
  - Parameters: `.size`, `.prob`
- **`tidy_zero_truncated_geometric()`** - Zero-truncated geometric
  - Parameters: `.prob`
- **`tidy_zero_truncated_poisson()`** - Zero-truncated Poisson
  - Parameters: `.lambda`

### Special Distributions

- **`tidy_empirical()`** - Empirical distribution from data
  - Parameters: `.x`, `.num_sims`
- **`tidy_bootstrap()`** - Bootstrap resampling
  - Parameters: `.x`, `.num_sims`, `.proportion`
- **`tidy_random_walk()`** - Random walk generation
  - Parameters: `.n`, `.num_walks`, `.step_size`, `.sd`
- **`tidy_mixture_density()`** - Mixture model creation
  - Parameters: `.tbl_list`, `.mixture_type`
- **`tidy_multi_single_dist()`** - Multiple parameter sets for same distribution
  - Parameters: `.tidy_dist`, `.param_list`

---

## 📊 Visualization Functions

### Main Plotting Function

- **`tidy_autoplot()`** - Automatic plotting for tidy distributions
  - **Parameters:**
    - `.data` - Data from tidy distribution function
    - `.plot_type` - "density", "quantile", "probability", "qq", "mcmc"
    - `.line_size` - Line thickness
    - `.geom_point` - Add points (TRUE/FALSE)
    - `.point_size` - Point size
    - `.geom_rug` - Add rug plot (TRUE/FALSE)
    - `.geom_smooth` - Add smoothing (TRUE/FALSE)
    - `.geom_jitter` - Add jitter (TRUE/FALSE)
    - `.interactive` - Create plotly plot (TRUE/FALSE)

### Specialized Plotting Functions

- **`tidy_combined_autoplot()`** - Plot combined distributions
  - For use with `tidy_combine_distributions()`
- **`tidy_autoplot_triangular()`** - Specialized triangular distribution plot
- **`tidy_autoplot_random_walk()`** - Specialized random walk visualization
- **`autoplot.tidy_multi_dist()`** - S3 method for multi-distribution plots
- **`autoplot.tidy_bootstrap()`** - S3 method for bootstrap plots

### Color Functions

- **`color_blind()`** - Color-blind friendly palette
- **`color_blind_tbl()`** - Color palette as tibble

---

## 🔍 Parameter Estimation Functions

Pattern: `util_[distribution]_param_estimate()`

**Common Parameters:**
- `.x` - Data vector
- `.auto_gen_empirical` - Auto-generate comparison (TRUE/FALSE)

**Returns:**
- `parameter_tbl` - Parameter estimates (MLE, MME, MVUE)
- `combined_data_tbl` - Empirical + fitted data
- `empirical_tbl` - Original data
- `fitted_tbl` - Fitted distribution

### Available Estimation Functions

#### Continuous Distributions
- `util_normal_param_estimate()`
- `util_lognormal_param_estimate()`
- `util_exponential_param_estimate()`
- `util_gamma_param_estimate()`
- `util_beta_param_estimate()`
- `util_weibull_param_estimate()`
- `util_pareto_param_estimate()`
- `util_cauchy_param_estimate()`
- `util_logistic_param_estimate()`
- `util_uniform_param_estimate()`
- `util_triangular_param_estimate()`
- `util_chisquare_param_estimate()`
- `util_f_param_estimate()`
- `util_t_param_estimate()`
- `util_generalized_pareto_param_estimate()`
- `util_generalized_beta_param_estimate()`
- `util_inverse_gamma_param_estimate()`
- `util_inverse_weibull_param_estimate()`
- `util_inverse_pareto_param_estimate()`
- `util_inverse_burr_param_estimate()`
- `util_burr_param_estimate()`
- `util_paralogistic_param_estimate()`

#### Discrete Distributions
- `util_bernoulli_param_estimate()`
- `util_binomial_param_estimate()`
- `util_geometric_param_estimate()`
- `util_hypergeometric_param_estimate()`
- `util_negative_binomial_param_estimate()`
- `util_poisson_param_estimate()`
- `util_zero_truncated_binomial_param_estimate()`
- `util_zero_truncated_geometric_param_estimate()`
- `util_zero_truncated_poisson_param_estimate()`
- `util_zero_truncated_negative_binomial_param_estimate()`

---

## 📈 Statistics Functions

### Statistics Tables

Pattern: `util_[distribution]_stats_tbl()`

**Purpose:** Generate summary statistics table for a distribution

**Returns:** Tibble with mean, variance, skewness, kurtosis, etc.

#### Available Statistics Functions

- `util_normal_stats_tbl()`
- `util_gamma_stats_tbl()`
- `util_beta_stats_tbl()`
- `util_exponential_stats_tbl()`
- `util_weibull_stats_tbl()`
- `util_poisson_stats_tbl()`
- `util_binomial_stats_tbl()`
- `util_bernoulli_stats_tbl()`
- `util_cauchy_stats_tbl()`
- `util_chisquare_stats_tbl()`
- `util_f_stats_tbl()`
- `util_t_stats_tbl()`
- `util_logistic_stats_tbl()`
- `util_uniform_stats_tbl()`
- `util_triangular_stats_tbl()`
- `util_geometric_stats_tbl()`
- `util_hypergeometric_stats_tbl()`
- `util_negative_binomial_stats_tbl()`
- `util_pareto_stats_tbl()`
- `util_burr_stats_tbl()`
- `util_inverse_gamma_stats_tbl()`
- `util_inverse_weibull_stats_tbl()`
- `util_inverse_burr_stats_tbl()`
- `util_inverse_pareto_stats_tbl()`
- `util_paralogistic_stats_tbl()`

### AIC Functions

Pattern: `util_[distribution]_aic()`

**Purpose:** Calculate Akaike Information Criterion for model comparison

**Parameters:** `.x` - Data vector

**Returns:** Numeric AIC value (lower is better)

#### Available AIC Functions

- `util_normal_aic()`
- `util_lognormal_aic()`
- `util_gamma_aic()`
- `util_beta_aic()`
- `util_exponential_aic()`
- `util_weibull_aic()`
- `util_pareto_aic()`
- `util_cauchy_aic()`
- `util_logistic_aic()`
- `util_uniform_aic()`
- `util_triangular_aic()`
- `util_chisquare_aic()`
- `util_f_aic()`
- `util_t_aic()`
- `util_poisson_aic()`
- `util_binomial_aic()`
- `util_geometric_aic()`
- `util_hypergeometric_aic()`
- `util_negative_binomial_aic()`
- `util_generalized_pareto_aic()`
- `util_generalized_beta_aic()`
- `util_inverse_gamma_aic()`
- `util_inverse_weibull_aic()`
- `util_inverse_burr_aic()`
- `util_inverse_pareto_aic()`
- `util_paralogistic_aic()`
- `util_zero_truncated_binomial_aic()`
- `util_zero_truncated_geometric_aic()`
- `util_zero_truncated_poisson_aic()`

### Distribution Comparison

- **`util_distribution_comparison()`** - Compare multiple distributions
  - Automatically fits and compares several distributions
  - Returns AIC values for model selection

---

## 🔄 Bootstrap Functions

### Bootstrap Generation

- **`tidy_bootstrap()`** - Generate bootstrap samples
  - Parameters: `.x`, `.num_sims`, `.proportion`, `.distribution_type`

### Bootstrap Augmentation

- **`bootstrap_unnest_tbl()`** - Unnest bootstrap tibble for analysis
- **`tidy_bootstrap_density_augment()`** - Add density calculations
- **`tidy_bootstrap_p_augment()`** - Add probability calculations
- **`tidy_bootstrap_q_augment()`** - Add quantile calculations

---

## 🛠️ Utility Functions

### Combination Functions

- **`tidy_combine_distributions()`** - Combine different distributions
  - Combine multiple tidy distribution objects
- **`tidy_combine_multi_single_dist_tbl()`** - Combine multi-single dist tables
  - For use with `tidy_multi_single_dist()`

### Data Manipulation

- **`tidy_scale_zero_one_vec()`** - Scale vector to [0, 1]
  - Normalize data to unit interval
- **`quantile_normalize()`** - Quantile normalization
  - Transform data preserving ranks

### Distribution Summary

- **`tidy_distribution_summary_tbl()`** - Generate summary table
  - Comprehensive statistics for tidy distribution data

### Conversion Functions

- **`util_convert_to_ts()`** - Convert to time series
  - Convert tidy data to ts object

### MCMC Functions

- **`util_mcmc_sampling()`** - MCMC sampling utilities
  - For Markov Chain Monte Carlo sampling

### Other Utilities

- **`util_check_duplicate_rows()`** - Check for duplicate rows
  - Data quality checking
- **`csd()`** - Cumulative standard deviation
  - Calculate cumulative SD

---

## 🔧 Helper Functions

### Internal Helpers

These are primarily for package internal use but may be useful:

- **`color_blind()`** - Color-blind friendly colors
- **Pipe operator (`%>%`)** - Magrittr pipe
- **Global variables** - Internal variable definitions

---

## 📚 Usage Patterns

### Pattern 1: Generate and Plot

```r
# Generate distribution
data <- tidy_normal(.n = 100, .num_sims = 5)

# Plot
tidy_autoplot(data, .plot_type = "density")
```

### Pattern 2: Estimate and Compare

```r
# Estimate parameters
estimates <- util_normal_param_estimate(my_data, .auto_gen_empirical = TRUE)

# View estimates
estimates$parameter_tbl

# Compare visually
estimates$combined_data_tbl %>%
  tidy_combined_autoplot()
```

### Pattern 3: Model Selection

```r
# Calculate AIC for multiple distributions
aic_normal <- util_normal_aic(.x = data)
aic_gamma <- util_gamma_aic(.x = data)
aic_lognormal <- util_lognormal_aic(.x = data)

# Compare
best_model <- which.min(c(aic_normal, aic_gamma, aic_lognormal))
```

### Pattern 4: Bootstrap Analysis

```r
# Bootstrap
boot_data <- tidy_bootstrap(.x = data, .num_sims = 2000)

# Calculate CI
boot_data %>%
  bootstrap_unnest_tbl() %>%
  summarise(
    lower = quantile(y, 0.025),
    upper = quantile(y, 0.975)
  )
```

### Pattern 5: Mixture Models

```r
# Create components
comp1 <- tidy_normal(.n = 100, .mean = -2, .sd = 0.5)
comp2 <- tidy_normal(.n = 100, .mean = 2, .sd = 0.5)

# Create mixture
mixture <- tidy_mixture_density(
  .tbl_list = list(comp1, comp2),
  .mixture_type = "add"
)

# Visualize
tidy_autoplot(mixture, .plot_type = "density")
```

---

## 🔗 Related Documentation

- **Package Website**: https://www.spsanderson.com/TidyDensity/reference/
- **CRAN Documentation**: https://CRAN.R-project.org/package=TidyDensity
- **GitHub Repository**: https://github.com/spsanderson/TidyDensity

---

## 💡 Tips for Finding Functions

### By Task

**Want to generate data?**
- Look for `tidy_[distribution]()` functions

**Want to visualize?**
- Use `tidy_autoplot()` or specialized plotting functions

**Want to fit distribution?**
- Use `util_[distribution]_param_estimate()` functions

**Want to compare models?**
- Use `util_[distribution]_aic()` functions

**Want bootstrap?**
- Start with `tidy_bootstrap()`

### Using Help System

```r
# Get help for any function
?tidy_normal
?tidy_autoplot
?util_normal_param_estimate

# Search for functions
apropos("tidy_")
apropos("util_")

# List all package functions
ls("package:TidyDensity")
```

---

**Need examples?** Check out [Examples and Use Cases](Examples-and-Use-Cases.md) for practical applications!
