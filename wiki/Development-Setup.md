# Development Setup

Guide for setting up a development environment for contributing to TidyDensity.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Development Tools](#development-tools)
- [Building the Package](#building-the-package)
- [Running Tests](#running-tests)
- [Documentation](#documentation)
- [Workflow Tips](#workflow-tips)
- [Troubleshooting](#troubleshooting)

---

## ✅ Prerequisites

### Required Software

#### 1. R (>= 4.1.0)

**Check your R version:**
```r
R.version.string
```

**Install/Update R:**
- **Windows**: Download from [CRAN](https://cran.r-project.org/bin/windows/base/)
- **macOS**: Download from [CRAN](https://cran.r-project.org/bin/macosx/)
- **Linux**: Use package manager
  ```bash
  # Ubuntu/Debian
  sudo apt-get update
  sudo apt-get install r-base r-base-dev
  ```

#### 2. RStudio (Recommended)

**Download:** https://posit.co/download/rstudio-desktop/

**Benefits:**
- Integrated development environment
- Built-in Git support
- Package development tools
- Code completion and syntax highlighting

#### 3. Git

**Check if installed:**
```bash
git --version
```

**Install if needed:**
- **Windows**: https://git-scm.com/download/win
- **macOS**: Install Xcode Command Line Tools
  ```bash
  xcode-select --install
  ```
- **Linux**: Use package manager
  ```bash
  sudo apt-get install git
  ```

#### 4. Development Tools

**Windows:**
- Install [Rtools](https://cran.r-project.org/bin/windows/Rtools/)
- Required for building packages from source

**macOS:**
- Install Xcode Command Line Tools (see above)
- May need gfortran: https://github.com/fxcoudert/gfortran-for-macOS

**Linux:**
- Build essentials usually included
  ```bash
  sudo apt-get install build-essential
  ```

---

## 🚀 Initial Setup

### 1. Fork and Clone Repository

**Fork on GitHub:**
1. Go to https://github.com/spsanderson/TidyDensity
2. Click "Fork" button
3. Creates fork under your account

**Clone your fork:**
```bash
# Replace YOUR-USERNAME with your GitHub username
git clone https://github.com/YOUR-USERNAME/TidyDensity.git
cd TidyDensity
```

**Add upstream remote:**
```bash
git remote add upstream https://github.com/spsanderson/TidyDensity.git
git remote -v
```

### 2. Install Development Dependencies

**In R:**
```r
# Install devtools
install.packages("devtools")

# Install TidyDensity dependencies
devtools::install_dev_deps()

# Or manually install key packages
install.packages(c(
  # Core dependencies
  "dplyr", "ggplot2", "tidyr", "purrr", "magrittr", "rlang",
  "plotly", "actuar", "survival", "nloptr", "broom", "patchwork",
  
  # Development tools
  "devtools", "usethis", "testthat", "roxygen2",
  "pkgdown", "covr", "lintr",
  
  # Documentation
  "rmarkdown", "knitr"
))
```

### 3. Configure Git

**Set your identity:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Set up SSH (optional but recommended):**
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key and add to GitHub
cat ~/.ssh/id_ed25519.pub
# Go to GitHub Settings > SSH and GPG keys > New SSH key
```

---

## 🛠️ Development Tools

### Essential R Packages

#### devtools
**Package development toolkit:**
```r
library(devtools)

# Load package for testing
load_all()

# Install package locally
install()

# Check package
check()

# Run tests
test()

# Build package
build()
```

#### usethis
**Package setup and management:**
```r
library(usethis)

# Create new function file
use_r("my_function")

# Create new test file
use_test("my_function")

# Add package dependency
use_package("ggplot2")

# Create vignette
use_vignette("my-vignette")
```

#### testthat
**Unit testing framework:**
```r
library(testthat)

# Run all tests
test()

# Run specific test file
test_file("tests/testthat/test-tidy-normal.R")

# Interactive testing
test_local()
```

#### roxygen2
**Documentation generation:**
```r
library(roxygen2)

# Generate documentation
document()

# Check documentation
check_man()
```

### Optional but Useful

#### lintr
**Code style checking:**
```r
library(lintr)

# Lint entire package
lint_package()

# Lint specific file
lint("R/tidy-normal.R")
```

#### covr
**Test coverage analysis:**
```r
library(covr)

# Package coverage
package_coverage()

# Specific file coverage
file_coverage("R/tidy-normal.R", "tests/testthat/test-tidy-normal.R")

# Interactive coverage report
report()
```

#### pkgdown
**Package website generation:**
```r
library(pkgdown)

# Build website
build_site()

# Preview website
preview_site()

# Build only reference
build_reference()
```

---

## 🔨 Building the Package

### Quick Build and Check

```r
# 1. Load package for interactive development
devtools::load_all()

# 2. Test your changes
devtools::test()

# 3. Generate documentation
devtools::document()

# 4. Check package (comprehensive)
devtools::check()

# 5. Install locally
devtools::install()
```

### Build Process Details

#### Load Package
```r
# Load without installing
devtools::load_all()

# Now you can test functions interactively
tidy_normal(.n = 10)
```

#### Update Documentation
```r
# After modifying roxygen comments
devtools::document()

# Check documentation
?tidy_normal
```

#### Run Checks
```r
# Full R CMD check
devtools::check()

# Quick check (skip some tests)
devtools::check(document = FALSE, vignettes = FALSE)

# Check specific aspects
devtools::check_built()
devtools::check_rhub()
```

### Build Package Tarball

```r
# Build source package
devtools::build()

# Build without vignettes (faster)
devtools::build(vignettes = FALSE)

# Build binary package (Windows)
devtools::build(binary = TRUE)
```

---

## 🧪 Running Tests

### Test Organization

```
tests/
└── testthat/
    ├── test-tidy-normal.R
    ├── test-autoplot.R
    ├── test-param-estimate.R
    └── ...
```

### Writing Tests

```r
# tests/testthat/test-example.R

test_that("tidy_normal generates correct structure", {
  result <- tidy_normal(.n = 10, .num_sims = 2)
  
  # Test class
  expect_s3_class(result, "tbl_df")
  
  # Test dimensions
  expect_equal(nrow(result), 20)
  expect_equal(ncol(result), 7)
  
  # Test column names
  expect_named(result, c("sim_number", "x", "y", "dx", "dy", "p", "q"))
  
  # Test values
  expect_type(result$y, "double")
  expect_true(all(!is.na(result$y)))
})

test_that("tidy_normal validates parameters", {
  expect_error(tidy_normal(.n = -1))
  expect_error(tidy_normal(.sd = -1))
  expect_error(tidy_normal(.n = "invalid"))
})
```

### Running Tests

```r
# All tests
devtools::test()

# Specific file
devtools::test_file("tests/testthat/test-tidy-normal.R")

# Specific test
devtools::test_file("tests/testthat/test-tidy-normal.R", 
                    filter = "generates correct structure")

# With coverage
covr::package_coverage()
```

### Test Coverage

```r
# Overall coverage
covr::package_coverage()

# Coverage report (opens browser)
covr::report()

# File-specific coverage
covr::file_coverage("R/tidy-normal.R", "tests/testthat/test-tidy-normal.R")
```

---

## 📝 Documentation

### Function Documentation (roxygen2)

```r
#' Generate Random Normal Distribution Data
#'
#' @description
#' This function generates random data from a normal distribution
#' and returns it in a tidy tibble format.
#'
#' @details
#' The function uses `stats::rnorm()` internally and adds density,
#' probability, and quantile information to each observation.
#'
#' @param .n Number of observations to generate (positive integer)
#' @param .mean Mean of the distribution (numeric)
#' @param .sd Standard deviation (positive numeric)
#' @param .num_sims Number of simulations (positive integer)
#' @param .return_tibble Return as tibble? (logical)
#'
#' @return
#' A tibble with columns:
#' \describe{
#'   \item{sim_number}{Simulation identifier}
#'   \item{x}{Observation number}
#'   \item{y}{Generated random value}
#'   \item{dx}{Density function x-values}
#'   \item{dy}{Density function y-values}
#'   \item{p}{Cumulative probability}
#'   \item{q}{Quantile values}
#' }
#'
#' @examples
#' # Basic usage
#' tidy_normal(.n = 50)
#'
#' # With parameters
#' tidy_normal(.n = 100, .mean = 10, .sd = 2)
#'
#' # Multiple simulations
#' tidy_normal(.n = 50, .num_sims = 5)
#'
#' @export
#' @family Continuous Distribution
#' @family Gaussian
#'
tidy_normal <- function(.n = 50, .mean = 0, .sd = 1, 
                       .num_sims = 1, .return_tibble = TRUE) {
  # Function implementation
}
```

### Building Documentation

```r
# Generate all documentation
devtools::document()

# Preview documentation
?tidy_normal

# Check for documentation issues
devtools::check_man()
```

### README

**Edit README.Rmd, not README.md:**
```r
# Edit README.Rmd

# Then knit to create README.md
rmarkdown::render("README.Rmd")

# Or use devtools
devtools::build_readme()
```

### Vignettes

```r
# Create new vignette
usethis::use_vignette("my-vignette")

# Build vignettes
devtools::build_vignettes()

# View vignette
browseVignettes("TidyDensity")
```

### Package Website (pkgdown)

```r
# Initial setup (already done)
usethis::use_pkgdown()

# Build complete site
pkgdown::build_site()

# Build specific components
pkgdown::build_home()
pkgdown::build_reference()
pkgdown::build_articles()

# Preview site
pkgdown::preview_site()
```

---

## 💡 Workflow Tips

### Daily Development Workflow

```r
# 1. Update from upstream
# (in terminal)
git fetch upstream
git merge upstream/main

# 2. Create feature branch
git checkout -b feature/my-feature

# 3. Load package
devtools::load_all()

# 4. Make changes and test interactively
your_function(test_data)

# 5. Write/update tests
usethis::use_test("your-function")

# 6. Run tests
devtools::test()

# 7. Update documentation
devtools::document()

# 8. Check package
devtools::check()

# 9. Commit changes
git add .
git commit -m "feat: add new feature"

# 10. Push to your fork
git push origin feature/my-feature
```

### RStudio Keyboard Shortcuts

- **Ctrl/Cmd + Shift + L** - Load package (`load_all()`)
- **Ctrl/Cmd + Shift + T** - Run tests (`test()`)
- **Ctrl/Cmd + Shift + D** - Generate documentation (`document()`)
- **Ctrl/Cmd + Shift + E** - Check package (`check()`)
- **Ctrl/Cmd + Shift + B** - Build and reload package

### Git Best Practices

```bash
# Fetch updates regularly
git fetch upstream

# Keep your main branch updated
git checkout main
git merge upstream/main
git push origin main

# Create feature branches from updated main
git checkout -b feature/my-feature

# Commit small, logical changes
git add specific-file.R
git commit -m "descriptive message"

# Push feature branches to your fork
git push origin feature/my-feature
```

---

## 🔧 Troubleshooting

### Common Issues

#### "Function not found" after load_all()

```r
# Restart R session
.rs.restartR()

# Reload package
devtools::load_all()
```

#### "Object not found" in tests

```r
# Make sure to export functions
#' @export
my_function <- function() {}

# Or use ::: for internal functions in tests
TidyDensity:::internal_function()
```

#### Documentation not updating

```r
# Clean and rebuild
devtools::clean_vignettes()
devtools::document()

# If still issues, restart R
.rs.restartR()
devtools::document()
```

#### Check fails with namespace issues

```r
# Clean up namespace
devtools::document()

# Check NAMESPACE file manually
# Make sure exports are correct
```

#### Build fails on Windows

- Install/update Rtools
- Check PATH includes Rtools
- Restart RStudio after installing Rtools

---

## 📚 Additional Resources

### Documentation
- [R Packages Book](https://r-pkgs.org/) - Comprehensive guide
- [devtools documentation](https://devtools.r-lib.org/)
- [testthat documentation](https://testthat.r-lib.org/)
- [roxygen2 documentation](https://roxygen2.r-lib.org/)

### Style Guides
- [Tidyverse Style Guide](https://style.tidyverse.org/)
- [Google's R Style Guide](https://google.github.io/styleguide/Rguide.html)

### Tools
- [RStudio IDE](https://posit.co/products/open-source/rstudio/)
- [Git documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)

---

## 🎓 Next Steps

1. **Set up your environment** following this guide
2. **Read** [Contributing Guidelines](Contributing-Guidelines) for contribution process
3. **Pick an issue** from [GitHub Issues](https://github.com/spsanderson/TidyDensity/issues)
4. **Start coding!**

---

**Questions?** Ask on [GitHub Discussions](https://github.com/spsanderson/TidyDensity/discussions) or see [Contributing Guidelines](Contributing-Guidelines)!
