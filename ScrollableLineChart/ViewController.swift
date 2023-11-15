//
//  ViewController.swift
//  ScrollableLineChart
//
//  Created by Gagan Mac on 28/05/20.
//  Copyright © 2020 Gaganjot singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.dataEntries = [
            PointEntry(value: 1, label: "one"),
            PointEntry(value: 2, label: "two"),
            PointEntry(value: 3, label: "three"),
            PointEntry(value: 2.5, label: "eq"),
            PointEntry(value: 1.5, label: "three"),
            PointEntry(value: 3.5, label: "three"),
            PointEntry(value: 2.4, label: "three")
        ]
    }


}

