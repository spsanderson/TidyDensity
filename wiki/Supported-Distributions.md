# Supported Distributions

TidyDensity supports **35+ probability distributions** across continuous and discrete families. Each distribution has consistent syntax and returns tidy tibbles.

## 📋 Table of Contents

- [Continuous Distributions](#continuous-distributions)
  - [Normal Family](#normal-family)
  - [Exponential Family](#exponential-family)
  - [Gamma Family](#gamma-family)
  - [Beta Family](#beta-family)
  - [Weibull Family](#weibull-family)
  - [Pareto Family](#pareto-family)
  - [Burr Family](#burr-family)
  - [Other Continuous Distributions](#other-continuous-distributions)
- [Discrete Distributions](#discrete-distributions)
- [Distribution Function Naming](#distribution-function-naming)
- [Quick Reference Table](#quick-reference-table)

---

## 🌊 Continuous Distributions

### Normal Family

#### 1. **Normal (Gaussian) Distribution**
- **Function**: `tidy_normal()`
- **Parameters**: `.mean`, `.sd`
- **Use Cases**: General modeling, measurement errors, central limit theorem applications
- **Example**:
```r
tidy_normal(.n = 100, .mean = 0, .sd = 1, .num_sims = 5)
```

#### 2. **Log-Normal Distribution**
- **Function**: `tidy_lognormal()`
- **Parameters**: `.meanlog`, `.sdlog`
- **Use Cases**: Financial modeling, survival times, positive continuous data
- **Example**:
```r
tidy_lognormal(.n = 100, .meanlog = 0, .sdlog = 1)
```

#### 3. **Inverse Normal (Inverse Gaussian) Distribution**
- **Function**: `tidy_inverse_normal()`
- **Parameters**: `.mean`, `.shape`
- **Use Cases**: Reliability analysis, degradation modeling
- **Example**:
```r
tidy_inverse_normal(.n = 100, .mean = 1, .shape = 1)
```

---

### Exponential Family

#### 4. **Exponential Distribution**
- **Function**: `tidy_exponential()`
- **Parameters**: `.rate`
- **Use Cases**: Time between events, waiting times, lifetime analysis
- **Example**:
```r
tidy_exponential(.n = 100, .rate = 1)
```

#### 5. **Inverse Exponential Distribution**
- **Function**: `tidy_inverse_exponential()`
- **Parameters**: `.rate`
- **Use Cases**: Reliability engineering, failure time analysis
- **Example**:
```r
tidy_inverse_exponential(.n = 100, .rate = 1)
```

---

### Gamma Family

#### 6. **Gamma Distribution**
- **Function**: `tidy_gamma()`
- **Parameters**: `.shape`, `.rate` or `.scale`
- **Use Cases**: Waiting times, reliability, insurance claims
- **Example**:
```r
tidy_gamma(.n = 100, .shape = 2, .rate = 1)
```

#### 7. **Inverse Gamma Distribution**
- **Function**: `tidy_inverse_gamma()`
- **Parameters**: `.shape`, `.rate` or `.scale`
- **Use Cases**: Bayesian analysis, variance modeling
- **Example**:
```r
tidy_inverse_gamma(.n = 100, .shape = 2, .rate = 1)
```

---

### Beta Family

#### 8. **Beta Distribution**
- **Function**: `tidy_beta()`
- **Parameters**: `.shape1`, `.shape2`, `.ncp` (optional)
- **Use Cases**: Proportions, probabilities, Bayesian priors
- **Example**:
```r
tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)
```

#### 9. **Generalized Beta Distribution**
- **Function**: `tidy_generalized_beta()`
- **Parameters**: `.shape1`, `.shape2`, `.shape3`, `.scale`, `.rate`
- **Use Cases**: Extended modeling of bounded continuous data
- **Example**:
```r
tidy_generalized_beta(.n = 100, .shape1 = 2, .shape2 = 5, .shape3 = 3, .scale = 1, .rate = 1)
```

---

### Weibull Family

#### 10. **Weibull Distribution**
- **Function**: `tidy_weibull()`
- **Parameters**: `.shape`, `.scale`
- **Use Cases**: Failure time analysis, reliability engineering, survival analysis
- **Example**:
```r
tidy_weibull(.n = 100, .shape = 2, .scale = 1)
```

#### 11. **Inverse Weibull Distribution**
- **Function**: `tidy_inverse_weibull()`
- **Parameters**: `.shape`, `.scale`
- **Use Cases**: Reliability analysis, degradation processes
- **Example**:
```r
tidy_inverse_weibull(.n = 100, .shape = 2, .scale = 1)
```

---

### Pareto Family

#### 12. **Pareto Distribution**
- **Function**: `tidy_pareto()`
- **Parameters**: `.shape`, `.scale`
- **Use Cases**: Income distribution, insurance losses, extreme values
- **Example**:
```r
tidy_pareto(.n = 100, .shape = 2, .scale = 1)
```

#### 13. **Inverse Pareto Distribution**
- **Function**: `tidy_inverse_pareto()`
- **Parameters**: `.shape`, `.scale`
- **Use Cases**: Alternative parameterization for bounded data
- **Example**:
```r
tidy_inverse_pareto(.n = 100, .shape = 2, .scale = 1)
```

#### 14. **Single Parameter Pareto Distribution**
- **Function**: `tidy_pareto_single_parameter()`
- **Parameters**: `.shape`
- **Use Cases**: Simplified Pareto modeling
- **Example**:
```r
tidy_pareto_single_parameter(.n = 100, .shape = 2)
```

#### 15. **Generalized Pareto Distribution**
- **Function**: `tidy_generalized_pareto()`
- **Parameters**: `.location`, `.scale`, `.shape`
- **Use Cases**: Extreme value theory, risk analysis
- **Example**:
```r
tidy_generalized_pareto(.n = 100, .location = 0, .scale = 1, .shape = 0.1)
```

---

### Burr Family

#### 16. **Burr Distribution**
- **Function**: `tidy_burr()`
- **Parameters**: `.shape1`, `.shape2`, `.scale`
- **Use Cases**: Actuarial science, reliability, failure time modeling
- **Example**:
```r
tidy_burr(.n = 100, .shape1 = 2, .shape2 = 3, .scale = 1)
```

#### 17. **Inverse Burr Distribution**
- **Function**: `tidy_inverse_burr()`
- **Parameters**: `.shape1`, `.shape2`, `.scale`
- **Use Cases**: Income modeling, insurance applications
- **Example**:
```r
tidy_inverse_burr(.n = 100, .shape1 = 2, .shape2 = 3, .scale = 1)
```

---

### Other Continuous Distributions

#### 18. **Cauchy Distribution**
- **Function**: `tidy_cauchy()`
- **Parameters**: `.location`, `.scale`
- **Use Cases**: Robust statistics, heavy-tailed modeling
- **Example**:
```r
tidy_cauchy(.n = 100, .location = 0, .scale = 1)
```

#### 19. **Chi-Square Distribution**
- **Function**: `tidy_chisquare()`
- **Parameters**: `.df`, `.ncp` (optional)
- **Use Cases**: Hypothesis testing, goodness-of-fit tests
- **Example**:
```r
tidy_chisquare(.n = 100, .df = 5)
```

#### 20. **F-Distribution**
- **Function**: `tidy_f()`
- **Parameters**: `.df1`, `.df2`, `.ncp` (optional)
- **Use Cases**: ANOVA, regression analysis, variance ratio tests
- **Example**:
```r
tidy_f(.n = 100, .df1 = 5, .df2 = 10)
```

#### 21. **t-Distribution (Student's t)**
- **Function**: `tidy_t()`
- **Parameters**: `.df`, `.ncp` (optional)
- **Use Cases**: Small sample inference, confidence intervals
- **Example**:
```r
tidy_t(.n = 100, .df = 10)
```

#### 22. **Logistic Distribution**
- **Function**: `tidy_logistic()`
- **Parameters**: `.location`, `.scale`
- **Use Cases**: Growth models, logistic regression
- **Example**:
```r
tidy_logistic(.n = 100, .location = 0, .scale = 1)
```

#### 23. **Paralogistic Distribution**
- **Function**: `tidy_paralogistic()`
- **Parameters**: `.shape`, `.scale`
- **Use Cases**: Survival analysis, income distribution
- **Example**:
```r
tidy_paralogistic(.n = 100, .shape = 2, .scale = 1)
```

#### 24. **Triangular Distribution**
- **Function**: `tidy_triangular()`
- **Parameters**: `.min`, `.max`, `.mode`
- **Use Cases**: Project management, risk analysis when limited data available
- **Example**:
```r
tidy_triangular(.n = 100, .min = 0, .max = 10, .mode = 5)
```

#### 25. **Uniform Distribution**
- **Function**: `tidy_uniform()`
- **Parameters**: `.min`, `.max`
- **Use Cases**: Random sampling, simulation, equal probability scenarios
- **Example**:
```r
tidy_uniform(.n = 100, .min = 0, .max = 1)
```

---

## 🎲 Discrete Distributions

### Count Data Distributions

#### 26. **Bernoulli Distribution**
- **Function**: `tidy_bernoulli()`
- **Parameters**: `.prob`
- **Use Cases**: Binary outcomes, success/failure trials
- **Example**:
```r
tidy_bernoulli(.n = 100, .prob = 0.5)
```

#### 27. **Binomial Distribution**
- **Function**: `tidy_binomial()`
- **Parameters**: `.size`, `.prob`
- **Use Cases**: Fixed number of trials, quality control
- **Example**:
```r
tidy_binomial(.n = 100, .size = 10, .prob = 0.3)
```

#### 28. **Zero-Truncated Binomial Distribution**
- **Function**: `tidy_zero_truncated_binomial()`
- **Parameters**: `.size`, `.prob`
- **Use Cases**: Count data where zero is not possible
- **Example**:
```r
tidy_zero_truncated_binomial(.n = 100, .size = 10, .prob = 0.3)
```

#### 29. **Geometric Distribution**
- **Function**: `tidy_geometric()`
- **Parameters**: `.prob`
- **Use Cases**: Number of trials until first success, waiting times
- **Example**:
```r
tidy_geometric(.n = 100, .prob = 0.3)
```

#### 30. **Zero-Truncated Geometric Distribution**
- **Function**: `tidy_zero_truncated_geometric()`
- **Parameters**: `.prob`
- **Use Cases**: Waiting times where zero is excluded
- **Example**:
```r
tidy_zero_truncated_geometric(.n = 100, .prob = 0.3)
```

#### 31. **Hypergeometric Distribution**
- **Function**: `tidy_hypergeometric()`
- **Parameters**: `.m`, `.n`, `.k`
- **Use Cases**: Sampling without replacement, quality control
- **Example**:
```r
tidy_hypergeometric(.n = 100, .m = 50, .nn = 50, .k = 20)
```

#### 32. **Negative Binomial Distribution**
- **Function**: `tidy_negative_binomial()`
- **Parameters**: `.size`, `.prob` or `.mu`
- **Use Cases**: Overdispersed count data, number of failures before r successes
- **Example**:
```r
tidy_negative_binomial(.n = 100, .size = 5, .prob = 0.5)
```

#### 33. **Poisson Distribution**
- **Function**: `tidy_poisson()`
- **Parameters**: `.lambda`
- **Use Cases**: Count data, rare events, arrivals per time period
- **Example**:
```r
tidy_poisson(.n = 100, .lambda = 5)
```

#### 34. **Zero-Truncated Poisson Distribution**
- **Function**: `tidy_zero_truncated_poisson()`
- **Parameters**: `.lambda`
- **Use Cases**: Count data where zero cannot occur
- **Example**:
```r
tidy_zero_truncated_poisson(.n = 100, .lambda = 5)
```

---

## 🔤 Distribution Function Naming

All distribution functions in TidyDensity follow a consistent naming pattern:

### Pattern: `tidy_[distribution_name]()`

**Examples:**
- `tidy_normal()` - Normal distribution
- `tidy_gamma()` - Gamma distribution
- `tidy_poisson()` - Poisson distribution

### Special Prefixes:
- **Inverse distributions**: `tidy_inverse_[name]()`
  - Example: `tidy_inverse_gamma()`
- **Zero-truncated distributions**: `tidy_zero_truncated_[name]()`
  - Example: `tidy_zero_truncated_poisson()`
- **Generalized distributions**: `tidy_generalized_[name]()`
  - Example: `tidy_generalized_pareto()`

---

## 📊 Quick Reference Table

### Continuous Distributions Summary

| Distribution | Function | Key Parameters | Primary Use Case |
|-------------|----------|----------------|------------------|
| Normal | `tidy_normal()` | mean, sd | General modeling |
| Log-Normal | `tidy_lognormal()` | meanlog, sdlog | Financial data |
| Exponential | `tidy_exponential()` | rate | Waiting times |
| Gamma | `tidy_gamma()` | shape, rate | Insurance claims |
| Beta | `tidy_beta()` | shape1, shape2 | Proportions |
| Weibull | `tidy_weibull()` | shape, scale | Reliability |
| Pareto | `tidy_pareto()` | shape, scale | Income distribution |
| Cauchy | `tidy_cauchy()` | location, scale | Heavy tails |
| Chi-Square | `tidy_chisquare()` | df | Hypothesis tests |
| F | `tidy_f()` | df1, df2 | ANOVA |
| t | `tidy_t()` | df | Small samples |
| Uniform | `tidy_uniform()` | min, max | Random sampling |

### Discrete Distributions Summary

| Distribution | Function | Key Parameters | Primary Use Case |
|-------------|----------|----------------|------------------|
| Bernoulli | `tidy_bernoulli()` | prob | Binary outcomes |
| Binomial | `tidy_binomial()` | size, prob | Fixed trials |
| Geometric | `tidy_geometric()` | prob | Time to success |
| Hypergeometric | `tidy_hypergeometric()` | m, n, k | Sampling w/o replacement |
| Negative Binomial | `tidy_negative_binomial()` | size, prob | Overdispersed counts |
| Poisson | `tidy_poisson()` | lambda | Rare events |

---

## 🎯 Choosing the Right Distribution

### By Data Type

**Continuous Positive Data:**
- General: Normal, Log-Normal
- Right-skewed: Gamma, Weibull, Exponential
- Heavy-tailed: Pareto, Cauchy

**Bounded Data (0 to 1):**
- Beta distribution

**Count Data:**
- Simple counts: Poisson
- Overdispersed: Negative Binomial
- Binary: Bernoulli, Binomial

**Survival/Reliability:**
- Exponential, Weibull, Gamma

**Extreme Values:**
- Generalized Pareto, Burr

### By Application Domain

**Finance & Economics:**
- Log-Normal, Pareto, Inverse Gamma

**Quality Control:**
- Binomial, Hypergeometric, Normal

**Reliability Engineering:**
- Weibull, Exponential, Inverse Weibull

**Healthcare & Epidemiology:**
- Poisson, Negative Binomial, Gamma

**Risk Analysis:**
- Generalized Pareto, Triangular, Beta

---

## 📖 Common Parameters Across Distributions

### Location Parameters
- Control the center or position of the distribution
- Examples: `.mean`, `.location`

### Scale Parameters
- Control the spread or variability
- Examples: `.sd`, `.scale`

### Shape Parameters
- Control the form of the distribution
- Examples: `.shape`, `.shape1`, `.shape2`

### Rate Parameters
- Often inverse of scale
- Examples: `.rate` (typically 1/scale)

### Size/Count Parameters
- For discrete distributions
- Examples: `.size`, `.df` (degrees of freedom)

---

## 🔍 Getting More Information

### Function Documentation
```r
# Get help for any distribution
?tidy_normal
?tidy_gamma
?tidy_poisson
```

### Parameter Estimation
Each distribution has a corresponding parameter estimation function:
```r
# Pattern: util_[distribution]_param_estimate()
util_normal_param_estimate(x)
util_gamma_param_estimate(x)
util_poisson_param_estimate(x)
```

### Statistics Tables
Get summary statistics for each distribution:
```r
# Pattern: util_[distribution]_stats_tbl()
util_normal_stats_tbl(.mean = 0, .sd = 1)
util_gamma_stats_tbl(.shape = 2, .rate = 1)
```

### AIC Calculation
Compare models using AIC:
```r
# Pattern: util_[distribution]_aic()
util_normal_aic(.x = data)
util_gamma_aic(.x = data)
```

---

## 💡 Tips for Working with Distributions

1. **Start with common distributions** (Normal, Poisson, Uniform) to understand the syntax
2. **Check parameter constraints** - many distributions have restrictions on parameters
3. **Use `.num_sims`** to generate multiple samples for variability assessment
4. **Visualize before analyzing** - plots reveal distribution characteristics
5. **Compare with empirical data** using parameter estimation functions

---

## 🎓 Next Steps

- **[Visualization and Plotting](Visualization-and-Plotting.md)** - Learn to create beautiful plots
- **[Parameter Estimation](Parameter-Estimation.md)** - Fit distributions to your data
- **[Examples and Use Cases](Examples-and-Use-Cases.md)** - See real-world applications

---

**Need help choosing?** Check the [FAQ and Troubleshooting](FAQ-and-Troubleshooting.md) page for guidance!
