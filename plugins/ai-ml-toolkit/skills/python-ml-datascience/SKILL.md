---
name: python-ml-datascience
description: Comprehensive guide for Python-based machine learning and data science workflows including pandas/numpy data manipulation, scikit-learn model development, PyTorch/TensorFlow deep learning, feature engineering, model evaluation, and Jupyter notebook best practices. Use when building ML models, analyzing data, or working with data science libraries.
---

# Python ML & Data Science Development Guide

## Overview

This skill provides battle-tested patterns for data science and machine learning development in Python, covering the full ML workflow from data exploration to model deployment.

---

## Data Manipulation with Pandas & NumPy

### Loading and Inspecting Data

```python
import pandas as pd
import numpy as np

# Read various formats
df = pd.read_csv('data.csv')
df = pd.read_excel('data.xlsx', sheet_name='Sheet1')
df = pd.read_json('data.json')
df = pd.read_parquet('data.parquet')

# Quick inspection
df.head()
df.tail()
df.info()
df.describe()
df.shape
df.columns
df.dtypes

# Check for missing values
df.isnull().sum()
df.isnull().sum() / len(df) * 100  # Percentage

# Check duplicates
df.duplicated().sum()
```

### Data Cleaning Patterns

```python
# Handle missing values
df['column'].fillna(df['column'].mean(), inplace=True)  # Fill with mean
df['column'].fillna(df['column'].median(), inplace=True)  # Fill with median
df['column'].fillna(method='ffill', inplace=True)  # Forward fill
df.dropna(subset=['important_column'], inplace=True)  # Drop rows with nulls

# Remove duplicates
df.drop_duplicates(subset=['id'], keep='first', inplace=True)

# Handle outliers using IQR
Q1 = df['value'].quantile(0.25)
Q3 = df['value'].quantile(0.75)
IQR = Q3 - Q1
df = df[(df['value'] >= Q1 - 1.5*IQR) & (df['value'] <= Q3 + 1.5*IQR)]

# Data type conversions
df['date_column'] = pd.to_datetime(df['date_column'])
df['numeric_column'] = pd.to_numeric(df['numeric_column'], errors='coerce')
df['category_column'] = df['category_column'].astype('category')
```

### Data Transformation

```python
# Select columns
df[['col1', 'col2', 'col3']]

# Filter rows
df[df['age'] > 25]
df[(df['age'] > 25) & (df['city'] == 'NYC')]
df.query('age > 25 and city == "NYC"')

# Create new columns
df['age_group'] = pd.cut(df['age'], bins=[0, 18, 65, 100], labels=['minor', 'adult', 'senior'])
df['full_name'] = df['first_name'] + ' ' + df['last_name']

# Apply functions
df['column'] = df['column'].apply(lambda x: x * 2)
df['result'] = df.apply(lambda row: row['col1'] + row['col2'], axis=1)

# Group by and aggregate
df.groupby('category').agg({
    'value': ['sum', 'mean', 'count'],
    'amount': 'max'
}).reset_index()

# Pivot tables
pd.pivot_table(df, values='sales', index='region', columns='product', aggfunc='sum')

# Merge dataframes
merged_df = pd.merge(df1, df2, on='id', how='left')
merged_df = pd.merge(df1, df2, left_on='user_id', right_on='id', how='inner')

# Concatenate
pd.concat([df1, df2], axis=0, ignore_index=True)  # Vertically
pd.concat([df1, df2], axis=1)  # Horizontally
```

### NumPy Operations

```python
import numpy as np

# Array creation
arr = np.array([1, 2, 3, 4, 5])
arr = np.zeros((3, 4))
arr = np.ones((2, 3))
arr = np.arange(0, 10, 2)  # [0, 2, 4, 6, 8]
arr = np.linspace(0, 1, 5)  # 5 evenly spaced values

# Array operations
arr.mean()
arr.std()
arr.sum()
arr.min()
arr.max()

# Reshaping
arr.reshape(2, -1)  # Auto-calculate second dimension
arr.flatten()

# Boolean indexing
arr[arr > 5]

# Vectorized operations (FAST!)
arr * 2
np.sqrt(arr)
np.exp(arr)
```

---

## Feature Engineering

### Categorical Encoding

