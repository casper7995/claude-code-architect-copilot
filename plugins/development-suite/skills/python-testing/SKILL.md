---
name: python-testing
description: Comprehensive Python testing patterns using pytest, including fixtures, parametrization, mocking, test organization, and best practices. Covers unit tests, integration tests, and test-driven development. Use when writing or reviewing Python tests.
---

# Python Testing with Pytest Guide

## Overview

This skill provides comprehensive patterns for testing Python applications using pytest, including fixtures, parametrization, mocking, and best practices for maintainable test suites.

---

## Basic Test Structure

### Simple Test Example

```python
# test_calculator.py
import pytest
from calculator import Calculator

def test_addition():
    calc = Calculator()
    result = calc.add(2, 3)
    assert result == 5

def test_subtraction():
    calc = Calculator()
    result = calc.subtract(5, 3)
    assert result == 2
```

### Test Organization

**Directory structure:**
```
project/
├── src/
│   ├── __init__.py
│   ├── calculator.py
│   └── models/
│       ├── __init__.py
│       └── user.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py          # Shared fixtures
│   ├── test_calculator.py
│   └── models/
│       ├── __init__.py
│       └── test_user.py
└── pytest.ini
```

**pytest.ini configuration:**
```ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts =
    -v
    --tb=short
    --strict-markers
    --cov=src
    --cov-report=html
    --cov-report=term-missing
markers =
    slow: marks tests as slow
    integration: marks tests as integration tests
    unit: marks tests as unit tests
```

---

## Pytest Fixtures

### Basic Fixtures

```python
# conftest.py
import pytest
from calculator import Calculator
from database import Database

@pytest.fixture
def calculator():
    """Provides a Calculator instance for tests."""
    return Calculator()

@pytest.fixture
def sample_data():
    """Provides sample test data."""
    return {
        'name': 'John Doe',
        'age': 30,
        'email': 'john@example.com'
    }
```

**Using fixtures:**
```python
def test_with_fixture(calculator):
    result = calculator.add(1, 2)
    assert result == 3

def test_with_data(sample_data):
    assert sample_data['name'] == 'John Doe'
```

### Fixture Scopes

```python
@pytest.fixture(scope="function")  # Default: new instance per test
def function_scope():
    return Database()

@pytest.fixture(scope="class")  # One instance per test class
def class_scope():
    return Database()

@pytest.fixture(scope="module")  # One instance per module
def module_scope():
    db = Database()
    yield db
    db.close()

@pytest.fixture(scope="session")  # One instance per test session
def session_scope():
    db = Database()
    yield db
    db.close()
```

### Fixture with Setup/Teardown

```python
@pytest.fixture
def database():
    """Database fixture with setup and teardown."""
    # Setup
    db = Database()
    db.connect()
    db.create_tables()

    yield db

    # Teardown
    db.drop_tables()
    db.disconnect()

def test_database_operation(database):
    database.insert_user("Alice", "alice@example.com")
    user = database.get_user("Alice")
    assert user.email == "alice@example.com"
```

---

## Parametrized Tests

### Basic Parametrization

```python
@pytest.mark.parametrize("a,b,expected", [
    (1, 2, 3),
    (5, 3, 8),
    (10, -5, 5),
    (0, 0, 0),
])
def test_addition_parametrized(calculator, a, b, expected):
    result = calculator.add(a, b)
    assert result == expected
```

### Multiple Parameters

```python
@pytest.mark.parametrize("operation,a,b,expected", [
    ("add", 2, 3, 5),
    ("subtract", 5, 3, 2),
    ("multiply", 4, 5, 20),
    ("divide", 10, 2, 5),
])
def test_operations(calculator, operation, a, b, expected):
    method = getattr(calculator, operation)
    result = method(a, b)
    assert result == expected
```

### Parametrize with IDs

```python
@pytest.mark.parametrize("input,expected", [
    ("hello", "HELLO"),
    ("World", "WORLD"),
    ("123", "123"),
], ids=["lowercase", "mixed_case", "numbers"])
def test_uppercase(input, expected):
    assert input.upper() == expected
```

