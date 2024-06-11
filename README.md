# ScrollableLineChart

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

## Key Features
- Smooth Scrolling: Effortlessly scroll through large datasets with seamless performance.
- Customization Options: Adjust line thickness, color, and other aesthetic elements to fit your application's design.
- Dynamic Data Handling: Easily add, update, or remove data points in real-time, ensuring your charts are always up-to-date.
- Performance Optimized: Built with performance in mind to handle large datasets without compromising on speed or responsiveness.
- Easy Integration: Simple and intuitive API for integrating the line chart into your existing iOS projects.

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

## Contribution
Contributions to the ScrollableLineChart library are welcome. You can fork the repository and submit pull requests to enhance features or fix issues. For major changes, please open an issue first to discuss what you would like to change.

## License

MIT