```python
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
import pandas as pd

# Label Encoding (ordinal)
le = LabelEncoder()
df['category_encoded'] = le.fit_transform(df['category'])

# One-Hot Encoding
df_encoded = pd.get_dummies(df, columns=['category'], prefix='cat')

# Or using sklearn
from sklearn.preprocessing import OneHotEncoder
ohe = OneHotEncoder(sparse_output=False, handle_unknown='ignore')
encoded = ohe.fit_transform(df[['category']])
df_encoded = pd.DataFrame(encoded, columns=ohe.get_feature_names_out())
```

### Numerical Scaling

```python
from sklearn.preprocessing import StandardScaler, MinMaxScaler, RobustScaler

# Standardization (mean=0, std=1)
scaler = StandardScaler()
df['value_scaled'] = scaler.fit_transform(df[['value']])

# Min-Max Scaling (0 to 1)
scaler = MinMaxScaler()
df['value_scaled'] = scaler.fit_transform(df[['value']])

# Robust Scaler (handles outliers)
scaler = RobustScaler()
df['value_scaled'] = scaler.fit_transform(df[['value']])

# IMPORTANT: Fit on training data only, then transform test data
scaler.fit(X_train)
X_train_scaled = scaler.transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

### Feature Creation

```python
# Date features
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month
df['day'] = df['date'].dt.day
df['dayofweek'] = df['date'].dt.dayofweek
df['quarter'] = df['date'].dt.quarter
df['is_weekend'] = df['dayofweek'].isin([5, 6]).astype(int)

# Time-based features
df['days_since'] = (pd.Timestamp.now() - df['date']).dt.days

# Interaction features
df['feature_interaction'] = df['feature1'] * df['feature2']

# Polynomial features
from sklearn.preprocessing import PolynomialFeatures
poly = PolynomialFeatures(degree=2, include_bias=False)
poly_features = poly.fit_transform(df[['feature1', 'feature2']])

# Binning continuous variables
df['age_bin'] = pd.cut(df['age'], bins=5, labels=['1', '2', '3', '4', '5'])
```

---

## Scikit-Learn Model Development

### Train-Test Split

```python
from sklearn.model_selection import train_test_split

# Basic split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Stratified split (maintains class distribution)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)
```

### Classification Models

```python
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier

# Logistic Regression
lr = LogisticRegression(random_state=42, max_iter=1000)
lr.fit(X_train, y_train)
y_pred = lr.predict(X_test)
y_proba = lr.predict_proba(X_test)  # Probabilities

# Random Forest
rf = RandomForestClassifier(n_estimators=100, random_state=42, n_jobs=-1)
rf.fit(X_train, y_train)
y_pred = rf.predict(X_test)

# Feature importance
importance_df = pd.DataFrame({
    'feature': X.columns,
    'importance': rf.feature_importances_
}).sort_values('importance', ascending=False)

# Gradient Boosting
gb = GradientBoostingClassifier(n_estimators=100, random_state=42)
gb.fit(X_train, y_train)
y_pred = gb.predict(X_test)
```

### Regression Models

```python
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor

# Linear Regression
lr = LinearRegression()
lr.fit(X_train, y_train)
y_pred = lr.predict(X_test)

# Ridge Regression (L2 regularization)
ridge = Ridge(alpha=1.0)
ridge.fit(X_train, y_train)
y_pred = ridge.predict(X_test)

# Lasso Regression (L1 regularization, feature selection)
lasso = Lasso(alpha=0.1)
lasso.fit(X_train, y_train)
y_pred = lasso.predict(X_test)

# Random Forest Regressor
rf = RandomForestRegressor(n_estimators=100, random_state=42, n_jobs=-1)
rf.fit(X_train, y_train)
y_pred = rf.predict(X_test)
```

### Cross-Validation

```python
from sklearn.model_selection import cross_val_score, cross_validate

# Simple cross-validation
scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
print(f"CV Scores: {scores}")
print(f"Mean: {scores.mean():.3f} (+/- {scores.std():.3f})")

# Multiple metrics
cv_results = cross_validate(
    model, X, y, cv=5,
    scoring=['accuracy', 'precision', 'recall', 'f1'],
    return_train_score=True
)
```

### Hyperparameter Tuning

```python
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV

# Grid Search (exhaustive)
param_grid = {
    'n_estimators': [50, 100, 200],
    'max_depth': [10, 20, 30, None],
    'min_samples_split': [2, 5, 10]
}