---

## Mocking and Patching

### Using unittest.mock

```python
from unittest.mock import Mock, patch, MagicMock
import requests

def get_user_data(user_id):
    response = requests.get(f"https://api.example.com/users/{user_id}")
    return response.json()

def test_get_user_data():
    with patch('requests.get') as mock_get:
        # Setup mock response
        mock_response = Mock()
        mock_response.json.return_value = {'id': 1, 'name': 'Alice'}
        mock_get.return_value = mock_response

        # Call function
        result = get_user_data(1)

        # Assertions
        assert result['name'] == 'Alice'
        mock_get.assert_called_once_with("https://api.example.com/users/1")
```

### Pytest-Mock Plugin

```python
def test_with_mocker(mocker):
    # Mock a method
    mock_method = mocker.patch('module.ClassName.method_name')
    mock_method.return_value = 42

    # Use the mocked method
    result = some_function_that_calls_method()

    assert result == 42
    mock_method.assert_called_once()
```

### Mocking Class Instances

```python
def test_database_mock(mocker):
    # Mock the entire Database class
    mock_db = mocker.patch('module.Database')

    # Configure mock instance
    mock_instance = mock_db.return_value
    mock_instance.get_user.return_value = {'name': 'Alice'}

    # Use in test
    service = UserService()
    user = service.fetch_user(1)

    assert user['name'] == 'Alice'
    mock_instance.get_user.assert_called_once_with(1)
```

---

## Exception Testing

### Testing Exceptions

```python
def test_division_by_zero(calculator):
    with pytest.raises(ZeroDivisionError):
        calculator.divide(10, 0)

def test_exception_with_message(calculator):
    with pytest.raises(ValueError, match="negative values"):
        calculator.square_root(-1)

def test_exception_details():
    with pytest.raises(ValueError) as exc_info:
        raise ValueError("Custom error message")

    assert str(exc_info.value) == "Custom error message"
    assert exc_info.type == ValueError
```

---

## Markers and Custom Marks

### Built-in Markers

```python
@pytest.mark.skip(reason="Not implemented yet")
def test_future_feature():
    pass

@pytest.mark.skipif(sys.version_info < (3, 10), reason="Requires Python 3.10+")
def test_new_syntax():
    pass

@pytest.mark.xfail(reason="Known bug")
def test_known_issue():
    assert False
```

### Custom Markers

```python
# pytest.ini
[pytest]
markers =
    slow: marks tests as slow (deselect with '-m "not slow"')
    integration: marks tests as integration tests
    unit: marks tests as unit tests

# test file
@pytest.mark.slow
def test_complex_calculation():
    # Long running test
    pass

@pytest.mark.integration
def test_database_integration():
    # Integration test
    pass
```

**Run specific markers:**
```bash
# Run only unit tests
pytest -m unit

# Run all except slow tests
pytest -m "not slow"

# Run integration or slow tests
pytest -m "integration or slow"
```

---

## Testing Async Code

### Async Test Functions

```python
import pytest
import asyncio

@pytest.mark.asyncio
async def test_async_function():
    result = await some_async_function()
    assert result == expected_value

@pytest.mark.asyncio
async def test_async_with_fixture(async_client):
    response = await async_client.get('/api/users')
    assert response.status_code == 200
```

### Async Fixtures

```python
@pytest.fixture
async def async_database():
    db = await AsyncDatabase.create()
    yield db
    await db.close()

@pytest.mark.asyncio
async def test_with_async_fixture(async_database):
    user = await async_database.get_user(1)
    assert user.name == "Alice"
```

---

## Test Coverage

### Running Coverage

```bash
# Basic coverage
pytest --cov=src

# Coverage with HTML report
pytest --cov=src --cov-report=html

# Coverage with missing lines
pytest --cov=src --cov-report=term-missing

# Fail if coverage below threshold
pytest --cov=src --cov-fail-under=80
```

### Coverage Configuration

