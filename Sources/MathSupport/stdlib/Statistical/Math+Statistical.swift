// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Math+Statistical.swift
// MathSupport stdlib
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

@available(iOS 18.0, *)
public extension Math {
    
    /// A collection of statistical functions for performing descriptive statistics,
    /// working with probability distributions, and conducting hypothesis tests.
    @available(iOS 18.0, *)
    class Statistical {
        
        static let shared = Statistical()
        
        // MARK: - Descriptive Statistics
        
        /// Computes the mean (average) of a given array of numbers.
        ///
        /// The mean is calculated as the sum of all elements divided by the number
        /// of elements in the array.
        ///
        ///    ```swift
        ///     let data = [1.0, 2.0, 3.0, 4.0, 5.0]
        ///     let meanValue = Math.Statistical.mean(data)
        ///     print(meanValue)  // Output: 3.0
        ///    ```
        ///
        /// - Parameter data: An array of `Double` values.
        /// - Returns: The mean of the input data. Returns `0.0` if the array is empty.
        ///
        public static func mean(_ data: [Double]) -> Double {
            guard !data.isEmpty else { return 0.0 }
            return data.reduce(0, +) / Double(data.count)
        }
        
        /// Computes the median of a given array of numbers.
        ///
        /// The median is the value separating the higher half from the lower half
        /// of a data sample. If the array has an even number of elements, the median
        /// is the average of the two middle numbers.
        ///
        ///    ```swift
        ///     let data = [1.0, 3.0, 4.0, 2.0, 5.0]
        ///     let medianValue = Math.Statistical.median(data)
        ///     print(medianValue)  // Output: 3.0
        ///    ```
        ///
        /// - Parameter data: An array of `Double` values.
        /// - Returns: The median of the input data. Returns `0.0` if the array is empty.
        ///
        public static func median(_ data: [Double]) -> Double {
            guard !data.isEmpty else { return 0.0 }
            let sortedData = data.sorted()
            let midIndex = sortedData.count / 2
            
            if sortedData.count % 2 == 0 {
                return (sortedData[midIndex - 1] + sortedData[midIndex]) / 2.0
            } else {
                return sortedData[midIndex]
            }
        }
        
        /// Computes the mode of a given array of numbers.
        ///
        /// The mode is the value that appears most frequently in the dataset. If there
        /// are multiple modes, this function returns the first one found.
        ///
        ///    ```swift
        ///     let data = [1.0, 2.0, 2.0, 3.0, 4.0]
        ///     let modeValue = Math.Statistical.mode(data)
        ///     print(modeValue)  // Output: 2.0
        ///    ```
        ///
        /// - Parameter data: An array of `Double` values.
        /// - Returns: The mode of the input data, or `nil` if the array is empty.
        ///
        public static func mode(_ data: [Double]) -> Double? {
            guard !data.isEmpty else { return nil }
            var frequency: [Double: Int] = [:]
            
            for value in data {
                frequency[value, default: 0] += 1
            }
            
            let maxFrequency = frequency.values.max()
            let modes = frequency.filter { $0.value == maxFrequency }.keys
            
            return modes.first
        }
        
        /// Computes the variance of a given array of numbers.
        ///
        /// Variance measures how far a set of numbers are spread out from their
        /// average value. It is calculated as the average of the squared differences
        /// from the mean.
        ///
        ///    ```swift
        ///     let data = [1.0, 2.0, 3.0, 4.0, 5.0]
        ///     let varianceValue = Math.Statistical.variance(data)
        ///     print(varianceValue)  // Output: 2.0
        ///    ```
        ///
        /// - Parameter data: An array of `Double` values.
        /// - Returns: The variance of the input data. Returns `0.0` if the array is empty.
        ///
        public static func variance(_ data: [Double]) -> Double {
            guard !data.isEmpty else { return 0.0 }
            let meanValue = mean(data)
            let squaredDifferences = data.map { pow($0 - meanValue, 2) }
            return squaredDifferences.reduce(0, +) / Double(data.count)
        }
        
        /// Computes the standard deviation of a given array of numbers.
        ///
        /// Standard deviation is a measure of the amount of variation or dispersion
        /// of a set of values. It is the square root of the variance.
        ///
        /// - Parameter data: An array of `Double` values.
        /// - Returns: The standard deviation of the input data. Returns `0.0` if the array is empty.
        ///
        /// - Example:
        ///   ```swift
        ///   let data = [1.0, 2.0, 3.0, 4.0, 5.0]
        ///   let stdDevValue = Math.Statistical.standardDeviation(data)
        ///   print(stdDevValue)  // Output: 1.4142135623730951
        ///   ```
        public static func standardDeviation(_ data: [Double]) -> Double {
            return sqrt(variance(data))
        }
        
        // MARK: - Probability Distributions
        
