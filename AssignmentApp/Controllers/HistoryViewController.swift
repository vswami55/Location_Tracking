//
//  HistoryViewController.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var records: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Records"
//        tableView.register(UITableViewCell.self,
//                           forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      fetchAllTravellsData()
    }
    
    func fetchAllTravellsData(){

      if CoreDatabase.sharedManager.fetchAllRecords() != nil{
        
          records = CoreDatabase.sharedManager.fetchAllRecords()!
          tableView.reloadData()

      }
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

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
      return records.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let record = records[indexPath.row]
//      var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
      let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

//      if cell == nil {
//          cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//      }
    cell.textLabel?.text = "Distance meters: \(record.value(forKeyPath: "meters") as! Int)"
    cell.detailTextLabel?.text = record.value(forKeyPath: "dateTime") as? String
    return cell
}
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
