# Visualization and Plotting

TidyDensity provides powerful and flexible visualization capabilities through the `tidy_autoplot()` function and related plotting tools.

## 📋 Table of Contents

- [Basic Plotting with tidy_autoplot](#basic-plotting-with-tidy_autoplot)
- [Plot Types](#plot-types)
- [Customization Options](#customization-options)
- [Interactive Plots](#interactive-plots)
- [Multiple Distributions](#multiple-distributions)
- [Advanced Plotting Techniques](#advanced-plotting-techniques)
- [Color Schemes](#color-schemes)
- [Specialized Plots](#specialized-plots)

---

## 🎨 Basic Plotting with tidy_autoplot

### The Main Plotting Function

`tidy_autoplot()` is the primary function for visualizing distribution data:

```r
library(TidyDensity)

# Generate data
data <- tidy_normal(.n = 100, .num_sims = 5)

# Create a basic plot
tidy_autoplot(data, .plot_type = "density")
```

### Function Signature

```r
tidy_autoplot(
  .data,                    # Data from tidy_* function
  .plot_type = "density",   # Type of plot
  .line_size = 0.5,         # Line thickness
  .geom_point = FALSE,      # Add points?
  .point_size = 1,          # Point size
  .geom_rug = FALSE,        # Add rug plot?
  .geom_smooth = FALSE,     # Add smoothing?
  .geom_jitter = FALSE,     # Add jitter?
  .interactive = FALSE      # Make interactive with plotly?
)
```

---

## 📊 Plot Types

### 1. Density Plot

Visualizes the probability density function (PDF).

```r
data <- tidy_normal(.n = 100, .num_sims = 3)
tidy_autoplot(data, .plot_type = "density")
```

**Use Cases:**
- Understanding distribution shape
- Comparing distribution modes
- Identifying skewness
- Detecting multimodality

**What it shows:**
- X-axis: Possible values
- Y-axis: Probability density
- Multiple lines for multiple simulations

### 2. Quantile Plot

Shows the quantile function (inverse CDF).

```r
tidy_autoplot(data, .plot_type = "quantile")
```

**Use Cases:**
- Understanding percentiles
- Inverse probability calculations
- Risk assessment (VaR calculations)

**What it shows:**
- X-axis: Probability (0 to 1)
- Y-axis: Quantile value
- Useful for understanding extreme values

### 3. Probability Plot (CDF)

Displays the cumulative distribution function.

```r
tidy_autoplot(data, .plot_type = "probability")
```

**Use Cases:**
- Calculating cumulative probabilities
- Understanding distribution tail behavior
- Comparing empirical vs theoretical CDFs

**What it shows:**
- X-axis: Values
- Y-axis: Cumulative probability (0 to 1)
- S-shaped curve for continuous distributions

### 4. QQ Plot (Quantile-Quantile)

Compares data quantiles with theoretical quantiles.

```r
tidy_autoplot(data, .plot_type = "qq")
```

**Use Cases:**
- Testing distributional assumptions
- Checking normality
- Identifying departures from theoretical distribution

**What it shows:**
- X-axis: Theoretical quantiles
- Y-axis: Sample quantiles
- Points should fall on diagonal if distribution matches

### 5. MCMC Plot

Specialized for MCMC sampling visualization.

```r
# For use with MCMC sampling functions
tidy_autoplot(mcmc_data, .plot_type = "mcmc")
```

**Use Cases:**
- Bayesian analysis
- MCMC convergence diagnostics
- Posterior distribution visualization

---

## 🎯 Customization Options

### Line Customization

```r
data <- tidy_normal(.n = 100)

# Thick lines
tidy_autoplot(data, .line_size = 2)

# Thin lines
tidy_autoplot(data, .line_size = 0.3)
```

### Adding Points

```r
# Add points to the plot
tidy_autoplot(
  data,
  .plot_type = "density",
  .geom_point = TRUE,
  .point_size = 2
)
```

### Adding Rug Plot

A rug plot shows individual data points along the x-axis:

```r
tidy_autoplot(
  data,
  .plot_type = "density",
  .geom_rug = TRUE
)
```

**Benefits:**
- Shows actual data distribution
- Identifies clusters and gaps
- Useful for small to medium datasets

### Adding Smooth Line

Add a smoothed trend line:

```r
tidy_autoplot(
  data,
  .plot_type = "density",
  .geom_smooth = TRUE
)
```

### Combining Multiple Customizations

```r
tidy_autoplot(
  data,
  .plot_type = "density",
  .line_size = 1,
  .geom_point = TRUE,
  .point_size = 1.5,
  .geom_rug = TRUE,
  .geom_smooth = TRUE
)
```

---

## 🌐 Interactive Plots

### Creating Interactive Visualizations

Use `.interactive = TRUE` to create plotly plots:

```r
library(plotly)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Create interactive plot
tidy_autoplot(
  data,
  .plot_type = "density",
  .interactive = TRUE
)
```

**Interactive Features:**
- Hover to see values
- Zoom in/out
- Pan across plot
- Toggle series on/off
- Save as PNG

**Benefits:**
- Exploration of complex data
- Presentations and reports
- Web-based dashboards
- Better for multiple simulations

---

## 📈 Multiple Distributions

### Automatic Legend Management

TidyDensity intelligently manages legends:

```r
# Few simulations - legend shown
few_sims <- tidy_normal(.n = 100, .num_sims = 5)
tidy_autoplot(few_sims, .plot_type = "density")

# Many simulations - legend hidden automatically
many_sims <- tidy_normal(.n = 100, .num_sims = 20)
tidy_autoplot(many_sims, .plot_type = "density")
```

**Rule:** Legend is automatically hidden when `.num_sims > 9` to reduce clutter.

### Comparing Different Distributions

```r
# Generate different distributions
normal <- tidy_normal(.n = 100)
gamma <- tidy_gamma(.n = 100, .shape = 2, .rate = 1)
beta <- tidy_beta(.n = 100, .shape1 = 2, .shape2 = 5)

# Plot separately
tidy_autoplot(normal, .plot_type = "density")
tidy_autoplot(gamma, .plot_type = "density")
tidy_autoplot(beta, .plot_type = "density")

# Or combine using tidy_combine_distributions()
combined <- tidy_combine_distributions(normal, gamma, beta)
tidy_combined_autoplot(combined)
```

### Comparing Same Distribution with Different Parameters

```r
# Use tidy_multi_single_dist
comparison <- tidy_multi_single_dist(
  .tidy_dist = "tidy_normal",
  .param_list = list(
    list(.n = 100, .mean = 0, .sd = 0.5),
    list(.n = 100, .mean = 0, .sd = 1),
    list(.n = 100, .mean = 0, .sd = 2),
    list(.n = 100, .mean = 2, .sd = 1)
  )
)

tidy_autoplot(comparison, .plot_type = "density")
```

---

## 🎨 Advanced Plotting Techniques

### Using ggplot2 for Further Customization

Since `tidy_autoplot()` returns a ggplot object, you can customize further:

```r
library(ggplot2)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Get base plot
p <- tidy_autoplot(data, .plot_type = "density")

# Customize with ggplot2
p +
  theme_minimal() +
  labs(
    title = "Normal Distribution",
    subtitle = "Mean = 0, SD = 1",
    x = "Value",
    y = "Density",
    color = "Simulation"
  ) +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12),
    legend.position = "bottom"
  )
```

### Custom Color Scales

```r
library(ggplot2)

p <- tidy_autoplot(data, .plot_type = "density")

# Use different color palette
p + scale_color_brewer(palette = "Set1")

# Or use viridis
p + scale_color_viridis_d()

# Custom colors
p + scale_color_manual(values = c("red", "blue", "green"))
```

### Faceting Multiple Plot Types

```r
library(ggplot2)
library(patchwork)

data <- tidy_normal(.n = 100, .num_sims = 3)

# Create multiple plot types
p1 <- tidy_autoplot(data, .plot_type = "density")
p2 <- tidy_autoplot(data, .plot_type = "probability")
p3 <- tidy_autoplot(data, .plot_type = "quantile")
p4 <- tidy_autoplot(data, .plot_type = "qq")

# Combine using patchwork
(p1 | p2) / (p3 | p4)
```

### Saving Plots

```r
library(ggplot2)

# Create plot
p <- tidy_autoplot(data, .plot_type = "density")

# Save as PNG
ggsave("density_plot.png", p, width = 8, height = 6, dpi = 300)

# Save as PDF
ggsave("density_plot.pdf", p, width = 8, height = 6)

# Save as SVG (vector graphics)
ggsave("density_plot.svg", p, width = 8, height = 6)
```

---

## 🌈 Color Schemes

### Color-Blind Friendly Palettes

TidyDensity includes color-blind friendly palettes:

```r
# Access the palette
color_blind()

# View available colors
color_blind_tbl <- data.frame(
  color = color_blind(),
  index = 1:length(color_blind())
)

# Use in plots
library(ggplot2)

p <- tidy_autoplot(data, .plot_type = "density")
p + scale_color_manual(values = color_blind())
```

### Available Palettes

The package provides several palettes through `color_blind()` function that are accessible to people with various types of color vision deficiency.

---

## 📊 Specialized Plots

### Combined Distribution Plots

For comparing empirical and fitted distributions:

```r
# Estimate parameters from data
x <- mtcars$mpg
estimates <- util_normal_param_estimate(x, .auto_gen_empirical = TRUE)

# Plot combined data
estimates$combined_data_tbl %>%
  tidy_combined_autoplot()
```

### Triangular Distribution Plots

Special autoplot for triangular distributions:

```r
tri_data <- tidy_triangular(.n = 100, .min = 0, .max = 10, .mode = 7)

# Use specialized triangular autoplot
tidy_autoplot_triangular(tri_data)
```

### Random Walk Visualization

```r
# Generate random walk
rw <- tidy_random_walk(.n = 100, .num_walks = 5)

# Visualize
tidy_autoplot_random_walk(rw)
```

### Bootstrap Distribution Plots

```r
# Perform bootstrap
bootstrap <- tidy_bootstrap(.x = mtcars$mpg, .num_sims = 2000)

# Visualize bootstrap distribution
tidy_autoplot(bootstrap, .plot_type = "density")
```

---

## 📐 Plot Dimensions and Aspect Ratios

### Setting Plot Size in R Markdown

```r
# In chunk options
{r plot, fig.width=10, fig.height=6}
tidy_autoplot(data, .plot_type = "density")
```

### Setting Plot Size in Scripts

```r
# Using ggsave
p <- tidy_autoplot(data, .plot_type = "density")
ggsave("plot.png", p, width = 10, height = 6, units = "in")
```

---

## 🎯 Best Practices for Visualization

### 1. Choose the Right Plot Type

- **Density**: Understanding distribution shape
- **Probability**: Cumulative probabilities
- **Quantile**: Risk measures and percentiles
- **QQ**: Distribution validation

### 2. Use Appropriate Number of Simulations

```r
# For demonstration: 3-5 simulations
demo <- tidy_normal(.n = 100, .num_sims = 5)

# For variability assessment: 20-100 simulations
variability <- tidy_normal(.n = 100, .num_sims = 50)

# For convergence: 1000+ simulations
convergence <- tidy_normal(.n = 100, .num_sims = 1000)
```

### 3. Label Your Plots

```r
p <- tidy_autoplot(data, .plot_type = "density") +
  labs(
    title = "Distribution of X",
    subtitle = paste("Parameters:", "mean=0, sd=1"),
    x = "Value",
    y = "Density",
    caption = "Source: Simulation"
  )
```

### 4. Consider Your Audience

- **Technical audience**: Use QQ plots, multiple plot types
- **General audience**: Stick to density plots, add clear labels
- **Presentations**: Use interactive plots, larger fonts
- **Publications**: High DPI, vector graphics (PDF/SVG)

### 5. Use Interactive Plots for Exploration

```r
# Exploration phase
tidy_autoplot(data, .interactive = TRUE)

# Final publication
tidy_autoplot(data, .interactive = FALSE)
```

---

## 💡 Common Plotting Patterns

### Pattern 1: Generate, Plot, Analyze

```r
# Generate
data <- tidy_gamma(.n = 100, .shape = 2, .rate = 1, .num_sims = 5)

# Plot
tidy_autoplot(data, .plot_type = "density")

# Analyze
summary_stats <- data %>%
  group_by(sim_number) %>%
  summarise(
    mean = mean(y),
    sd = sd(y),
    median = median(y)
  )
```

### Pattern 2: Compare Parameters

```r
# Generate with different parameters
comparison <- tidy_multi_single_dist(
  .tidy_dist = "tidy_gamma",
  .param_list = list(
    list(.n = 100, .shape = 1, .rate = 1),
    list(.n = 100, .shape = 2, .rate = 1),
    list(.n = 100, .shape = 5, .rate = 1)
  )
)

# Plot comparison
tidy_autoplot(comparison, .plot_type = "density") +
  labs(title = "Gamma Distribution: Effect of Shape Parameter")
```

### Pattern 3: Fit and Validate

```r
# Fit distribution to data
x <- mtcars$mpg
fit <- util_normal_param_estimate(x, .auto_gen_empirical = TRUE)

# Visual validation
fit$combined_data_tbl %>%
  tidy_combined_autoplot()

# QQ plot for validation
tidy_normal(.n = length(x), 
            .mean = mean(x), 
            .sd = sd(x)) %>%
  tidy_autoplot(.plot_type = "qq")
```

---

## 🔍 Troubleshooting Plots

### Plot Doesn't Show

```r
# Make sure to print the plot
p <- tidy_autoplot(data, .plot_type = "density")
print(p)  # Explicitly print

# In scripts, this is done automatically
# In functions, you need to print or return
```

### Legend Too Large

```r
# Use more simulations (>9) to auto-hide legend
data <- tidy_normal(.n = 100, .num_sims = 15)
tidy_autoplot(data, .plot_type = "density")

# Or manually hide legend
tidy_autoplot(data, .plot_type = "density") +
  theme(legend.position = "none")
```

### Interactive Plot Won't Display

```r
# Make sure plotly is installed
install.packages("plotly")
library(plotly)

# Then create interactive plot
tidy_autoplot(data, .interactive = TRUE)
```

---

## 🎓 Next Steps

- **[Parameter Estimation](Parameter-Estimation)** - Fit distributions to data
- **[Advanced Features](Advanced-Features)** - Mixture models and more
- **[Examples and Use Cases](Examples-and-Use-Cases)** - Real-world applications

---

**Want to see more examples?** Check out the [Examples and Use Cases](Examples-and-Use-Cases) page!