grid_search = GridSearchCV(
    RandomForestClassifier(random_state=42),
    param_grid,
    cv=5,
    scoring='accuracy',
    n_jobs=-1,
    verbose=1
)
grid_search.fit(X_train, y_train)

print("Best parameters:", grid_search.best_params_)
print("Best CV score:", grid_search.best_score_)
best_model = grid_search.best_estimator_

# Randomized Search (faster for large spaces)
from scipy.stats import randint

param_distributions = {
    'n_estimators': randint(50, 300),
    'max_depth': [10, 20, 30, None],
    'min_samples_split': randint(2, 20)
}

random_search = RandomizedSearchCV(
    RandomForestClassifier(random_state=42),
    param_distributions,
    n_iter=20,
    cv=5,
    random_state=42,
    n_jobs=-1
)
random_search.fit(X_train, y_train)
```

---

## Model Evaluation

### Classification Metrics

```python
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    confusion_matrix, classification_report, roc_auc_score, roc_curve
)
import matplotlib.pyplot as plt
import seaborn as sns

# Basic metrics
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred, average='weighted')
recall = recall_score(y_test, y_pred, average='weighted')
f1 = f1_score(y_test, y_pred, average='weighted')

print(f"Accuracy: {accuracy:.3f}")
print(f"Precision: {precision:.3f}")
print(f"Recall: {recall:.3f}")
print(f"F1 Score: {f1:.3f}")

# Confusion Matrix
cm = confusion_matrix(y_test, y_pred)
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
plt.title('Confusion Matrix')
plt.ylabel('True Label')
plt.xlabel('Predicted Label')
plt.show()

# Classification Report
print(classification_report(y_test, y_pred))

# ROC Curve (binary classification)
fpr, tpr, thresholds = roc_curve(y_test, y_proba[:, 1])
roc_auc = roc_auc_score(y_test, y_proba[:, 1])

plt.figure(figsize=(8, 6))
plt.plot(fpr, tpr, label=f'ROC Curve (AUC = {roc_auc:.2f})')
plt.plot([0, 1], [0, 1], 'k--', label='Random')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.legend()
plt.show()
```

### Regression Metrics

```python
from sklearn.metrics import (
    mean_squared_error, mean_absolute_error, r2_score, 
    mean_absolute_percentage_error
)

# Calculate metrics
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
mape = mean_absolute_percentage_error(y_test, y_pred)

print(f"MSE: {mse:.3f}")
print(f"RMSE: {rmse:.3f}")
print(f"MAE: {mae:.3f}")
print(f"R² Score: {r2:.3f}")
print(f"MAPE: {mape:.3%}")

# Residual plot
residuals = y_test - y_pred
plt.figure(figsize=(10, 6))
plt.scatter(y_pred, residuals, alpha=0.5)
plt.axhline(y=0, color='r', linestyle='--')
plt.xlabel('Predicted Values')
plt.ylabel('Residuals')
plt.title('Residual Plot')
plt.show()

# Prediction vs Actual
plt.figure(figsize=(10, 6))
plt.scatter(y_test, y_pred, alpha=0.5)
plt.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()], 'r--', lw=2)
plt.xlabel('Actual Values')
plt.ylabel('Predicted Values')
plt.title('Predictions vs Actual')
plt.show()
```

---

## PyTorch Deep Learning Patterns

### Basic Neural Network

```python
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader

