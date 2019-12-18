//
//  AddFlightViewController.swift
//  coredata_app
//
//  Created by Alexander on 15.12.2019.
//  Copyright © 2019 Alexander Yalunin. All rights reserved.
//

import CoreData
import UIKit

class AddFlightViewController: UIViewController {

    @IBOutlet weak var fromCountry: UITextField!
    @IBOutlet weak var toCountry: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    
    var instanceOfFTVC: FlightsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addFlight(_ sender: Any) {
        
        if fromCountry.text == "" || toCountry.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if startDate.date > endDate.date + 1{
            let alertController = UIAlertController(title: "Oops", message: "The end date should be after the start date. Please try again.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let s_fromCountry = fromCountry.text ?? ""
        let s_toCountry = toCountry.text ?? ""
        let s_startDate = dateFormatter.string(from: startDate.date)
        let s_endDate = dateFormatter.string(from: endDate.date)


        print("fromCountry: \(s_fromCountry) ")
        print("toCountry: \(s_toCountry)")
        print("startDate: \(s_startDate)")
        print("endDate: \(s_endDate)")

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
          }

          let managedContext = appDelegate.persistentContainer.viewContext
          let entity = NSEntityDescription.entity(forEntityName: "Flight", in: managedContext)!
          let flight = NSManagedObject(entity: entity, insertInto: managedContext)
          flight.setValue(s_fromCountry, forKeyPath: "fromCountry")
          flight.setValue(s_toCountry, forKeyPath: "toCountry")
          flight.setValue(startDate.date, forKeyPath: "fromDate")
          flight.setValue(endDate.date, forKeyPath: "toDate")

          do {
            try managedContext.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        
        
        
        
//        instanceOfFTVC = (storyboard?.instantiateViewController(withIdentifier: "FlightsTableViewControllerID") as! FlightsTableViewController?)!
//        instanceOfFTVC.fetchAndReload()
    DataManager.shared.firstVC.fetchAndReload()
        dismiss(animated: true, completion: nil)
    }
        
}



