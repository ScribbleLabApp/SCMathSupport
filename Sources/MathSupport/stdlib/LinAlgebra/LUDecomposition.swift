//
//  File.swift
//  
//
//  Created by Nevio Hirani on 29.06.24.
//

import Foundation
import Accelerate

/// Computes the LU decomposition of a square matrix.
///
/// The LUDecomposition class computes the LU decomposition of a square matrix `A`. The LU decomposition factors the matrix into the product of a lower triangular matrix `L` and an upper triangular matrix `U`, such that `A = L * U`. This decomposition is useful in various numerical methods, including solving linear equations and calculating determinants.
///
///    ```swift
///    let matrix = [[3.0, 1.0, 2.0],
///                  [6.0, 3.0, 4.0],
///                  [3.0, 1.0, 5.0]]
///
///    let luDecomposition = LUDecomposition(matrix: matrix)
///
///    print("Lower triangular matrix L:")
///    for row in luDecomposition.L {
///        print(row)
///    }
///
///    print("Upper triangular matrix U:")
///    for row in luDecomposition.U {
///        print(row)
///    }
///    ```
///
/// The LU decomposition is computed using the following algorithm:
///
/// 1. Initialize matrices `L` and `U`:
///    - `L` is initialized as a diagonal matrix with ones on the diagonal.
///    - `U` is initialized as the input matrix A.
///
/// 2. Compute the decomposition:
///    - For each column `k` (from `0` to `n-1`):
///      - Update the column `k` of `L` and rows below `k` of `U`.
///      - Adjust elements of `U` using the calculated multipliers to form the upper triangular matrix.
///
/// The resulting lower triangular matrix L and upper triangular matrix U are stored in `L` and `U`, respectively.
///
/// - Parameters:
///   - matrix: The square matrix for which LU decomposition is computed.
///
/// - Complexity: `O(n^3)`, where n is the size of the matrix.
///
public class LUDecomposition {
    
    /// The lower triangular matrix L in the LU decomposition.
    public var L: [[Double]]
    
    /// The upper triangular matrix U in the LU decomposition.
    public var U: [[Double]]
    private let n: Int
    
    /// Initializes the LU decomposition for the given square matrix.
    ///
    /// - Parameter matrix: The square matrix for which LU decomposition is computed.
    public init(matrix: [[Double]]) {
        self.n = matrix.count
        self.L = [[Double]](repeating: [Double](repeating: 0.0, count: n), count: n)
        self.U = matrix
        
        for i in 0..<n {
            L[i][i] = 1.0
        }
        
        for k in 0..<n-1 {
            for i in k+1..<n {
                L[i][k] = U[i][k] / U[k][k]
                for j in k..<n {
                    U[i][j] -= L[i][k] * U[k][j]
                }
            }
        }
    }
}
