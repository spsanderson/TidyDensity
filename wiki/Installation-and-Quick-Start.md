# Installation and Quick Start

This guide will get you up and running with TidyDensity in minutes.

## 📦 Installation

### Install from CRAN (Recommended)

The easiest way to install TidyDensity is from CRAN:

```r
install.packages("TidyDensity")
```

### Install Development Version from GitHub

To get the latest development version with newest features:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install TidyDensity from GitHub
devtools::install_github("spsanderson/TidyDensity")
```

### System Requirements

- **R version**: >= 4.1.0
- **Operating Systems**: Windows, macOS, Linux
- **Dependencies**: The package will automatically install required dependencies

### Verify Installation

After installation, verify everything works:

```r
library(TidyDensity)
packageVersion("TidyDensity")
```

---

## 🚀 Quick Start Guide

### Your First Distribution

Generate random data from a normal distribution:

```r
library(TidyDensity)

# Generate 50 points from a standard normal distribution
data <- tidy_normal(.n = 50, .mean = 0, .sd = 1)

# View the data
data
```

**Output structure:**
```
# A tibble: 50 × 7
   sim_number     x       y    dx       dy      p       q
   <fct>      <int>   <dbl> <dbl>    <dbl>  <dbl>   <dbl>
 1 1              1 -0.626  -3.51 0.000235 0.266  -0.626
 2 1              2  0.184  -3.37 0.000617 0.573   0.184
 ...
```

**Column Explanation:**
- `sim_number`: Simulation identifier (useful for multiple simulations)
- `x`: Observation number (1 to n)
- `y`: The randomly generated value
- `dx`: X-values for density plotting
- `dy`: Y-values for density function (PDF)
- `p`: Cumulative probability (CDF)
- `q`: Quantile values

### Create Your First Visualization

```r
library(ggplot2)

# Generate data with multiple simulations
data <- tidy_normal(.n = 100, .mean = 0, .sd = 1, .num_sims = 5)

# Create a density plot
tidy_autoplot(data, .plot_type = "density")

# Create a quantile plot
tidy_autoplot(data, .plot_type = "quantile")

# Create a QQ plot
tidy_autoplot(data, .plot_type = "qq")
```

### Basic Workflow Example

Here's a complete workflow from data generation to visualization:

```r
library(TidyDensity)
library(dplyr)
library(ggplot2)

# Step 1: Generate data from a gamma distribution
gamma_data <- tidy_gamma(
  .n = 100,
  .shape = 2,
  .rate = 1,
  .num_sims = 3
)

# Step 2: Explore the data
gamma_data %>%
  group_by(sim_number) %>%
  summarise(
    mean = mean(y),
    sd = sd(y),
    min = min(y),
    max = max(y)
  )

# Step 3: Visualize
tidy_autoplot(gamma_data, .plot_type = "density")
```

---

## 🎯 Common Use Cases

### 1. Compare Multiple Distributions

```r
# Generate data from different distributions
normal_data <- tidy_normal(.n = 100, .mean = 0, .sd = 1)
gamma_data <- tidy_gamma(.n = 100, .shape = 2, .rate = 1)
beta_data <- tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)

# Visualize each
tidy_autoplot(normal_data, .plot_type = "density")
tidy_autoplot(gamma_data, .plot_type = "density")
tidy_autoplot(beta_data, .plot_type = "density")
```

### 2. Compare Same Distribution with Different Parameters

```r
# Use tidy_multi_single_dist for parameter comparison
comparison <- tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    list(.n = 100, .mean = 0, .sd = 1),
    list(.n = 100, .mean = 0, .sd = 2),
    list(.n = 100, .mean = 2, .sd = 1)
  )
)

tidy_autoplot(comparison, .plot_type = "density")
```

### 3. Fit Distribution to Real Data

```r
# Use real data (e.g., mtcars mpg)
mpg_data <- mtcars$mpg

# Estimate normal distribution parameters
estimates <- util_normal_param_estimate(
  mpg_data,
  .auto_gen_empirical = TRUE
)

# View parameter estimates
estimates$parameter_tbl

# Compare empirical vs fitted
estimates$combined_data_tbl %>%
  tidy_combined_autoplot()
```

### 4. Bootstrap Analysis

```r
# Perform bootstrap resampling
bootstrap_data <- tidy_bootstrap(
  .x = mtcars$mpg,
  .num_sims = 2000
)

# Visualize bootstrap distribution
tidy_autoplot(bootstrap_data, .plot_type = "density")

# Calculate bootstrap statistics
bootstrap_data %>%
  bootstrap_unnest_tbl() %>%
  summarise(
    mean_est = mean(y),
    sd_est = sd(y),
    ci_lower = quantile(y, 0.025),
    ci_upper = quantile(y, 0.975)
  )
