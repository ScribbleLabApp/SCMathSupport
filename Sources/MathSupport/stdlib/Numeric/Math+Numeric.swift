//
//  File.swift
//  
//
//  Created by Nevio Hirani on 29.06.24.
//

import Foundation

@available(iOS 18.0, *)
public extension Math {
    
    /// A collection of numerical methods for root-finding, numerical integration,
    /// and solving differential equations.
    @available(iOS 18.0, *)
    class Numeric {
        
        static let shared = Numeric()
        
        /// Uses the Newton-Raphson method to find the root of a function.
        ///
        /// - Parameters:
        ///   - function: The function for which the root is sought.
        ///   - derivative: The derivative of the function.
        ///   - initialGuess: An initial guess for the root.
        ///   - tolerance: The tolerance for convergence.
        ///   - maxIterations: The maximum number of iterations.
        /// - Returns: The estimated root of the function.
        public static func newtonRaphson(function: @escaping (Double) -> Double, derivative: @escaping (Double) -> Double, initialGuess: Double, tolerance: Double = 1e-7, maxIterations: Int = 1000) -> Double? {
            var x = initialGuess
            for _ in 0..<maxIterations {
                let fx = function(x)
                let fpx = derivative(x)
                if abs(fpx) < tolerance { return nil }
                let x1 = x - fx / fpx
                if abs(x1 - x) < tolerance { return x1 }
                x = x1
            }
            return nil
        }
        
        /// Uses the bisection method to find the root of a function.
        ///
        /// - Parameters:
        ///   - function: The function for which the root is sought.
        ///   - lowerBound: The lower bound of the interval.
        ///   - upperBound: The upper bound of the interval.
        ///   - tolerance: The tolerance for convergence.
        ///   - maxIterations: The maximum number of iterations.
        /// - Returns: The estimated root of the function.
        public static func bisection(function: @escaping (Double) -> Double, lowerBound: Double, upperBound: Double, tolerance: Double = 1e-7, maxIterations: Int = 1000) -> Double? {
            var a = lowerBound
            var b = upperBound
            var mid = (a + b) / 2.0
            
            for _ in 0..<maxIterations {
                mid = (a + b) / 2.0
                let fmid = function(mid)
                
                if abs(fmid) < tolerance { return mid }
                
                if function(a) * fmid < 0 {
                    b = mid
                } else {
                    a = mid
                }
                
                if abs(b - a) < tolerance { return mid }
            }
            return mid
        }
        
        // MARK: - Numerical Integration
        
        /// Uses Simpson's rule to estimate the integral of a function.
        ///
        /// - Parameters:
        ///   - function: The function to be integrated.
        ///   - lowerBound: The lower bound of the integration interval.
        ///   - upperBound: The upper bound of the integration interval.
        ///   - intervals: The number of intervals to use.
        /// - Returns: The estimated integral of the function.
        public static func simpsonRule(function: @escaping (Double) -> Double, lowerBound: Double, upperBound: Double, intervals: Int) -> Double {
            let h = (upperBound - lowerBound) / Double(intervals)
            var sum = function(lowerBound) + function(upperBound)
            
            for i in 1..<intervals {
                let x = lowerBound + Double(i) * h
                sum += (i % 2 == 0 ? 2 : 4) * function(x)
            }
            
            return sum * h / 3.0
        }
        
        /// Uses the trapezoidal rule to estimate the integral of a function.
        ///
        /// - Parameters:
        ///   - function: The function to be integrated.
        ///   - lowerBound: The lower bound of the integration interval.
        ///   - upperBound: The upper bound of the integration interval.
        ///   - intervals: The number of intervals to use.
        /// - Returns: The estimated integral of the function.
        public static func trapezoidalRule(function: @escaping (Double) -> Double, lowerBound: Double, upperBound: Double, intervals: Int) -> Double {
            let h = (upperBound - lowerBound) / Double(intervals)
            var sum = (function(lowerBound) + function(upperBound)) / 2.0
            
            for i in 1..<intervals {
                let x = lowerBound + Double(i) * h
                sum += function(x)
            }
            
            return sum * h
        }
        
        // MARK: - Differential Equation Solvers
        
        /// Solves an ordinary differential equation (ODE) using the Euler method.
        ///
        /// - Parameters:
        ///   - function: The function defining the differential equation.
        ///   - initialCondition: The initial condition of the differential equation.
        ///   - lowerBound: The lower bound of the interval.
        ///   - upperBound: The upper bound of the interval.
        ///   - stepSize: The step size to use in the Euler method.
        /// - Returns: An array of tuples representing the solution points.
        public static func eulerMethod(function: @escaping (Double, Double) -> Double, initialCondition: Double, lowerBound: Double, upperBound: Double, stepSize: Double) -> [(Double, Double)] {
            var x = lowerBound
            var y = initialCondition
            var result: [(Double, Double)] = [(x, y)]
            
            while x < upperBound {
                y += stepSize * function(x, y)
                x += stepSize
                result.append((x, y))
            }
            
            return result
        }
        
        /// Solves an ordinary differential equation (ODE) using the Runge-Kutta method.
        ///
        /// - Parameters:
        ///   - function: The function defining the differential equation.
        ///   - initialCondition: The initial condition of the differential equation.
        ///   - lowerBound: The lower bound of the interval.
        ///   - upperBound: The upper bound of the interval.
        ///   - stepSize: The step size to use in the Runge-Kutta method.
        /// - Returns: An array of tuples representing the solution points.
        public static func rungeKuttaMethod(function: @escaping (Double, Double) -> Double, initialCondition: Double, lowerBound: Double, upperBound: Double, stepSize: Double) -> [(Double, Double)] {
            var x = lowerBound
            var y = initialCondition
            var result: [(Double, Double)] = [(x, y)]
            
            while x < upperBound {
                let k1 = stepSize * function(x, y)
                let k2 = stepSize * function(x + 0.5 * stepSize, y + 0.5 * k1)
                let k3 = stepSize * function(x + 0.5 * stepSize, y + 0.5 * k2)
                let k4 = stepSize * function(x + stepSize, y + k3)
                y += (k1 + 2 * k2 + 2 * k3 + k4) / 6.0
                x += stepSize
                result.append((x, y))
            }
            
            return result
        }
    }
}
