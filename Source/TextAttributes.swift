//
//  TextAttributes.swift
//  GSScrollableLineChart
//
//  Created by Gaganjot Singh on 17/06/24.
//

import Foundation

public struct TextAttributes {
    /// Minimum font size for text
    public var minFontSize: CGFloat = 10
    
    /// Maximum font size for text
    public var maxFontSize: CGFloat = 12
    
    /// Text color
    public var textColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    /// Bold Range
    public var boldRange: NSRange? = nil
    
    /// Background color
    public var bgColor: UIColor = .clear
}
