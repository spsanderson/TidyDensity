# TidyDensity Wiki

Welcome to the **TidyDensity** wiki! This comprehensive guide will help you master working with probability distributions in R using the tidyverse ecosystem.

## 📚 Quick Navigation

### Getting Started
- **[Installation and Quick Start](Installation-and-Quick-Start)** - Get up and running quickly
- **[Core Concepts](Core-Concepts)** - Understand the fundamental principles

### Main Features
- **[Supported Distributions](Supported-Distributions)** - Complete list of 35+ distributions
- **[Visualization and Plotting](Visualization-and-Plotting)** - Create beautiful visualizations
- **[Parameter Estimation](Parameter-Estimation)** - Estimate distribution parameters from data
- **[Bootstrap Analysis](Bootstrap-Analysis)** - Perform robust statistical inference
- **[Advanced Features](Advanced-Features)** - Mixture models, empirical distributions, and more

### Reference
- **[Function Reference](Function-Reference)** - Complete function documentation organized by category
- **[Examples and Use Cases](Examples-and-Use-Cases)** - Real-world examples and tutorials
- **[FAQ and Troubleshooting](FAQ-and-Troubleshooting)** - Common questions and solutions

### Contributing
- **[Contributing Guidelines](Contributing-Guidelines)** - How to contribute to the project
- **[Development Setup](Development-Setup)** - Set up your development environment

---

## 🎯 What is TidyDensity?

**TidyDensity** is a comprehensive R package that makes working with random numbers and probability distributions easy, intuitive, and tidy. It provides a unified interface for:

- 🎲 **Generating random data** from 35+ probability distributions
- 📊 **Visualizing distributions** with publication-ready plots
- 🔍 **Estimating parameters** from empirical data
- 🔄 **Bootstrap resampling** for robust inference
- 🎨 **Creating mixture models** and combining distributions
- 📈 **Analyzing data** in a tidy, reproducible manner

All output is returned as **tidy tibbles**, making it seamlessly compatible with the tidyverse ecosystem.

---

## 🌟 Key Features at a Glance

### Comprehensive Distribution Support
- **35+ distributions** including Normal, Beta, Gamma, Weibull, Poisson, and many more
- Both **continuous and discrete** distributions
- **Zero-truncated** variants for count data
- **Inverse** and **generalized** distribution families

### Consistent Tidy Output
Every distribution function returns a tibble with:
- `sim_number` - Simulation identifier
- `x` - Observation index
- `y` - Generated random value
- `dx`, `dy` - Density function values
- `p` - Cumulative probability (CDF)
- `q` - Quantile values

### Rich Visualization
- 🎨 Multiple plot types: density, quantile, probability, QQ
- 📊 Automatic legend management for multiple simulations
- 🖼️ Publication-ready ggplot2 graphics
- 🌐 Interactive plotly plots
- 🎯 Customizable aesthetics

### Statistical Tools
- 📈 **Parameter estimation** using MLE, MME, and MVUE methods
- 🔄 **Bootstrap resampling** with integrated analysis
- 🎲 **Mixture models** for complex distributions
- 📉 **AIC calculation** for model comparison
- 📊 **Summary statistics** for all distributions

---

## 🚀 Quick Example

```r
library(TidyDensity)

# Generate data from normal distribution
normal_data <- tidy_normal(.n = 100, .mean = 0, .sd = 1, .num_sims = 5)

# View the tidy tibble
normal_data

# Create a density plot
tidy_autoplot(normal_data, .plot_type = "density")

# Estimate parameters from data
x <- mtcars$mpg
estimates <- util_normal_param_estimate(x, .auto_gen_empirical = TRUE)
estimates$parameter_tbl

# Compare empirical and fitted distribution
estimates$combined_data_tbl |>
  tidy_combined_autoplot()
```

---

## 📖 Documentation Resources

- **[CRAN Page](https://CRAN.R-project.org/package=TidyDensity)** - Official CRAN release
- **[Package Website](https://www.spsanderson.com/TidyDensity/)** - Complete pkgdown documentation
- **[GitHub Repository](https://github.com/spsanderson/TidyDensity)** - Source code and issues
- **[Getting Started Vignette](https://www.spsanderson.com/TidyDensity/articles/getting-started.html)** - Detailed introduction

---

## 💡 Why TidyDensity?

### For Data Scientists
- Work with distributions in a familiar tidy format
- Seamless integration with dplyr, ggplot2, and tidyverse
- Reproducible random number generation
- Easy comparison of multiple distributions

### For Statisticians
- Access to 35+ distribution families
- Multiple parameter estimation methods
- Bootstrap and resampling capabilities
- Mixture model support

### For Educators
- Intuitive syntax for teaching statistics
- Beautiful visualizations for presentations
- Consistent interface across all distributions
- Extensive documentation and examples

### For Researchers
- Generate synthetic data for simulations
- Fit distributions to empirical data
- Create publication-ready figures
- Reproducible research workflows

---

## 🤝 Community and Support

- 🐛 **Report Issues**: [GitHub Issues](https://github.com/spsanderson/TidyDensity/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/spsanderson/TidyDensity/discussions)
- ⭐ **Star the Project**: Show your support on [GitHub](https://github.com/spsanderson/TidyDensity)
- 📧 **Contact**: Steven P. Sanderson II, MPH - spsanderson@gmail.com

---

## 📄 License

TidyDensity is released under the MIT License. See [LICENSE.md](https://github.com/spsanderson/TidyDensity/blob/master/LICENSE.md) for details.

---

## 📝 Citation

If you use TidyDensity in your research, please cite it:

```r
citation("TidyDensity")
```

---

**Ready to get started?** Check out the [Installation and Quick Start](Installation-and-Quick-Start) guide!
