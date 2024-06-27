// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// MathSupport.swift
// MathSupport Core
//
// Copyright (c) 2024 - ScribbleLabApp. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//

import Foundation

/// A collection of advanced mathematical functions.
public class Math {
    
    /// Computes the Gamma function for a given value using the Lanczos approximation for the Gamma function.
    ///
    /// - Parameter x: The input value.
    /// - Returns: The value of the Gamma function at `x`.
    public static func gamma(_ x: Double) -> Double {
        let g = 7
        let p: [Double] = [0.99999999999980993,
                           676.5203681218851,
                           -1259.1392167224028,
                           771.32342877765313,
                           -176.61502916214059,
                           12.507343278686905,
                           -0.13857109526572012,
                           9.9843695780195716e-6,
                           1.5056327351493116e-7]
        
        if x < 0.5 {
            return Double.pi / (sin(Double.pi * x) * gamma(1 - x))
        } else {
            var x = x - 1
            var a = p[0]
            let t = x + Double(g) + 0.5
            for i in 1..<p.count {
                a += p[i] / (x + Double(i))
            }
            return sqrt(2 * Double.pi) * pow(t, x + 0.5) * exp(-t) * a
        }
    }
    
    /// Computes the Beta function for given values.
    ///
    /// - Parameters:
    ///   - x: The first input value.
    ///   - y: The second input value.
    /// - Returns: The value of the Beta function at `x` and `y`.
    public static func beta(_ x: Double, _ y: Double) -> Double {
        return gamma(x) * gamma(y) / gamma(x + y)
    }
    
    /// Computes the error function for a given value.
    ///
    /// - Parameter x: The input value.
    /// - Returns: The value of the error function at `x`.
    public static func erf(_ x: Double) -> Double {
        // Using the approximation by Abramowitz and Stegun
        let a1 = 0.254829592
        let a2 = -0.284496736
        let a3 = 1.421413741
        let a4 = -1.453152027
        let a5 = 1.061405429
        let p = 0.3275911
        
        let sign = x < 0 ? -1 : 1
        let absX = abs(x)
        let t = 1.0 / (1.0 + p * absX)
        let y = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * exp(-absX * absX)
        
        return Double(sign) * y
    }
    
    /// Computes the Bessel function of the first kind for a given value.
    ///
    /// - Parameters:
    ///   - n: The order of the Bessel function.
    ///   - x: The input value.
    /// - Returns: The value of the Bessel function of the first kind at `x`.
    public static func besselJ(n: Int, x: Double) -> Double {
        // Using a series expansion for Bessel functions
        let m = 100
        let sumLimit = 1e-10
        var sum = 0.0
        
        for k in 0...m {
            let term = pow(-1.0, Double(k)) * pow(x / 2, Double(2 * k + n)) / (factorial(k) * factorial(k + n))
            if abs(term) < sumLimit { break }
            sum += term
        }
        
        return sum
    }
    
    /// Computes the Legendre polynomial of a given degree.
    ///
    /// - Parameters:
    ///   - n: The degree of the Legendre polynomial.
    ///   - x: The input value.
    /// - Returns: The value of the Legendre polynomial of degree `n` at `x`.
    public static func legendreP(n: Int, x: Double) -> Double {
        if n == 0 {
            return 1.0
        } else if n == 1 {
            return x
        } else {
            return ((2.0 * Double(n) - 1.0) * x * legendreP(n: n - 1, x: x) - (Double(n) - 1.0) * legendreP(n: n - 2, x: x)) / Double(n)
        }
    }
    
    /// Computes the factorial of a given non-negative integer.
    ///
    /// - Parameter n: The input integer.
    /// - Returns: The factorial of `n`.
    private static func factorial(_ n: Int) -> Double {
        return n == 0 ? 1.0 : Double(n) * factorial(n - 1)
    }
}
