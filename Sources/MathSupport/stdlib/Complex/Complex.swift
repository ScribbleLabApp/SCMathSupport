//
//  File.swift
//  
//
//  Created by Nevio Hirani on 30.06.24.
//

import Foundation
import Darwin

import Foundation

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
        return Darwin.sqrt(real * real + imaginary * imaginary)
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
        let expReal = Foundation.exp(real) * Darwin.cos(imaginary)
        let expImaginary = Foundation.exp(real) * Darwin.sin(imaginary)
        return Complex(real: expReal, imaginary: expImaginary)
    }
    
    /// Computes the natural logarithm of a complex number.
    ///
    /// - Returns: Natural logarithm of the complex number.
    public func log() -> Complex {
        let modulus = self.modulus()
        let phase = self.phase()
        return Complex(real: Foundation.log(modulus), imaginary: phase)
    }
    
    /// Computes the sine of a complex number.
    ///
    /// - Returns: Sine of the complex number.
    public func sin() -> Complex {
        let sinReal = Foundation.sin(real) * cosh(imaginary)
        let sinImaginary = Foundation.cos(real) * sinh(imaginary)
        return Complex(real: sinReal, imaginary: sinImaginary)
    }
    
    /// Computes the cosine of a complex number.
    ///
    /// - Returns: Cosine of the complex number.
    public func cos() -> Complex {
        let cosReal = Foundation.cos(real) * cosh(imaginary)
        let cosImaginary = -Foundation.sin(real) * sinh(imaginary)
        return Complex(real: cosReal, imaginary: cosImaginary)
    }
    
    /// Computes the tangent of a complex number.
    ///
    /// - Returns: Tangent of the complex number.
    public func tan() -> Complex {
        let sinPart = self.sin()
        let cosPart = self.cos()
        return sinPart / cosPart
    }
    
    /// Computes the arc sine of a complex number.
    ///
    /// - Returns: Arc sine of the complex number.
    public func asin() -> Complex {
        let i = Complex(real: 0.0, imaginary: 1.0)
        let one = Complex(real: 1.0, imaginary: 0.0)
        let term1 = (i * self) + ((one - (self * self)).sqrt())
        return -i * (term1.log())
    }
    
    /// Computes the arc cosine of a complex number.
    ///
    /// - Returns: Arc cosine of the complex number.
    public func acos() -> Complex {
        let i = Complex(real: 0.0, imaginary: 1.0)
        let one = Complex(real: 1.0, imaginary: 0.0)
        let term1 = self + (i * ((one - (self * self)).sqrt()))
        return -i * (term1.log())
    }
    
    /// Computes the arc tangent of a complex number.
    ///
    /// - Returns: Arc tangent of the complex number.
    public func atan() -> Complex {
        let i = Complex(real: 0.0, imaginary: 1.0)
        let one = Complex(real: 1.0, imaginary: 0.0)
        let term1 = (i + self) / (i - self)
        return (i / 2.0) * term1.log()
    }
    
    /// Computes the square root of a complex number.
    ///
    /// - Returns: Square root of the complex number.
    public func sqrt() -> Complex {
        let modulus = self.modulus()
        let phase = self.phase() / 2.0
        let real = sqrt(modulus) * Darwin.cos(phase)
        let imaginary = sqrt(modulus) * Darwin.sin(phase)
        return Complex(real: real, imaginary: imaginary)
    }
}

/// Scalar multiplication
///
/// - Parameters:
///   - lhs: Left-hand side complex number.
///   - rhs: Scalar value.
/// - Returns: Result of scalar multiplication.
public func *(lhs: Complex, rhs: Double) -> Complex {
    return Complex(real: lhs.real * rhs, imaginary: lhs.imaginary * rhs)
}

/// Scalar division
///
/// - Parameters:
///   - lhs: Left-hand side complex number.
///   - rhs: Scalar value.
/// - Returns: Result of scalar division.
public func /(lhs: Complex, rhs: Double) -> Complex {
    return Complex(real: lhs.real / rhs, imaginary: lhs.imaginary / rhs)
}
