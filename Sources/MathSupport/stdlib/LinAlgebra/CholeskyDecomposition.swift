//
//  File.swift
//  
//
//  Created by Nevio Hirani on 29.06.24.
//

import Foundation
import Accelerate

/// Computes the Cholesky decomposition of a symmetric positive definite matrix.
///
/// The CholeskyDecomposition class computes the Cholesky decomposition of a symmetric positive definite matrix. This decomposition expresses the matrix as the product of a lower triangular matrix `L` and its transpose `L^T`, where `A=L*L^T`. This decomposition is useful in various numerical methods, including solving linear equations and calculating determinants.
///
///    ```swift
///    let matrix = [[25.0, 15.0, -5.0],
///    [15.0, 18.0,  0.0],
///    [-5.0,  0.0, 11.0]]
///
///    let choleskyDecomposition = CholeskyDecomposition(matrix: matrix)
///
///    print("Lower triangular matrix L:")
///
///    for row in choleskyDecomposition.L {
///       print(row)
///    }
///    ```
///
///    The Cholesky decomposition is computed using the following algorithm:
///
/// 1. Initialize `L` as a zero matrix of size `n×n`.
/// 2. Iterate through each row `i` and column `j`:
///     - Compute `sum = A[i][j]`.
///     - Subtract the inner products of elements of L for the current row and column: `sum -= L[i][k] * L[j][k]`, for `k = 0` to `j - 1`.
///     - If i == j, compute `L[i][j] = sqrt(max(sum, 0.0))`.
///     - If i != j, compute `L[i][j] = sum / L[j][j]`.
///
public class CholeskyDecomposition {
    
    /// The lower triangular matrix \( L \) such that \( A = L \cdot L^T \).
    public var L: [[Double]]
    private let n: Int
    
    /// Initializes the Cholesky decomposition for the given matrix.
    ///
    /// - Parameter matrix: The symmetric positive definite matrix to decompose.
    public init(matrix: [[Double]]) {
        self.n = matrix.count
        self.L = [[Double]](repeating: [Double](repeating: 0.0, count: n), count: n)
        
        for i in 0..<n {
            for j in 0..<i+1 {
                var sum = matrix[i][j]
                for k in 0..<j {
                    sum -= L[i][k] * L[j][k]
                }
                if i == j {
                    L[i][j] = sqrt(max(sum, 0.0))
                } else {
                    L[i][j] = sum / L[j][j]
                }
            }
        }
    }
}

