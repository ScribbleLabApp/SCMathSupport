//
//  MersenneTwister.swift
//  MathSupport stdlib
//
//  Copyright (c) 2024 - ScribbleLabApp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import Foundation

public extension Random {
    /// A high-quality random number generator using the Mersenne Twister algorithm.
    ///
    /// The Mersenne Twister is a pseudorandom number generator (PRNG) known for its long period and high-quality randomness.
    /// This implementation supports seeding and generating random 32-bit unsigned integers.
    ///
    /// - Note: This class is available on iOS 18.0 and later.
    @available(iOS 18.0, *)
    class MersenneTwister {
        /// The size of the state vector.
        private static let n = 624
        
        /// The period parameter.
        private static let m = 397
        
        /// A constant vector a.
        private static let matrixA: UInt32 = 0x9908b0df
        
        /// Most significant w-r bits.
        private static let upperMask: UInt32 = 0x80000000
        
        /// Least significant r bits.
        private static let lowerMask: UInt32 = 0x7fffffff
        
        /// The state vector.
        private var mt = [UInt32](repeating: 0, count: n)
        
        /// The index for the state vector.
        private var index = n + 1
        
        /// Initializes a new instance of the Mersenne Twister with the given seed.
        ///
        /// - Parameter seed: The initial seed value to initialize the generator.
        public init(seed: UInt32) {
            self.seed(seed)
        }
        
        /// Seeds the Mersenne Twister with the given value.
        ///
        /// - Parameter seed: The seed value to initialize the generator.
        public func seed(_ seed: UInt32) {
            mt[0] = seed
            
            for i in 1..<MersenneTwister.n {
                mt[i] = 1812433253 &* (mt[i - 1] ^ (mt[i - 1] >> 30)) &+ UInt32(i)
            }
            
            index = MersenneTwister.n
        }
        
        /// Generates the next random 32-bit unsigned integer.
        ///
        /// - Returns: A pseudorandom 32-bit unsigned integer.
        public func nextUInt32() -> UInt32 {
            if index >= MersenneTwister.n {
                twist()
            }
            
            var y = mt[index]
            y ^= (y >> 11)
            y ^= (y << 7) & 0x9d2c5680
            y ^= (y << 15) & 0xefc60000
            y ^= (y >> 18)
            
            index += 1
            return y
        }
        
        /// Performs the twist transformation to generate new random values.
        ///
        /// This method is called automatically when more random numbers are needed.
        private func twist() {
            let n = MersenneTwister.n
            let m = MersenneTwister.m
            let matrixA = MersenneTwister.matrixA
            let upperMask = MersenneTwister.upperMask
            let lowerMask = MersenneTwister.lowerMask
            
            for i in 0..<n {
                let y = (mt[i] & upperMask) | (mt[(i + 1) % n] & lowerMask)
                mt[i] = mt[(i + m) % n] ^ (y >> 1)
                if y % 2 != 0 {
                    mt[i] ^= matrixA
                }
            }
            index = 0
        }
    }
}