        /// Computes the probability density function (PDF) of the normal distribution.
        ///
        /// The normal distribution, also known as the Gaussian distribution, is a
        /// continuous probability distribution characterized by a bell-shaped curve.
        ///
        /// - Parameters:
        ///   - x: The value at which to evaluate the PDF.
        ///   - mean: The mean (average) of the distribution. Default is `0.0`.
        ///   - stdDev: The standard deviation of the distribution. Default is `1.0`.
        /// - Returns: The value of the PDF at `x`.
        ///
        /// - Example:
        ///   ```swift
        ///   let pdfValue = Math.Statistical.normalPDF(x: 0.0)
        ///   print(pdfValue)  // Output: 0.3989422804014327
        ///   ```
        public static func normalPDF(x: Double, mean: Double = 0.0, stdDev: Double = 1.0) -> Double {
            let exponent = -pow(x - mean, 2) / (2 * pow(stdDev, 2))
            return (1 / (stdDev * sqrt(2 * Double.pi))) * exp(exponent)
        }
        
        /// Computes the cumulative distribution function (CDF) of the normal distribution.
        ///
        /// The CDF of the normal distribution describes the probability that a
        /// normally distributed random variable is less than or equal to a given value.
        ///
        /// - Parameters:
        ///   - x: The value at which to evaluate the CDF.
        ///   - mean: The mean (average) of the distribution. Default is `0.0`.
        ///   - stdDev: The standard deviation of the distribution. Default is `1.0`.
        /// - Returns: The value of the CDF at `x`.
        ///
        /// - Example:
        ///   ```swift
        ///   let cdfValue = StatisticalFunctions.normalCDF(x: 0.0)
        ///   print(cdfValue)  // Output: 0.5
        ///   ```
        public static func normalCDF(x: Double, mean: Double = 0.0, stdDev: Double = 1.0) -> Double {
            return 0.5 * (1 + erf((x - mean) / (stdDev * sqrt(2))))
        }
        
        /// Computes the probability mass function (PMF) of the binomial distribution.
        ///
        /// The binomial distribution describes the number of successes in a fixed
        /// number of independent Bernoulli trials with the same probability of success.
        ///
        /// - Parameters:
        ///   - k: The number of successes.
        ///   - n: The number of trials.
        ///   - p: The probability of success on each trial.
        /// - Returns: The probability of `k` successes in `n` trials.
        ///
        /// - Example:
        ///   ```swift
        ///   let pmfValue = Math.Statistical.binomialPMF(k: 2, n: 5, p: 0.5)
        ///   print(pmfValue)  // Output: 0.3125
        ///   ```
        public static func binomialPMF(k: Int, n: Int, p: Double) -> Double {
            let combinations = factorial(n) / (factorial(k) * factorial(n - k))
            return combinations * pow(p, Double(k)) * pow(1 - p, Double(n - k))
        }
        
        /// Computes the probability mass function (PMF) of the Poisson distribution.
        ///
        /// The Poisson distribution describes the number of events occurring within
        /// a fixed interval of time or space, given the average number of times the
        /// event occurs over that interval.
        ///
        /// - Parameters:
        ///   - k: The number of events.
        ///   - lambda: The average number of events in the interval.
        /// - Returns: The probability of `k` events occurring in the interval.
        ///
        /// - Example:
        ///   ```swift
        ///   let pmfValue = Math.Statistical.poissonPMF(k: 2, lambda: 3.0)
        ///   print(pmfValue)  // Output: 0.22404180765538775
        ///   ```
        public static func poissonPMF(k: Int, lambda: Double) -> Double {
            return pow(lambda, Double(k)) * exp(-lambda) / factorial(k)
        }
        
        // MARK: - Hypothesis Testing
        
        /// Performs a one-sample t-test to determine if the mean of the sample data
        /// is significantly different from a known value.
        ///
        /// A one-sample t-test compares the mean of the sample data to a known value,
        /// typically the population mean, to determine if they are significantly different.
        ///
        /// - Parameters:
        ///   - sample: An array of `Double` values representing the sample data.
        ///   - populationMean: The known value to compare the sample mean against.
        /// - Returns: A tuple containing the t-statistic and the p-value.
        ///
        /// - Example:
        ///   ```swift
        ///   let data = [2.5, 3.0, 3.5, 4.0, 4.5]
        ///   let tTestResult = Math.Statistical.tTest(sample: data, populationMean: 3.5)
        ///   print(tTestResult.tStatistic)  // Output: -2.3452078799117145
        ///   print(tTestResult.pValue)      // Output: 0.07872985323156802
        ///   ```
        public static func tTest(sample: [Double], populationMean: Double) -> (tStatistic: Double, pValue: Double) {
            let sampleMean = mean(sample)
            let sampleStdDev = standardDeviation(sample)
            let sampleSize = Double(sample.count)
            let tStatistic = (sampleMean - populationMean) / (sampleStdDev / sqrt(sampleSize))
            
            let degreesOfFreedom = sampleSize - 1
            let pValue = 2 * (1 - tDistributionCDF(t: abs(tStatistic), df: degreesOfFreedom))
            
            return (tStatistic, pValue)
        }
        