```

---

## 🎨 Customizing Visualizations

### Basic Customization

```r
# Generate data
data <- tidy_normal(.n = 100, .num_sims = 1)

# Customize plot
tidy_autoplot(
  data,
  .plot_type = "density",
  .line_size = 1,
  .geom_point = TRUE,
  .point_size = 2,
  .geom_rug = TRUE
)
```

### Interactive Plots

```r
# Create interactive plotly visualization
tidy_autoplot(
  data,
  .plot_type = "density",
  .interactive = TRUE
)
```

### Advanced ggplot2 Customization

```r
library(ggplot2)

# Get base plot and customize
p <- tidy_autoplot(data, .plot_type = "density")

p +
  theme_minimal() +
  labs(
    title = "Custom Distribution Plot",
    subtitle = "Normal Distribution with Mean = 0, SD = 1",
    x = "Value",
    y = "Density"
  ) +
  scale_color_brewer(palette = "Set1")
```

---

## 📊 Understanding the Output

### Tidy Tibble Structure

All `tidy_*` functions return a tibble with consistent structure:

```r
data <- tidy_normal(.n = 5, .num_sims = 2)
str(data)
```

**Attributes:**
- `.num_sims`: Number of simulations
- `.distribution_name`: Type of distribution
- Distribution-specific parameters (e.g., `.mean`, `.sd`)

### Working with Multiple Simulations

```r
# Generate multiple simulations
multi_sim <- tidy_normal(.n = 50, .num_sims = 10)

# Analyze by simulation
library(dplyr)

multi_sim %>%
  group_by(sim_number) %>%
  summarise(
    mean_y = mean(y),
    sd_y = sd(y),
    median_y = median(y)
  )
```

---

## 🔍 Exploring Available Functions

### List All Distribution Functions

```r
# Get all tidy_ functions
ls("package:TidyDensity") %>%
  grep("^tidy_", ., value = TRUE) %>%
  grep("^tidy_[a-z_]+$", ., value = TRUE) %>%
  sort()
```

### Get Help for Any Function

```r
# Access help documentation
?tidy_normal
?tidy_autoplot
?util_normal_param_estimate
```

### Browse Package Vignettes

```r
# List available vignettes
vignette(package = "TidyDensity")

# Open getting started vignette
vignette("getting-started", package = "TidyDensity")
```

---

## 💡 Tips for Beginners

### 1. Start Simple
Begin with common distributions like `tidy_normal()` or `tidy_uniform()` before exploring more complex ones.

### 2. Use Defaults
Most parameters have sensible defaults. Start with:
```r
tidy_normal()  # Uses default values
```

### 3. Experiment with Simulations
Use `.num_sims` parameter to see distribution behavior:
```r
tidy_normal(.n = 100, .num_sims = 20)
```

### 4. Check the Structure
Always examine the output structure first:
```r
data <- tidy_normal()
head(data)
attributes(data)
```

### 5. Use the Pipe
TidyDensity works great with pipes:
```r
tidy_normal(.n = 100) %>%
  tidy_autoplot(.plot_type = "density")
```

---

## 🐛 Troubleshooting

### Package Won't Load

```r
# Reinstall if having issues
remove.packages("TidyDensity")
install.packages("TidyDensity")
```

### Plotting Issues

If plots don't appear:
```r
# Make sure ggplot2 is loaded
library(ggplot2)

# For RStudio, check plot pane
dev.cur()  # Check active device

# Clear plots and try again
dev.off()
```

### Missing Dependencies

```r
# Install missing packages
install.packages(c("dplyr", "ggplot2", "tidyr", "purrr"))
```

---

## 🎓 Next Steps

Now that you're set up, explore:

1. **[Supported Distributions](Supported-Distributions.md)** - See all available distributions
2. **[Visualization and Plotting](Visualization-and-Plotting.md)** - Learn advanced plotting
3. **[Parameter Estimation](Parameter-Estimation.md)** - Fit distributions to your data
4. **[Examples and Use Cases](Examples-and-Use-Cases.md)** - Real-world applications

---

## 📚 Additional Resources

- **Package Website**: https://www.spsanderson.com/TidyDensity/
- **CRAN Page**: https://CRAN.R-project.org/package=TidyDensity
- **GitHub**: https://github.com/spsanderson/TidyDensity
- **Issues**: https://github.com/spsanderson/TidyDensity/issues

---

**Ready to dive deeper?** Continue to [Supported Distributions](Supported-Distributions.md) to see all available probability distributions!