# Define model
class NeuralNet(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(NeuralNet, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(hidden_size, hidden_size)
        self.fc3 = nn.Linear(hidden_size, output_size)
        self.dropout = nn.Dropout(0.2)
    
    def forward(self, x):
        x = self.fc1(x)
        x = self.relu(x)
        x = self.dropout(x)
        x = self.fc2(x)
        x = self.relu(x)
        x = self.fc3(x)
        return x

# Initialize model
model = NeuralNet(input_size=10, hidden_size=64, output_size=1)
criterion = nn.MSELoss()  # or nn.CrossEntropyLoss() for classification
optimizer = optim.Adam(model.parameters(), lr=0.001)

# Training loop
num_epochs = 100
for epoch in range(num_epochs):
    model.train()
    for batch_X, batch_y in train_loader:
        # Forward pass
        outputs = model(batch_X)
        loss = criterion(outputs, batch_y)
        
        # Backward pass and optimization
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
    
    # Validation
    if (epoch + 1) % 10 == 0:
        model.eval()
        with torch.no_grad():
            val_loss = criterion(model(X_val), y_val)
        print(f'Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}, Val Loss: {val_loss.item():.4f}')
```

---

## Jupyter Notebook Best Practices

### Notebook Structure

```python
# Cell 1: Imports and Setup
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split

# Set display options
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

# Random seed for reproducibility
np.random.seed(42)

# Cell 2: Load Data
df = pd.load_csv('data.csv')
print(f"Data shape: {df.shape}")
df.head()

# Cell 3: EDA
# One visualization or analysis per cell
# Add markdown cells to explain findings

# Cell 4: Data Cleaning
# Separate concerns - one transformation type per cell

# Cell 5: Feature Engineering
# Document feature creation logic

# Cell 6: Model Training
# Keep model training code together

# Cell 7: Evaluation
# Visualizations and metrics
```

### Markdown Documentation

```markdown
# Project Title

## Objective
Brief description of what this notebook does

## Data Description
- Source: Where the data comes from
- Size: Number of rows and columns
- Target: What we're predicting

## Key Findings
1. Finding 1
2. Finding 2

## Next Steps
- [ ] Task 1
- [ ] Task 2
```

### Code Quality in Notebooks

```python
# ✅ DO: Use meaningful variable names
user_churn_rate = df['churned'].mean()

# ❌ DON'T: Use cryptic names
x = df['churned'].mean()

# ✅ DO: Add comments for complex logic
# Calculate 7-day rolling average to smooth out daily fluctuations
df['rolling_avg'] = df['value'].rolling(window=7).mean()

# ✅ DO: Break complex operations into steps
df_filtered = df[df['age'] > 18]
df_grouped = df_filtered.groupby('city')['revenue'].sum()
top_cities = df_grouped.nlargest(10)

# ❌ DON'T: Chain too many operations
result = df[df['age'] > 18].groupby('city')['revenue'].sum().nlargest(10)
```

---

## Common Patterns and Anti-Patterns

### ✅ DO: Handle imbalanced data

```python
from sklearn.utils.class_weight import compute_class_weight
from imblearn.over_sampling import SMOTE

# Option 1: Class weights
class_weights = compute_class_weight('balanced', classes=np.unique(y_train), y=y_train)
model = LogisticRegression(class_weight='balanced')

# Option 2: SMOTE
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)
```

### ✅ DO: Create pipelines

```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

# Create pipeline
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('pca', PCA(n_components=10)),
    ('classifier', RandomForestClassifier(random_state=42))
])

# Fit and predict
pipeline.fit(X_train, y_train)
y_pred = pipeline.predict(X_test)

# Use in GridSearch
param_grid = {
    'pca__n_components': [5, 10, 15],
    'classifier__n_estimators': [50, 100, 200]
}
grid_search = GridSearchCV(pipeline, param_grid, cv=5)
```

### ❌ DON'T: Fit on test data

```python
# BAD - data leakage!
scaler.fit(pd.concat([X_train, X_test]))

# GOOD - fit only on training data
scaler.fit(X_train)
X_train_scaled = scaler.transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

---

## Model Persistence

```python
import joblib
import pickle

# Save with joblib (recommended for sklearn)
joblib.dump(model, 'model.pkl')
loaded_model = joblib.load('model.pkl')

# Save with pickle
with open('model.pkl', 'wb') as f:
    pickle.dump(model, f)

with open('model.pkl', 'rb') as f:
    loaded_model = pickle.load(f)

# Save PyTorch model
torch.save(model.state_dict(), 'model.pth')
model.load_state_dict(torch.load('model.pth'))
model.eval()
```

---

## Key Takeaways

1. **Always split data before any preprocessing** to avoid data leakage
2. **Use pipelines** for reproducible workflows
3. **Cross-validate** to get robust performance estimates
4. **Handle class imbalance** in classification problems
5. **Scale features** for distance-based algorithms
6. **Start simple** - try linear models before complex ones
7. **Document experiments** in notebooks with markdown
8. **Version control** your notebooks (strip outputs before committing)
9. **Monitor multiple metrics** - don't rely on accuracy alone
10. **Save models and scalers** together to ensure consistency
