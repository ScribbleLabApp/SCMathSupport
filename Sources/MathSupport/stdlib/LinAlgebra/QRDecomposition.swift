//
//  File.swift
//  
//
//  Created by Nevio Hirani on 29.06.24.
//

import Foundation
import Accelerate

/// Computes the QR decomposition of a matrix.
///
/// The QRDecomposition class computes the QR decomposition of a matrix `A`. The QR decomposition factors the matrix into the product of an orthogonal matrix `Q` and an upper triangular matrix `R`, such that `A = Q * R`. This decomposition is useful in various numerical methods, including solving linear least squares problems and eigenvalue computations.
///
///    ```swift
///    let matrix = [[1.0, -1.0, 4.0],
///                  [3.0, 2.0, 5.0],
///                  [2.0, -3.0, 1.0]]
///
///    let qrDecomposition = QRDecomposition(matrix: matrix)
///
///    print("Orthogonal matrix Q:")
///    for row in qrDecomposition.Q {
///        print(row)
///    }
///
///    print("Upper triangular matrix R:")
///    for row in qrDecomposition.R {
///        print(row)
///    }
///    ```
///
/// The QR decomposition is computed using the Gram-Schmidt process modified to construct an orthogonal matrix Q and an upper triangular matrix R.
///
/// - Parameters:
///   - matrix: The matrix for which QR decomposition is computed.
///
public class QRDecomposition {
    
    /// The orthogonal matrix Q in the QR decomposition.
    public var Q: [[Double]]
    
    /// The upper triangular matrix R in the QR decomposition.
    public var R: [[Double]]
    private let m: Int
    private let n: Int
    
    /// Initializes the QR decomposition for the given matrix.
    ///
    /// - Parameter matrix: The matrix for which QR decomposition is computed.
    public init(matrix: [[Double]]) {
        self.m = matrix.count
        self.n = matrix[0].count
        self.Q = matrix
        self.R = [[Double]](repeating: [Double](repeating: 0.0, count: n), count: n)
        
        for k in 0..<n {
            var norm = 0.0
            for i in 0..<m {
                norm += Q[i][k] * Q[i][k]
            }
            norm = sqrt(norm)
            
            R[k][k] = norm
            for i in 0..<m {
                Q[i][k] /= norm
            }
            
            for j in k+1..<n {
                R[k][j] = 0.0
                for i in 0..<m {
                    R[k][j] += Q[i][k] * matrix[i][j]
                }
                for i in 0..<m {
                    Q[i][j] -= R[k][j] * Q[i][k]
                }
            }
        }
    }
}

