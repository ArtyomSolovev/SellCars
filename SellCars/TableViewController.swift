//
//  TableViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 28.12.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var cars: [CarDB] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = Constants.getContext()
        let fetchRequest: NSFetchRequest<CarDB> = CarDB.fetchRequest()
        
        do {
            cars = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllInDB() {
        
        let context = Constants.getContext()
        let fetchRequest: NSFetchRequest<CarDB> = CarDB.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteAllInDB()
            cars.remove(at: indexPath.row)
            
            let context = Constants.getContext()

            guard let entity = NSEntityDescription.entity(forEntityName: "CarDB", in: context) else { return }

            cars.forEach { car in
                let taskObject = CarDB(entity: entity, insertInto: context)
                taskObject.userId = car.userId

                do {
                    try context.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

}
