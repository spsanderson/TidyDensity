# Contributing Guidelines

Thank you for your interest in contributing to TidyDensity! This guide will help you get started.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Contributing Code](#contributing-code)
- [Documentation Contributions](#documentation-contributions)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

---

## 🤝 Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](https://github.com/spsanderson/TidyDensity/blob/master/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

**In summary:**
- Be respectful and inclusive
- Be patient and welcoming
- Be thoughtful and constructive
- Focus on what is best for the community

Report unacceptable behavior to: spsanderson@gmail.com

---

## 🎯 How Can I Contribute?

There are many ways to contribute to TidyDensity:

### 1. Reporting Bugs 🐛
Found a bug? Please report it! See [Reporting Bugs](#reporting-bugs) below.

### 2. Suggesting Enhancements 💡
Have an idea for a new feature or improvement? See [Suggesting Enhancements](#suggesting-enhancements).

### 3. Writing Code 💻
Want to fix a bug or implement a feature? See [Contributing Code](#contributing-code).

### 4. Improving Documentation 📝
Documentation can always be better! See [Documentation Contributions](#documentation-contributions).

### 5. Adding Examples 📊
Share how you use TidyDensity in real projects.

### 6. Answering Questions ❓
Help others on GitHub Discussions and Issues.

### 7. Spreading the Word 📢
Star the repository, write blog posts, give talks!

---

## 🐛 Reporting Bugs

Before creating a bug report, please:

1. **Check existing issues** - Your bug may already be reported
2. **Update to latest version** - Bug may be already fixed
3. **Create a minimal reproducible example** - Simplest code that demonstrates the bug

### How to Submit a Bug Report

1. Go to [GitHub Issues](https://github.com/spsanderson/TidyDensity/issues)
2. Click "New Issue"
3. Use the bug report template
4. Provide:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Minimal reproducible example
   - Session info (`sessionInfo()`)

### Example Bug Report

```markdown
**Title:** tidy_normal() fails with negative .sd parameter

**Description:**
The function crashes instead of providing informative error.

**To Reproduce:**
```r
library(TidyDensity)
tidy_normal(.n = 100, .sd = -1)
```

**Expected behavior:**
Should return error message: "'.sd' must be positive"

**Actual behavior:**
```
Error in rnorm(n, mu, std) : invalid arguments
```

**Session info:**
```r
sessionInfo()
# R version 4.3.0 (2023-04-21)
# TidyDensity version: 1.5.2
# Platform: x86_64-pc-linux-gnu
```
```

---

## 💡 Suggesting Enhancements

Before suggesting an enhancement:

1. **Check if it already exists** - Search issues and discussions
2. **Check the development version** - May already be implemented
3. **Provide clear use case** - Why is this useful?

### How to Suggest an Enhancement

1. Go to [GitHub Discussions](https://github.com/spsanderson/TidyDensity/discussions)
2. Start a new discussion in "Ideas" category
3. Provide:
   - Clear description of the enhancement
   - Use case / motivation
   - Example of how it would work
   - Any relevant references

### Example Enhancement Suggestion

```markdown
**Title:** Add Gumbel distribution support

**Description:**
Add support for Gumbel (Type-I extreme value) distribution.

**Use Case:**
Gumbel distribution is commonly used in:
- Extreme value analysis
- Hydrology (flood prediction)
- Financial risk assessment

**Proposed API:**
```r
tidy_gumbel(
  .n = 50,
  .location = 0,
  .scale = 1,
  .num_sims = 1
)
```

**References:**
- https://en.wikipedia.org/wiki/Gumbel_distribution
- Similar to existing tidy_weibull() structure
```

---

## 💻 Contributing Code

### First Time Contributors

Look for issues labeled:
- `good first issue` - Good for newcomers
- `help wanted` - Community help appreciated
- `documentation` - Documentation improvements

### Development Workflow

1. **Fork the repository**
   ```bash
   # On GitHub, click "Fork" button
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/TidyDensity.git
   cd TidyDensity
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/my-new-feature
   # or
   git checkout -b fix/my-bug-fix
   ```

4. **Make your changes**
   - Write code
   - Add tests
   - Update documentation

5. **Test your changes**
   ```r
   # Load package
   devtools::load_all()
   
   # Run tests
   devtools::test()
   
   # Check package
   devtools::check()
   ```

6. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: description"
   ```

7. **Push to your fork**
   ```bash
   git push origin feature/my-new-feature
   ```

8. **Create Pull Request**
   - Go to your fork on GitHub
   - Click "Pull Request"
   - Fill in the template

---

## 📝 Documentation Contributions

### Types of Documentation

1. **Function Documentation (roxygen2)**
   - Located in R source files
   - Use `@param`, `@return`, `@examples`
   - Build with `devtools::document()`

2. **Vignettes**
   - Located in `vignettes/` directory
   - R Markdown format
   - Build with `devtools::build_vignettes()`

3. **README**
   - Edit `README.Rmd` (not `README.md`)
   - Build with `rmarkdown::render("README.Rmd")`

4. **Wiki**
   - Markdown files
   - Can be edited directly on GitHub
   - Or through pull requests

### Documentation Style

**Be clear and concise:**
```r
#' Calculate the mean of a distribution
#'
#' This function calculates the theoretical mean based on distribution parameters.
#'
#' @param .shape Shape parameter (must be positive)
#' @param .rate Rate parameter (must be positive)
#'
#' @return Numeric value representing the mean
#'
#' @examples
#' calculate_mean(.shape = 2, .rate = 1)
#' # Returns: 2
```

**Provide examples:**
- Real-world examples
- Edge cases
- Common use patterns

---

## 🎨 Style Guidelines

TidyDensity follows tidyverse style guide with some variations:

### R Code Style

**Naming:**
```r
# Functions: snake_case with tidy_ prefix for user-facing
tidy_normal()
util_normal_param_estimate()

# Variables: snake_case
sample_mean <- mean(data)
standard_deviation <- sd(data)

# Parameters: dot prefix for function parameters
.n = 50
.mean = 0
.auto_gen_empirical = TRUE
```

**Spacing:**
```r
# Use spaces around operators
x <- 5 + 3

# Space after comma
list(a = 1, b = 2)

# No space before comma
c(1, 2, 3)

# Space after #
# This is a comment
```

**Indentation:**
```r
# 2 spaces (not tabs)
if (condition) {
  do_something()
  do_another_thing()
}
```

### Documentation Style

**Use active voice:**
```r
# Good
#' Generates random numbers from normal distribution

# Avoid
#' Random numbers are generated from normal distribution
```

**Be specific:**
```r
# Good
#' @param .n Number of observations (must be positive integer)

# Avoid
#' @param .n Some number
```

---

## 📨 Commit Messages

Follow these guidelines for commit messages:

### Format

```
<type>: <subject>

<body>

<footer>
```

### Types

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

### Examples

**Good commit messages:**
```
feat: Add support for Gumbel distribution

Implements tidy_gumbel() function with parameter estimation
and AIC calculation. Includes tests and documentation.

Closes #123
```

```
fix: Handle negative values in util_gamma_param_estimate()

Previously crashed when data contained negative values.
Now provides informative error message.

Fixes #456
```

**Avoid:**
```
updated stuff
fixed bug
changes
```

---

## 🔄 Pull Request Process

### Before Submitting

1. **Update your branch**
   ```bash
   git checkout main
   git pull upstream main
   git checkout your-branch
   git rebase main
   ```

2. **Run checks**
   ```r
   devtools::check()
   ```

3. **Update documentation**
   ```r
   devtools::document()
   ```

4. **Update NEWS.md** if appropriate
   ```markdown
   ## TidyDensity (development version)
   
   ### New Features
   * Added Gumbel distribution support (#123)
   
   ### Bug Fixes
   * Fixed negative value handling in gamma estimation (#456)
   ```

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix (non-breaking change fixing an issue)
- [ ] New feature (non-breaking change adding functionality)
- [ ] Breaking change (fix or feature causing existing functionality to change)
- [ ] Documentation update

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have commented my code, particularly hard-to-understand areas
- [ ] I have updated the documentation
- [ ] I have added tests that prove my fix/feature works
- [ ] All new and existing tests pass
- [ ] I have updated NEWS.md if appropriate

## Related Issues
Closes #issue_number
```

### Review Process

1. **Automated checks run** - Must pass before review
2. **Maintainer review** - May request changes
3. **Revision** - Address feedback, push updates
4. **Approval** - Once approved, will be merged
5. **Merge** - Maintainer merges your PR

---

## 🧪 Testing

### Writing Tests

Tests use `testthat` framework:

```r
# tests/testthat/test-tidy-normal.R

test_that("tidy_normal generates correct output structure", {
  result <- tidy_normal(.n = 10, .num_sims = 2)
  
  expect_s3_class(result, "tbl_df")
  expect_equal(ncol(result), 7)
  expect_equal(nrow(result), 20)  # 10 * 2
  expect_named(result, c("sim_number", "x", "y", "dx", "dy", "p", "q"))
})

test_that("tidy_normal validates parameters", {
  expect_error(tidy_normal(.n = -1), "must be greater than 0")
  expect_error(tidy_normal(.sd = -1), "must be positive")
})
```

### Running Tests

```r
# Run all tests
devtools::test()

# Run specific test file
devtools::test_file("tests/testthat/test-tidy-normal.R")

# Run with coverage
covr::package_coverage()
```

---

## 📚 Additional Resources

- **Package Website**: https://www.spsanderson.com/TidyDensity/
- **GitHub Repository**: https://github.com/spsanderson/TidyDensity
- **Issue Tracker**: https://github.com/spsanderson/TidyDensity/issues
- **Discussions**: https://github.com/spsanderson/TidyDensity/discussions

### Learning Resources

- [R Packages Book](https://r-pkgs.org/) by Hadley Wickham
- [Tidyverse Style Guide](https://style.tidyverse.org/)
- [Advanced R](https://adv-r.hadley.nz/) by Hadley Wickham
- [R Package Documentation](https://roxygen2.r-lib.org/)

---

## 🎉 Recognition

All contributors will be:
- Listed in package credits
- Mentioned in release notes
- Added to package documentation

Thank you for contributing to TidyDensity!

---

## 💬 Questions?

- Ask on [GitHub Discussions](https://github.com/spsanderson/TidyDensity/discussions)
- Email: spsanderson@gmail.com
- See [Development Setup](Development-Setup) for environment configuration

---

**Ready to contribute?** Check out [Development Setup](Development-Setup) to get your environment ready!
