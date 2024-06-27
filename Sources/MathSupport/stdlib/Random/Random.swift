//
//  File.swift
//  
//
//  Created by Nevio Hirani on 27.06.24.
//

import Foundation

/// A class for generating random numbers.
///
/// This class provides a method to generate random numbers.
@available(iOS 18.0, *)
public class Random {
    
    /// Generates a random number within the specified range.
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the range (inclusive). Default is 0.
    ///   - upperBound: The upper bound of the range (inclusive). Default is 100.
    /// - Returns: A random integer within the specified range.
    public static func generateNumber(lowerBound: Int = 0, upperBound: Int = 100) -> Int {
        return Int.random(in: lowerBound...upperBound)
    }
}