        /// Computes the cumulative distribution function (CDF) of the t-distribution.
        ///
        /// The CDF of the t-distribution describes the probability that a t-distributed
        /// random variable is less than or equal to a given value.
        ///
        /// - Parameters:
        ///   - t: The value at which to evaluate the CDF.
        ///   - df: The degrees of freedom of the distribution.
        /// - Returns: The value of the CDF at `t`.
        private static func tDistributionCDF(t: Double, df: Double) -> Double {
            let x = df / (t * t + df)
            return 0.5 * (1 + incompleteBeta(x: x, a: df / 2, b: 0.5))
        }
        
        /// Computes the incomplete beta function.
        ///
        /// The incomplete beta function is a special function related to the beta function,
        /// which is useful in statistical applications.
        ///
        /// - Parameters:
        ///   - x: The value at which to evaluate the function.
        ///   - a: The first parameter of the function.
        ///   - b: The second parameter of the function.
        /// - Returns: The value of the incomplete beta function at `(x, a, b)`.
        private static func incompleteBeta(x: Double, a: Double, b: Double) -> Double {
            let bt = exp(gammaLog(a + b) - gammaLog(a) - gammaLog(b) + a * log(x) + b * log(1 - x))
            if x == 0 || x == 1 {
                return x
            }
            
            let threshold = a + 1 / (3 * a) * log(b / a)
            if x < threshold {
                return bt * betaCF(x: x, a: a, b: b) / a
            } else {
                return 1 - bt * betaCF(x: 1 - x, a: b, b: a) / b
            }
        }
        
        /// Computes the continued fraction for the incomplete beta function.
        ///
        /// The continued fraction representation is used for evaluating the incomplete
        /// beta function.
        ///
        /// - Parameters:
        ///   - x: The value at which to evaluate the function.
        ///   - a: The first parameter of the function.
        ///   - b: The second parameter of the function.
        /// - Returns: The value of the continued fraction at `(x, a, b)`.
        private static func betaCF(x: Double, a: Double, b: Double) -> Double {
            let maxIterations = 100
            let epsilon = 3.0e-7
            
            var aa: Double
            var c = 1.0
            var d = 1.0 - (a + b) * x / (a + 1)
            d = d < epsilon ? 1 / epsilon : 1 / d
            var h = d
            
            for m in 1..<maxIterations {
                let m2 = 2 * m
                
                let numerator1 = Double(m) * (b - Double(m)) * x
                let denominator1 = (a - 1 + Double(m2)) * (a + Double(m2))
                aa = numerator1 / denominator1
                
                d = 1 + aa * d
                d = d < epsilon ? 1 / epsilon : 1 / d
                c = 1 + aa / c
                c = c < epsilon ? 1 / epsilon : c
                h *= d * c
                
                let numerator2 = -(a + Double(m)) * (a + b + Double(m)) * x
                let denominator2 = (a + Double(m2)) * (a + 1 + Double(m2))
                aa = numerator2 / denominator2
                
                d = 1 + aa * d
                d = d < epsilon ? 1 / epsilon : 1 / d
                c = 1 + aa / c
                c = c < epsilon ? 1 / epsilon : c
                h *= d * c
                
                if abs(d * c - 1) < epsilon {
                    break
                }
            }
            
            return h
        }
    }
    
    /// Computes the natural logarithm of the gamma function.
    ///
    /// The gamma function is a generalization of the factorial function to real
    /// and complex numbers.
    ///
    /// - Parameter x: The input value.
    /// - Returns: The natural logarithm of the gamma function at `x`.
    private static func gammaLog(_ x: Double) -> Double {
        let coefficients: [Double] = [
            76.18009172947146,
            -86.50532032941677,
            24.01409824083091,
            -1.231739572450155,
            0.001208650973866179,
            -0.000005395239384953
        ]
        
        var y = x
        var tmp = x + 5.5
        tmp -= (x + 0.5) * log(tmp)
        var ser = 1.000000000190015
        
        for j in 0..<coefficients.count {
            y += 1
            ser += coefficients[j] / y
        }
        
        return -tmp + log(2.5066282746310005 * ser / x)
    }
    
    /// Computes the factorial of a given non-negative integer.
    ///
    /// The factorial of a non-negative integer `n` is the product of all positive
    /// integers less than or equal to `n`.
    ///
    /// - Parameter n: The input integer.
    /// - Returns: The factorial of `n`.
    private static func factorial(_ n: Int) -> Double {
        return n == 0 ? 1.0 : Double(n) * factorial(n - 1)
    }
}
