//
//  File.swift
//  
//
//  Created by Nevio Hirani on 29.06.24.
//

import Foundation
import Accelerate

/// Computes the Singular Value Decomposition (SVD) of a matrix.
///
/// The SingularValueDecomposition class computes the SVD of an `m x n` matrix `A`. The SVD decomposes the matrix `A` into the product of three matrices: `U`, `Σ`, and `V^T`, such that `A = U * Σ * V^T`. Here, `U` and `V` are orthogonal matrices, and `Σ` is a diagonal matrix with non-negative real numbers on the diagonal, known as the singular values.
///
///    ```swift
///    let matrix = [[1.0, 0.0, 0.0],
///                  [0.0, 0.0, 1.0],
///                  [0.0, 1.0, 0.0]]
///
///    let svd = SingularValueDecomposition(matrix: matrix)
///
///    print("Left singular vectors (U):")
///    for row in svd.U {
///        print(row)
///    }
///
///    print("Singular values (Σ):")
///    print(svd.S)
///
///    print("Right singular vectors (V):")
///    for row in svd.V {
///        print(row)
///    }
///    ```
///
/// The SVD is computed using Householder reduction to bidiagonal form and QR decomposition of the resulting bidiagonal matrix.
///
/// - Complexity: O(m * n^2) for general matrices.
///
/// - Parameters:
///   - matrix: The matrix for which SVD is computed.
public class SingularValueDecomposition {
    
    /// The matrix U of left singular vectors.
    public var U: [[Double]]
    
    /// The array of singular values.
    public var S: [Double]
    
    /// The matrix V of right singular vectors.
    public var V: [[Double]]
    
    /// Initializes the Singular Value Decomposition for the given matrix.
    ///
    /// - Parameter matrix: The matrix for which SVD is computed.
    public init(matrix: [[Double]]) {
        let m = matrix.count
        let n = matrix[0].count
        var a = matrix
        var u = [[Double]](repeating: [Double](repeating: 0.0, count: n), count: m)
        var v = [[Double]](repeating: [Double](repeating: 0.0, count: n), count: n)
        var s = [Double](repeating: 0.0, count: min(m, n))
        var e = [Double](repeating: 0.0, count: n)
        var work = [Double](repeating: 0.0, count: m)
        var wantu = true
        var wantv = true
        
        let nct = min(m-1, n)
        let nrt = max(0, n-2)
        
        // Perform Householder reduction to bidiagonal form
        for k in 0..<max(nct, nrt) {
            if k < nct {
                // Compute the transformation for column k
                s[k] = 0.0
                for i in k..<m {
                    s[k] = hypot(s[k], a[i][k])
                }
                if s[k] != 0.0 {
                    if a[k][k] < 0.0 {
                        s[k] = -s[k]
                    }
                    for i in k..<m {
                        a[i][k] /= s[k]
                    }
                    a[k][k] += 1.0
                }
                s[k] = -s[k]
            }
            
            for j in k+1..<n {
                if k < nct && s[k] != 0.0 {
                    // Apply the transformation
                    var t = 0.0
                    for i in k..<m {
                        t += a[i][k] * a[i][j]
                    }
                    t = -t / a[k][k]
                    for i in k..<m {
                        a[i][j] += t * a[i][k]
                    }
                }
                
                // Update v
                e[j] = a[k][j]
            }
            
            if wantu && k < nct {
                // Update u
                for i in k..<m {
                    u[i][k] = a[i][k]
                }
            }
            
            if k < nrt {
                // Compute the transformation for row k
                e[k] = 0.0
                for i in k+1..<n {
                    e[k] = hypot(e[k], e[i])
                }
                if e[k] != 0.0 {
                    if e[k+1] < 0.0 {
                        e[k] = -e[k]
                    }
                    for i in k+1..<n {
                        e[i] /= e[k]
                    }
                    e[k+1] += 1.0
                }
                e[k] = -e[k]
                
                if k+1 < m && e[k] != 0.0 {
                    // Apply the transformation
                    for i in k+1..<m {
                        work[i] = 0.0
                    }
                    for j in k+1..<n {
                        for i in k+1..<m {
                            work[i] += e[j] * a[i][j]
                        }
                    }
                    for j in k+1..<n {
                        let t = -e[j] / e[k+1]
                        for i in k+1..<m {
                            a[i][j] += t * work[i]
                        }
                    }
                }
                
                // Update v
                for i in k+1..<n {
                    v[i][k] = e[i]
                }
            }
        }
        
        // Accumulate the right-hand transformations
        for k in stride(from: n-1, through: 0, by: -1) {
            if k < nrt && e[k] != 0.0 {
                // Apply the transformation
                for j in k+1..<n {
                    var t = 0.0
                    for i in k+1..<n {
                        t += v[i][k] * v[i][j]
                    }
                    t = -t / v[k+1][k]
                    for i in k+1..<n {
                        v[i][j] += t * v[i][k]
                    }
                }
            }
            
            // Set up the vector s for diagonal and update u
            for i in 0..<n {
                u[i][k] = 0.0
            }
            u[k][k] = 1.0
        }
        
        // Accumulate the left-hand transformations
        for k in stride(from: n-1, through: 0, by: -1) {
            if k < nct {
                for i in k..<m {
                    u[i][k] = 0.0
                }
                u[k][k] = 1.0
                for j in k..<n {
                    if s[k] != 0.0 {
                        var t = 0.0
                        for i in k..<m {
                            t += u[i][k] * a[i][j]
                        }
                        t = -t / u[k][k]
                        for i in k..<m {
                            u[i][j] += t * u[i][k]
                        }
                    }
                    a[k][j] = 0.0
                }
            }
            a[k][k] = s[k]
            s[k] = 0.0
        }
        
        S = s
        U = u
        V = v
    }
}
