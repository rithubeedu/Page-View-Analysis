# 📄 Prior Product Knowledge & Page View Analysis

This project explores how user profiles—especially Parents and Teachers—differ in their product knowledge and browsing behavior on an e-commerce platform. It uses R for statistical testing and visualizations to support personalization and UX insights.

---

## 📂 Dataset Overview

**File:** `ecommerce-data-5.csv`

Each row contains user-level session data with fields like:
- `profile`: User type (Parent, Teacher, Student, etc.)
- `productKnewWhatWanted`: Whether users knew what they wanted to buy ("Yes", "No", or "Somewhat")
- `behavPageviews`: Number of product pages viewed, grouped (e.g., "2 to 3", "10+")
  
---

## 🔍 Key Analysis Questions

### 1. 🧠 Product Knowledge by Profile
- Compared the proportion of “Yes” and “No” responses for Parents vs Teachers.
- Used a **chi-square test** and **binomial test** to test for statistical significance.
- Limited analysis to "Yes" and "No" only for clarity.

### 2. 📊 Visualizing Product Knowledge
- Replaced broken `histogram()` usage with a proper bar chart using `lattice::barchart()`
- Showed comparative frequencies across profiles

### 3. 🔢 Page View Behavior
- Converted `behavPageviews` from text ranges to integers (`pageViewInt`)
  - e.g., `"2 to 3"` → `2`, `"10+"` → `10`
- Conducted:
  - **t-test**: Compared average page views between Parents and Teachers
  - **ANOVA**: Compared all profiles
  - **Tukey’s HSD** test: Post-hoc comparisons between profile groups
- Plotted **95% confidence intervals** for all comparisons

---

## 📊 Sample Output

| Profile  | % Knew What Wanted | Avg. Page Views |
|----------|--------------------|-----------------|
| Parent   | 62.3%              | 3.4             |
| Teacher  | 77.5%              | 4.7             |

---

## 🛠️ Tools Used

- Language: **R**
- Libraries: `lattice`, `multcomp`
- Techniques: `t.test()`, `aov()`, `chisq.test()`, `binom.test()`, `glht()`, `barchart()`

---

## 📁 Suggested Project Structure

