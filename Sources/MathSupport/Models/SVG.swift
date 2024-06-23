//
// SVG.swif
// MathSupport Core
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

internal struct SVG: Codable, Hashable {
    
    enum svgError: Error {
        case encodingSVGData
    }
    
    /// The SVG's data.
    let data: Data
    
    /// The SVG's geometry.
    let geometry: MSGeometry
    
    /// Any error text produced when creating the SVG.
    let errorText: String?
    
    /// Initializes a new SVG from data.
    ///
    /// - Parameter data: The SVG data.
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    /// Initializes a new SVG.
    ///
    /// - Parameters:
    ///   - svgString: The SVG's input string.
    ///   - errorText: The error text that was generated when creating the SVG.
    init(svgString: String, errorText: String? = nil) throws {
        self.errorText = errorText
        
        geometry = try MSGeometry(svg: svgString)
        
        if let svgData = svgString.data(using: .utf8) {
            data = svgData
        } else {
            throw svgError.encodingSVGData
        }
    }
}

extension SVG {
    /// The JSON encoded value of the receiver.
    ///
    /// - Returns: The receivers JSON encoded data.
    func encoded() throws -> Data {
        try JSONEncoder().encode(self)
    }
}