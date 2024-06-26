//
// Cache.swifr
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
import CryptoKit

fileprivate protocol CacheKey: Codable {
    
    /// The key type used to identify the cache key in storage.
    static var keyType: String { get }
    
    /// A key to use if encoding fails.
    var fallbackKey: String { get }
}

extension CacheKey {
    func key() -> String {
        do {
            let data = try JSONEncoder().encode(self)
            let hashedData = SHA256.hash(data: data)
            return hashedData.compactMap { String(format: "%02x", $0) }.joined() + "-" + Self.keyType
        } catch {
            return fallbackKey + "-" + Self.keyType
        }
    }
}

internal class Cache {
    static let shared = Cache()
    
    /// The renderer's data cache.
    let dataCache: NSCache<NSString, NSData> = NSCache()
    
    /// The renderer's image cache.
    let imageCache: NSCache<NSString, _Image> = NSCache()
}
