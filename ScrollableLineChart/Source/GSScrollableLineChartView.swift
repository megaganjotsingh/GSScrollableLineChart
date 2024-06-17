//
//  LineChart.swift
//  NisiWater
//
//  Created by Gagan Mac on 28/05/20.
//  Copyright © 2020 Gaganjot singh. All rights reserved.
//

import UIKit

public struct PointEntry {
    let value: CGFloat
    let label: String
    
    public init(value: CGFloat, label: String) {
        self.value = value
        self.label = label
    }
}

extension PointEntry: Comparable {
    public static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    public static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value
    }
}

public class GSScrollableLineChartView: UIView {
    
    public var chartProperties: ChartAttributes = .init()
    
    public var textProperties: TextAttributes = .init()
        
    public var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()
    
    /// To show the gradient below the main line
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// Contains all dots in Data layer
    private let dotsLayer: CALayer = CALayer()
    
    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        scrollView.canCancelContentTouches = false
        mainLayer.addSublayer(dataLayer)
        
        gradientLayer.colors = [chartProperties.gradientFirstColor.cgColor, chartProperties.gradientSecondColor.cgColor]
        scrollView.layer.addSublayer(gradientLayer)
        scrollView.layer.addSublayer(mainLayer)
        scrollView.layer.addSublayer(dotsLayer)
        
