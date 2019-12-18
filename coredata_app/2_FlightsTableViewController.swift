

import UIKit
import CoreData

class DataManager {

    static let shared = DataManager()
    var firstVC = FlightsTableViewController()
}

class FlightsTableViewController: UITableViewController {
    
    var flights: [Flight] = []
    var fetchResultController: NSFetchedResultsController<Flight>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.firstVC = self
    }
    
    func fetchAndReload() {
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<Flight> = Flight.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "fromDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self as? NSFetchedResultsControllerDelegate
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    flights = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAndReload()
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return flights.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let flight = flights[indexPath.row]
        
        let cellIdentifier = "FlightCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FlightCell
        
        cell.fromCountry?.text = ((flight.value(forKeyPath: "fromCountry")! as AnyObject) as? String)?.uppercased()
        cell.toCountry?.text = (flight.value(forKeyPath: "toCountry") as? String)?.uppercased()
        let fromDate = flight.value(forKeyPath: "fromDate") as! Date
        let toDate = flight.value(forKeyPath: "toDate") as! Date
        
        cell.fromDate?.text = dateFormatter.string(from: fromDate)
        cell.toDate?.text = dateFormatter.string(from: toDate)
      return cell
    }


}
