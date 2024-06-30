//
//  File.swift
//  
//
//  Created by Nevio Hirani on 30.06.24.
//

import Foundation
import Darwin

/// Structure representing a complex number.
public struct Complex {
    public var real: Double
    public var imaginary: Double
    
    /// Initializes a complex number.
    ///
    /// - Parameters:
    ///   - real: Real part.
    ///   - imaginary: Imaginary part.
    public init(real: Double, imaginary: Double) {
        self.real = real
        self.imaginary = imaginary
    }
    
    /// Computes the modulus (magnitude) of the complex number.
    ///
    /// - Returns: The modulus (magnitude).
    public func modulus() -> Double {
        return sqrt(real * real + imaginary * imaginary)
    }
    
    /// Computes the phase (argument) of the complex number.
    ///
    /// - Returns: The phase (argument) in radians.
    public func phase() -> Double {
        return atan2(imaginary, real)
    }
    
    /// Adds two complex numbers.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side complex number.
    ///   - rhs: Right-hand side complex number.
    /// - Returns: Result of addition.
    public static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
    }
    
    /// Subtracts two complex numbers.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side complex number.
    ///   - rhs: Right-hand side complex number.
    /// - Returns: Result of subtraction.
    public static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
    }
    
    /// Multiplies two complex numbers.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side complex number.
    ///   - rhs: Right-hand side complex number.
    /// - Returns: Result of multiplication.
    public static func *(lhs: Complex, rhs: Complex) -> Complex {
        let real = lhs.real * rhs.real - lhs.imaginary * rhs.imaginary
        let imaginary = lhs.real * rhs.imaginary + lhs.imaginary * rhs.real
        return Complex(real: real, imaginary: imaginary)
    }
    
    /// Divides two complex numbers.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side complex number.
    ///   - rhs: Right-hand side complex number (divisor).
    /// - Returns: Result of division.
    public static func /(lhs: Complex, rhs: Complex) -> Complex {
        let denominator = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
        let real = (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denominator
        let imaginary = (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denominator
        return Complex(real: real, imaginary: imaginary)
    }
    
    /// Computes the exponential of a complex number.
    ///
    /// - Returns: Exponential of the complex number.
    public func exp() -> Complex {
        let expReal = Darwin.exp(real) * Darwin.cos(imaginary)
        let expImaginary = Darwin.exp(real) * Darwin.sin(imaginary)
        return Complex(real: expReal, imaginary: expImaginary)
    }
    
    /// Computes the natural logarithm of a complex number.
    ///
    /// - Returns: Natural logarithm of the complex number.
    public func log() -> Complex {
        let modulus = self.modulus()
        let phase = self.phase()
        return Complex(real: Darwin.log(modulus), imaginary: phase)
    }
    
    /// Computes the sine of a complex number.
    ///
    /// - Returns: Sine of the complex number.
    public func sin() -> Complex {
        let sinReal = Darwin.sin(real) * cosh(imaginary)
        let sinImaginary = Darwin.cos(real) * sinh(imaginary)
        return Complex(real: sinReal, imaginary: sinImaginary)
    }
    
    /// Computes the cosine of a complex number.
    ///
    /// - Returns: Cosine of the complex number.
    public func cos() -> Complex {
        let cosReal = Darwin.cos(real) * cosh(imaginary)
        let cosImaginary = -Darwin.sin(real) * sinh(imaginary)
        return Complex(real: cosReal, imaginary: cosImaginary)
    }
    
    /// Computes the Fast Fourier Transform (FFT) of an array of complex numbers.
    ///
    /// - Parameter x: Array of complex numbers.
    /// - Returns: Array of complex numbers representing the FFT result.
    public func fft(_ x: [Complex]) -> [Complex] {
        let n = x.count
        
        // Base case for recursion
        if n <= 1 {
            return x
        }
        
        // Split even and odd elements
        let even = fft(x.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element })
        let odd = fft(x.enumerated().filter { $0.offset % 2 == 1 }.map { $0.element })
        
        // Combine the results
        var combined = [Complex](repeating: Complex(real: 0.0, imaginary: 0.0), count: n)
        for k in 0..<n/2 {
            let t = odd[k] * Complex(real: Darwin.cos(-2.0 * Double.pi * Double(k) / Double(n)), imaginary: Darwin.sin(-2.0 * Double.pi * Double(k) / Double(n)))
            combined[k] = even[k] + t
            combined[k + n/2] = even[k] - t
        }
        
        return combined
    }

}

