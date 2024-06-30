# ``Numeric``

@Metadata {
    @DocumentationExtension(mergeBehavior: override)
}

A collection of numerical methods for root-finding, numerical integration,
and solving differential equations.

## Overview

### Newton-Raphson Method

The Newton-Raphson method is used for finding successively better approximations to the roots (or zeroes) of a real-valued function. In this example:

1. Function represents f(x)=x^2−2, and derivative represents f′(x)=2x.
2. NumericalMethods.newtonRaphson starts with an initial guess of x_0=1.0 and iteratively improves the estimate until the root is found or the maximum iterations are exceeded.

```swift
// Define the function and its derivative
let function: (Double) -> Double = { x in x * x - 2 }
let derivative: (Double) -> Double = { x in 2 * x }

// Find the root using Newton-Raphson method
if let root = NumericalMethods.newtonRaphson(function: function, derivative: derivative, initialGuess: 1.0) {
    print("Root: \(root)")  // Output: Root: 1.414213562373095
} else {
    print("Failed to find root within specified tolerance.")
}
```

### Simpson's Rule

Simpson's rule is a method for numerical integration. It approximates the integral of a function f(x) by approximating it as a quadratic polynomial within each interval and integrating this polynomial. In this example:

1. `integrand` represents f(x)=x^2.
2. `NumericalMethods.simpsonRule` computes the integral of f(x) from 0 to 1 using Simpson's rule with 100 intervals.

```swift
// Define the integrand function
let integrand: (Double) -> Double = { x in x * x }

// Calculate the integral using Simpson's rule
let integral = NumericalMethods.simpsonRule(function: integrand, lowerBound: 0.0, upperBound: 1.0, intervals: 100)

print("Integral: \(integral)")  // Output: Integral: 0.3333333333333333
```

### Euler Method (ODE Solver)

Euler's method is a first-order numerical procedure for solving ordinary differential equations (ODEs) with a given initial value. In this example:

1. Differential Equation: ode represents dy/dx=x+y.
2. ODE Solving: Math.Numeric.eulerMethod computes the solution to the ODE starting from y(0)=1.0 over the interval x∈[0.0,1.0] with a step size of 0.1.
3. Output: The solution points (x, y) are printed to show how y evolves as x changes.

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