        self.addSubview(scrollView)
        self.layer.addSublayer(gridLayer)
        self.backgroundColor = chartProperties.bgColor
    }
    
    open override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if let dataEntries = dataEntries {
            scrollView.contentSize = CGSize(width: (CGFloat(dataEntries.count) * chartProperties.lineGap) + 15, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * chartProperties.lineGap, height: self.frame.size.height)
            dotsLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * chartProperties.lineGap, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: chartProperties.topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - chartProperties.topSpace - chartProperties.bottomSpace)
            gradientLayer.frame = dataLayer.frame
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
            gridLayer.frame = CGRect(x: 0, y: chartProperties.topSpace, width: self.frame.width, height: mainLayer.frame.height - chartProperties.topSpace - chartProperties.bottomSpace)
            if chartProperties.showDots { drawDots() }
            clean()
            drawHorizontalLines()
            if chartProperties.isCurved {
                drawCurvedChart()
            } else {
                drawChart()
            }
            maskGradientLayer()
            drawLables()
        }
    }
    
    /**
     Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
     */
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        if let max = entries.max()?.value,
            let min = entries.min()?.value {
            
            var result: [CGPoint] = []
            var minMaxRange: CGFloat = CGFloat(max - min) * chartProperties.topHorizontalLine
            if minMaxRange == 0.0 //if it has 0 because of a min and max is 0
            {
                minMaxRange = 1.0
            }
            
            for i in 0..<entries.count {
                let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
                let point = CGPoint(x: CGFloat(i)*chartProperties.lineGap + 40, y: height)
                result.append(point)
            }
            return result
        }
        return []
    }
    
    /**
     Draw a zigzag line connecting all points in dataPoints
     */
    private func drawChart() {
        if let dataPoints = dataPoints,
            dataPoints.count > 0,
            let path = createPath() {
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 2
            lineLayer.strokeColor = chartProperties.gradientFirstColor.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    /**
     Create a zigzag bezier path that connects all points in dataPoints
     */
    private func createPath() -> UIBezierPath? {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        for i in 1..<dataPoints.count {
            path.addLine(to: dataPoints[i])
        }
        return path
    }
    
    /**
     Draw a curved line connecting all points in dataPoints
     */
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 2
            lineLayer.strokeColor = chartProperties.gradientFirstColor.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    /**
     Create a gradient layer below the line that connecting all dataPoints
     */
    private func maskGradientLayer() {
        if let dataPoints = dataPoints,
            dataPoints.count > 0 {
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
            path.addLine(to: dataPoints[0])
            if chartProperties.isCurved,
                let curvedPath = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
                path.append(curvedPath)
            } else if let straightPath = createPath() {
                path.append(straightPath)
            }
            path.addLine(to: CGPoint(x: dataPoints[dataPoints.count-1].x, y: dataLayer.frame.height))
            path.addLine(to: CGPoint(x: dataPoints[0].x, y: dataLayer.frame.height))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            maskLayer.fillColor = UIColor.white.cgColor
            maskLayer.strokeColor = UIColor.clear.cgColor
            maskLayer.lineWidth = 0.0
            
            gradientLayer.mask = maskLayer
        }
    }
    
    /**
     Create titles at the bottom for all entries showed in the chart
     */
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: chartProperties.lineGap*CGFloat(i) - chartProperties.lineGap/2 + 40, y: mainLayer.frame.size.height - chartProperties.bottomSpace/2 - 8, width: chartProperties.lineGap, height: 16)
                textLayer.foregroundColor = textProperties.textColor.cgColor
                textLayer.backgroundColor = textProperties.bgColor.cgColor
                
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.string =
                self.attributedString(from: dataEntries[i].label, boldRange: textProperties.boldRange, MaxFontSize: textProperties.maxFontSize, MinFontSize: textProperties.minFontSize, textColor: textProperties.textColor)
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    /**
     Create horizontal lines (grid lines) and show the value of each line
     */
    private func drawHorizontalLines() {
        guard let dataEntries = dataEntries else {
            return
        }
        
        let gridValues = chartProperties.gridValues
        
        for value in gridValues {
            let height = value * gridLayer.frame.size.height
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
            lineLayer.lineWidth = 0.5
            if chartProperties.showTopLineDotted ? value < 1.0 : (
                value > 0.0 //this is for top line
                &&
                value < 1.0 //this is for base line
            ) {
                lineLayer.lineDashPattern = [4, 4]
            }
            
            gridLayer.addSublayer(lineLayer)
            
            var minMaxGap:CGFloat = 0
            var lineValue:Double = 0
            if let max = dataEntries.max()?.value,
               let min = dataEntries.min()?.value {
                minMaxGap = CGFloat(max - min) * chartProperties.topHorizontalLine
                lineValue = (Double((1-value) * minMaxGap) + Double(min)).rounded(toPlaces: 1)
            }
            
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: 4, y: height, width: textProperties.minFontSize * 2, height: textProperties.minFontSize)
            textLayer.foregroundColor = textProperties.textColor.cgColor
            textLayer.backgroundColor = textProperties.bgColor.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = textProperties.minFontSize
            textLayer.string = "\(lineValue)"
            
            gridLayer.addSublayer(textLayer)
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})

        
    }
    /**
     Create Dots on line points
     */
    private func drawDots() {
        var dotLayers: [DotCALayer] = []
        dotsLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        if let dataPoints = dataPoints {
            for dataPoint in dataPoints {
                //for straight lines path
                let xValue = dataPoint.x - chartProperties.outerRadius/2
                let yValue = (dataPoint.y + chartProperties.lineGap) - (chartProperties.outerRadius*0.5)
                let dotLayer = DotCALayer()
                dotLayer.dotInnerColor = chartProperties.gradientFirstColor
                dotLayer.innerRadius = chartProperties.innerRadius
                dotLayer.backgroundColor = UIColor.white.cgColor
                dotLayer.cornerRadius = chartProperties.outerRadius / 2
                dotLayer.shadowOffset = CGSize(width: 0, height: 0)
                dotLayer.shadowColor = #colorLiteral(red: 0.1605761051, green: 0.1642630696, blue: 0.1891490221, alpha: 1)
                dotLayer.shadowRadius = 1
                dotLayer.shadowOpacity = 0.8
                dotLayer.frame = CGRect(x: xValue, y: yValue, width: chartProperties.outerRadius, height: chartProperties.outerRadius)
                dotLayers.append(dotLayer)
                    dotsLayer.addSublayer(dotLayer)
                
                if chartProperties.animateDots {
                    let anim = CABasicAnimation(keyPath: "opacity")
                    anim.duration = 1.0
                    anim.fromValue = 0
                    anim.toValue = 1
                    dotLayer.add(anim, forKey: "opacity")
                }
            }
        }
        drawValuesOnDots()
    }
    
    private func drawValuesOnDots() {
        
        if let dataPoints = dataPoints {
            for (index,dataPoint) in dataPoints.enumerated() {
                let xValue = dataPoint.x - 20
                let yValue = (dataPoint.y + chartProperties.lineGap) - (chartProperties.outerRadius * 3)
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: xValue, y: yValue, width: 40, height: 30)
                textLayer.foregroundColor = textProperties.textColor.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.fontSize = textProperties.minFontSize
                textLayer.string = "\(dataEntries?[index].value ?? 0)"
                dotsLayer.addSublayer(textLayer)
            }
        }
    }
}

extension UIView {
    func attributedString(from string: String, boldRange: NSRange?, MaxFontSize: CGFloat, MinFontSize: CGFloat, textColor: UIColor) -> NSAttributedString {
            let attrs = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: MinFontSize),
                NSAttributedString.Key.foregroundColor: textColor
            ]
            let boldAttribute = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: MaxFontSize),
            ]
            let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
            if let range = boldRange {
                attrStr.setAttributes(boldAttribute, range: range)
            }
            return attrStr
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
