# GSScrollableLineChart

[![CI Status](https://img.shields.io/travis/megaganjotsingh/GSScrollableLineChart.svg?style=flat)](https://travis-ci.org/megaganjotsingh/GSScrollableLineChart)
[![Version](https://img.shields.io/cocoapods/v/GSScrollableLineChart.svg?style=flat)](https://cocoapods.org/pods/GSScrollableLineChart)
[![License](https://img.shields.io/cocoapods/l/GSScrollableLineChart.svg?style=flat)](https://cocoapods.org/pods/GSScrollableLineChart)
[![Platform](https://img.shields.io/cocoapods/p/GSScrollableLineChart.svg?style=flat)](https://cocoapods.org/pods/GSScrollableLineChart)

The ScrollableLineChart library is a robust and versatile Swift library designed to create smooth, interactive, and scrollable line charts in iOS applications. This library caters to developers who need an efficient and customizable way to present time-series data or any other data that benefits from a linear graphical representation.

 Line Chart Without Curve | Curved Line Chart
:-------------------------:|:-------------------------:|
<img src="./Images/Simulator Screen Shot - iPhone 14 - 2023-11-15 at 22.24.45.png" width="120" height="195"> | <img src="./Images/Simulator Screen Shot - iPhone 14 - 2023-11-15 at 22.25.03.png" width="120" height="195"> 

## Usage

```swift
@IBOutlet weak var lineChart: LineChart!

func updateData() {
  lineChart.dataEntries = [
    PointEntry(value: 1, label: "one"),
    PointEntry(value: 2, label: "two"),
    PointEntry(value: 3, label: "three"),
  ]
}
```

## Requirements

Swift Version - 5.0

## Properties

Gap between each point
- `lineGap`: CGFloat = `40.0`

Preseved space at top of the chart
- `topSpace`: CGFloat = `40.0`
    
Preserved space at bottom of the chart to show labels along the Y axis
- `bottomSpace`: CGFloat = `40.0`
    
The top most horizontal line in the chart will be 10% higher than the highest value in the chart
- `topHorizontalLine`: CGFloat = `110.0 / 100.0`
    
- `isCurved`: Bool = `false`

Active or desactive animation on dots
- `animateDots`: Bool = `false`

Active or desactive dots
- `showDots`: Bool = `true`

Dot inner Radius
- `innerRadius`: CGFloat = `6`

Dot outer Radius
- `outerRadius`: CGFloat = `8`

## Installation

GSScrollableLineChart is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GSScrollableLineChart'
```

## Author

megaganjotsingh, megaganjotsingh@gmail.com

## License

GSScrollableLineChart is available under the MIT license. See the LICENSE file for more info.

## Contribution
Contributions to the GSScrollableLineChart library are welcome. You can fork the repository and submit pull requests to enhance features or fix issues. For major changes, please open an issue first to discuss what you would like to change.