```ini
# .coveragerc or pyproject.toml
[coverage:run]
source = src
omit =
    */tests/*
    */test_*.py
    */__init__.py

[coverage:report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
    if __name__ == .__main__.:
```

---

## Best Practices

### 1. Test Naming Conventions

```python
# Good test names - describe what is being tested
def test_user_creation_with_valid_email():
    pass

def test_user_creation_raises_error_when_email_invalid():
    pass

def test_calculate_discount_returns_zero_for_non_members():
    pass

# Bad test names - not descriptive
def test_user():
    pass

def test_1():
    pass
```

### 2. Arrange-Act-Assert (AAA) Pattern

```python
def test_user_registration():
    # Arrange - Setup test data and dependencies
    user_data = {
        'email': 'test@example.com',
        'password': 'secure123'
    }
    service = UserService()

    # Act - Execute the function being tested
    result = service.register_user(user_data)

    # Assert - Verify the outcome
    assert result.success is True
    assert result.user.email == 'test@example.com'
```

### 3. One Assertion Per Test (When Possible)

```python
# Good - focused tests
def test_user_email_is_set():
    user = User('alice@example.com')
    assert user.email == 'alice@example.com'

def test_user_is_active_by_default():
    user = User('alice@example.com')
    assert user.is_active is True

# Acceptable - related assertions
def test_user_creation():
    user = User('alice@example.com')
    assert user.email == 'alice@example.com'
    assert user.is_active is True
    assert user.created_at is not None
```

### 4. Use Fixtures for Common Setup

```python
# Bad - repetitive setup
def test_user_can_post():
    db = Database()
    user = User('alice@example.com')
    db.save(user)
    # ... test code

def test_user_can_comment():
    db = Database()
    user = User('alice@example.com')
    db.save(user)
    # ... test code

# Good - fixture reduces repetition
@pytest.fixture
def user_with_db():
    db = Database()
    user = User('alice@example.com')
    db.save(user)
    return user, db

def test_user_can_post(user_with_db):
    user, db = user_with_db
    # ... test code

def test_user_can_comment(user_with_db):
    user, db = user_with_db
    # ... test code
```

### 5. Test Edge Cases

```python
@pytest.mark.parametrize("input_value,expected", [
    (10, 10),           # Normal case
    (0, 0),             # Zero
    (-5, 5),            # Negative
    (999999, 999999),   # Large number
])
def test_absolute_value(input_value, expected):
    assert abs(input_value) == expected
```

---

## Common Patterns

### Testing Database Operations

```python
@pytest.fixture
def db_session():
    engine = create_engine('sqlite:///:memory:')
    Base.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    session = Session()

    yield session

    session.close()

def test_create_user(db_session):
    user = User(name='Alice', email='alice@example.com')
    db_session.add(user)
    db_session.commit()

    retrieved_user = db_session.query(User).filter_by(name='Alice').first()
    assert retrieved_user.email == 'alice@example.com'
```

### Testing API Endpoints

```python
@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_users(client):
    response = client.get('/api/users')
    assert response.status_code == 200
    assert len(response.json) > 0

def test_create_user(client):
    data = {'name': 'Alice', 'email': 'alice@example.com'}
    response = client.post('/api/users', json=data)
    assert response.status_code == 201
    assert response.json['name'] == 'Alice'
```

---

## Quick Reference Commands

```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_calculator.py

# Run specific test function
pytest tests/test_calculator.py::test_addition

# Run tests matching pattern
pytest -k "addition or subtraction"

# Run with verbose output
pytest -v

# Run with markers
pytest -m slow
pytest -m "not slow"

# Run with coverage
pytest --cov=src --cov-report=html

# Run and stop on first failure
pytest -x

# Run and show local variables on failure
pytest -l

# Run last failed tests
pytest --lf

# Run failed tests first, then all
pytest --ff
```

---

## Resources

- **pytest documentation**: https://docs.pytest.org/
- **pytest-mock**: https://pytest-mock.readthedocs.io/
- **pytest-asyncio**: https://pytest-asyncio.readthedocs.io/
- **pytest-cov**: https://pytest-cov.readthedocs.io/
