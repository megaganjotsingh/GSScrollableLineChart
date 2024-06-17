//
//  ChartProperties.swift
//  GSScrollableLineChart
//
//  Created by Gaganjot Singh on 17/06/24.
//

import Foundation

public struct ChartAttributes {
    /// gap between each point
    let lineGap: CGFloat = 40.0
    
    /// preseved space at top of the chart
    public var topSpace: CGFloat = 40.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    public var bottomSpace: CGFloat = 40.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    public var isCurved: Bool = false

    /// Active or desactive animation on dots
    public var animateDots: Bool = false

    /// Active or desactive dots
    public var showDots: Bool = true

    /// Dot inner Radius
    public var innerRadius: CGFloat = 6

    /// Dot outer Radius
    public var outerRadius: CGFloat = 8
        
    /// The top most line configuration
    public var showTopLineDotted: Bool = false
    
    /// gridient's first color
    public var gradientFirstColor: UIColor = #colorLiteral(red: 0.2039215686, green: 0.462745098, blue: 0.9764705882, alpha: 1)
    
    /// gridient's second color
    public var gradientSecondColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    /// background color
    public var bgColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    public var gridValues: [CGFloat] = [0, 0.25, 0.5, 0.75, 1]
}
