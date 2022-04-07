//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var lblTotalMeters: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblTotalMeters.text = "Loading..."
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let totalMetersCount = UserDefaults.standard.integer(forKey: "TotalTravelledDistance") 
        self.lblTotalMeters.text = "Total Travelled distance: \(totalMetersCount)"
    }

}

