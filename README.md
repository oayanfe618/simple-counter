# Simple Counter - Extended Clarity Contract

## Overview

A comprehensive counter smart contract built with Clarity for the Stacks blockchain. This contract provides basic arithmetic operations, validation, and utility functions with robust error handling.

## Features

### Basic Operations
- **increment()** - Increase counter by 1
- **increment-by(amount)** - Increase counter by specified amount
- **decrement()** - Decrease counter by 1 (with underflow protection)
- **decrement-by(amount)** - Decrease counter by specified amount
- **reset(new-value)** - Set counter to a new value
- **clear()** - Reset counter to 0

### Advanced Operations
- **set-if-greater(new-value)** - Only update counter if new value is larger
- **multiply-by(factor)** - Multiply counter by a positive integer
- **divide-by(divisor)** - Divide counter by a divisor (safe division with zero check)
- **set-max(max-value)** - Enforce maximum counter limit

### Read-Only Functions
- **get-counter()** - Retrieve current counter value
- **get-double()** - Get counter value multiplied by 2
- **get-square()** - Get counter value squared
- **is-even()** - Check if counter is even
- **is-odd()** - Check if counter is odd

## Error Handling

The contract defines three error constants for robust validation:

| Error | Code | Description |
|-------|------|-------------|
| `ERR_UNDERFLOW` | u100 | Operation would result in negative value |
| `ERR_NEGATIVE` | u200 | Input parameter is negative |
| `ERR_TOO_LARGE` | u300 | Counter exceeds maximum allowed value |

## Usage

All public functions return a Result type:
- **Ok(value)** - Operation succeeded, returns the new counter value or true
- **Err(code)** - Operation failed with specified error code

### Example Calls

```clarity
;; Increment counter
(increment)  ;; Returns (ok 1)

;; Add 10 to counter
(increment-by u10)  ;; Returns (ok 11)

;; Get current value
(get-counter)  ;; Returns (ok 11)

;; Set to new value if larger
(set-if-greater 15)  ;; Returns (ok 15)

;; Check if even
(is-even)  ;; Returns (ok false)
```

## Data Structure

- **counter** - Integer variable storing the current counter value (initialized to 0)

## Testing

Unit tests are available in simple-counter.test.ts for comprehensive validation of all contract functions.

## Requirements


## License

This project is part of the STACKS learning repository.
