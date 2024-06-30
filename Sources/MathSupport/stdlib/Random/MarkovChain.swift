//
//  MarkovChain.swift
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
    
    /// A class representing a Markov Chain for simulating state transitions.
    ///
    /// This class can be used to simulate a series of state transitions based on a provided transition matrix.
    /// Each state transition is determined probabilistically, according to the transition matrix.
    ///
    /// @Beta
    /// - Note: This class is currently in beta and may change in future releases.
    @available(iOS 18.0, *)
    public class MarkovChain {
        private var transitionMatrix: [[Double]]
        private var states: [String]
        private var currentState: Int
        
        /// Initializes a new Markov Chain with the given transition matrix, initial state, and state names.
        ///
        /// - Parameters:
        ///   - transitionMatrix: A matrix where `transitionMatrix[i][j]` represents the probability of transitioning
        ///     from state `i` to state `j`.
        ///   - initialState: The index of the initial state.
        ///   - states: An array of state names corresponding to the indices in the transition matrix.
        public init(transitionMatrix: [[Double]], initialState: Int, states: [String]) {
            self.transitionMatrix = transitionMatrix
            self.currentState = initialState
            self.states = states
        }
        
        /// Advances the Markov Chain to the next state and returns the name of the new state.
        ///
        /// The next state is determined based on the transition probabilities from the current state.
        ///
        /// - Returns: The name of the new state.
        public func nextState() -> String {
            let rng = MersenneTwister(seed: UInt32(time(nil)))
            let randomValue = Double(rng.nextUInt32()) / Double(UInt32.max)
            var cumulativeProbability = 0.0
            
            for (index, probability) in transitionMatrix[currentState].enumerated() {
                cumulativeProbability += probability
                if randomValue < cumulativeProbability {
                    currentState = index
                    break
                }
            }
            
            return states[currentState]
        }
    }
}
