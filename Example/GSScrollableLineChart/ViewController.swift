//
//  ViewController.swift
//  GSScrollableLineChart
//
//  Created by megaganjotsingh on 06/17/2024.
//  Copyright (c) 2024 megaganjotsingh. All rights reserved.
//

import UIKit
import GSScrollableLineChart

class ViewController: UIViewController {

    let firstChart = GSScrollableLineChartView()
    
    @IBOutlet weak var secondChart: GSScrollableLineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupFirstChart()
        setupSecondChart()
    }
    
    func setupFirstChart() {
        firstChart.chartProperties.isCurved = true
        firstChart.dataEntries = [
            PointEntry(value: 1, label: "one"),
            PointEntry(value: 2, label: "two"),
            PointEntry(value: 3, label: "three"),
            PointEntry(value: 2.5, label: "two half"),
            PointEntry(value: 1.5, label: "four"),
            PointEntry(value: 3.5, label: "five"),
            PointEntry(value: 2.4, label: "six")
        ]
        view.addSubview(firstChart)

        align()
        
        func align() {
            firstChart.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                firstChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                firstChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                firstChart.heightAnchor.constraint(equalToConstant: 200),
                firstChart.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            ])
        }
    }
    
    func setupSecondChart() {
        secondChart.textProperties.boldRange = NSRange(location: 0, length: 1)
        secondChart.dataEntries = [
            PointEntry(value: 1, label: "1 Jun"),
            PointEntry(value: 2, label: "2 Jun"),
            PointEntry(value: 3, label: "3 Jun"),
            PointEntry(value: 2.5, label: "4 Jun"),
            PointEntry(value: 1.5, label: "5 Jun"),
            PointEntry(value: 3.5, label: "6 Jun"),
            PointEntry(value: 2.4, label: "7 Jun")
        ]
    }
}

