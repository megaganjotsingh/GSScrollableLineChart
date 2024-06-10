# ScrollableLineChart

 Hacking with Swift Certificate | SwiftUI Udemy Certificate
:-------------------------:|:-------------------------:|
<img src="./Images/Simulator Screen Shot - iPhone 14 - 2023-11-15 at 22.24.45.png" width="250" height="195"> | <img src="./Images/Simulator Screen Shot - iPhone 14 - 2023-11-15 at 22.25.03.png" width="250" height="195"> 

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

## Features

- Very simple
- Easy to customize
- Pin Pointing
- Area under the lines

## Properties

Both `x` and `y` properties are of type `Coordinate`.

If you'd like to show extra dots at your data points use the `Dots` features.

/// gap between each point
- `lineGap`: CGFloat = `40.0`
    
/// preseved space at top of the chart
- `topSpace`: CGFloat = `40.0`
    
/// preserved space at bottom of the chart to show labels along the Y axis
- `bottomSpace`: CGFloat = `40.0`
    
/// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
- `topHorizontalLine`: CGFloat = `110.0 / 100.0`
    
- `isCurved`: Bool = `false`

/// Active or desactive animation on dots
- `animateDots`: Bool = `false`

/// Active or desactive dots
- `showDots`: Bool = `true`

/// Dot inner Radius
- `innerRadius`: CGFloat = `6`

/// Dot outer Radius
- `outerRadius`: CGFloat = `8`

## License

MIT
