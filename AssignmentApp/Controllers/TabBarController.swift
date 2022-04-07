//
//  TabBarController.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedLocalNotification(notification:)), name: Notification.Name("ReceivedLocalNotification"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func receivedLocalNotification(notification: Notification) {
        self.selectedIndex = 2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
