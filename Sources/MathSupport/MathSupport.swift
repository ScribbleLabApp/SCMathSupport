// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// MathSupport.swift
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

import SwiftUI
import MathJaxSwift
//import HTMLEntities

/// A view that can parse and render TeX and LaTeX equations that contain
/// math-mode marcos.
///
/// @Beta
/// - Note: This function is currently in beta
@available(iOS 18.0, *)
public struct Math: View {
    
    /// A closure that takes an equation number and returns a string to display in
    /// the view.
    public typealias FormatEquationNumber = (_ n: Int) -> String
    
    public enum BlockMode {
        
        /// Block equations are ignored and always rendered inline.
        case alwaysInline
        
        /// Blocks are rendered as text with newlines.
        case blockText
        
        /// Blocks are rendered as views.
        case blockViews
    }
    
    /// The view's equation number mode.
    public enum EquationNumberMode {
        
        /// The view should not number named block equations.
        case none
        
        /// The view should number named block equations on the left side.
        case left
        
        /// The view should number named block equations on the right side.
        case right
    }
    
    /// The view's error mode.
    public enum ErrorMode {
        
        /// The rendered image should be displayed (if available).
        case rendered
        
        /// The original LaTeX input should be displayed.
        case original
        
        /// The error text should be displayed.
        case error
    }
    
    /// The view's rendering mode.
    public enum ParsingMode {
        
        /// Render the entire text as the equation.
        case all
        
        /// Find equations in the text and only render the equations.
        case onlyEquations
    }
    
    /// The view's rendering style.
    public enum RenderingStyle {
        
        /// The view remains empty until its finished rendering.
        case empty
        
        /// The view displays the input text until its finished rendering.
        case original
        
        /// The view displays a progress view until its finished rendering.
        case progress
        
        /// The view blocks on the main thread until its finished rendering.
        case wait
    }
    
    /// The package's shared data cache.
    public static var dataCache: NSCache<NSString, NSData> {
        Cache.shared.dataCache
    }
    
#if os(macOS)
    /// The package's shared image cache.
    public static var imageCache: NSCache<NSString, NSImage> {
        Cache.shared.imageCache
    }
#else
    /// The package's shared image cache.
    public static var imageCache: NSCache<NSString, UIImage> {
        Cache.shared.imageCache
    }
#endif
    
    /// The view's LaTeX input string.
    public let latex: String
    
//    /// What to do in the case of an error.
//    @Environment(\.errorMode) private var errorMode
//    
//    /// Whether or not we should unencode the input.
//    @Environment(\.unencodeHTML) private var unencodeHTML
//    
//    /// Should the view parse the entire input string or only equations?
//    @Environment(\.parsingMode) private var parsingMode
//    
//    /// The view's block rendering mode.
//    @Environment(\.blockMode) private var blockMode
//    
//    /// Whether the view should process escapes.
//    @Environment(\.processEscapes) private var processEscapes
//    
//    /// The view's rendering style.
//    @Environment(\.renderingStyle) private var renderingStyle
//    
//    /// The animation the view should apply to its rendered images.
//    @Environment(\.renderingAnimation) private var renderingAnimation
    
    /// The view's current display scale.
    @Environment(\.displayScale) private var displayScale
    
    /// The view's font.
    @Environment(\.font) private var font
    
    /// The view's renderer.
    @StateObject private var renderer = Renderer()
    
    /// The view's preload task, if any.
    @State private var preloadTask: Task<(), Never>?
    
    /// Initializes a view with a LaTeX input string.
    ///
    /// - Parameter latex: The LaTeX input.
    public init(_ latex: String) {
        self.latex = latex
    }
    
    public var body: some View {
        Text("")
    }
}

extension Math {
    
    private func isCached() -> Bool {
        return true
    }
}
