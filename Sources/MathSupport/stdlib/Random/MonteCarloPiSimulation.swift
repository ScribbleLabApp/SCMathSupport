//
//  MonteCarloPiSimulation.swift
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

public func monteCarloPiSimulation(iterations: Int) -> Double {
    let rng = MersenneTwister(seed: UInt32(time(nil)))
    var insideCircle = 0

    for _ in 0..<iterations {
        let x = Double(rng.nextUInt32()) / Double(UInt32.max)
        let y = Double(rng.nextUInt32()) / Double(UInt32.max)
        if x * x + y * y <= 1.0 {
            insideCircle += 1
        }
    }

    return 4.0 * Double(insideCircle) / Double(iterations)
}