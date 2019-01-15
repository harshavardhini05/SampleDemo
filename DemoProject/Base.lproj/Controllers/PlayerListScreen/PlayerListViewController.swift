//
//  PlayerListViewController.swift
//  DemoProject
//
//  Created by HarshaVardhini on 08/01/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import UIKit
import CoreData
class PlayerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate  {
    
    @IBOutlet weak var playerListTableView: UITableView!
    
    @IBOutlet weak var navigationTitleLabel: UILabel!
    var country: Countries!
    let appDelegate: AppDelegate = UIApplication.shared.delegate as!  AppDelegate
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> =  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Players.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let predicate = NSPredicate(format: "countryId == %@", country.id!)
        fetchRequest.predicate = predicate
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.updateTableContent()
        self.navigationTitleLabel.text = country.name!
        self.playerListTableView.tableFooterView = UIView()

        print("country : \(String(describing: country.name))")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
    }
    private func configTableView() {
        self.playerListTableView.delegate = self
        self.playerListTableView.dataSource = self
    }

    func updateTableContent() {
        do {
            try self.fetchedResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedResultController.sections?[0].numberOfObjects))")
        } catch let error  {
            print("ERROR: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showPopUpMethod() {
        let  addPlayerController: AddPlayerPopController =  self.storyboard?.instantiateViewController(withIdentifier: "AddPlayerPopController") as! AddPlayerPopController
        
        addPlayerController.modalTransitionStyle = .crossDissolve
        addPlayerController.modalPresentationStyle = .overCurrentContext
        addPlayerController.country = self.country
        self.present(addPlayerController, animated: true, completion: nil)
    }
    @IBAction func backBtnAction(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBtnAction(_ sender: Any)
    {
        self.showPopUpMethod ( )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PlayerListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayerListTableViewCell", for: indexPath) as! PlayerListTableViewCell
        cell.deleteBtn.tag = indexPath.row
        cell.delegate = self
        if let player = fetchedResultController.object(at: indexPath) as? Players {
            cell.playerNameTxt.text = player.name!
        }
        
        return cell
    }

}

extension PlayerListViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            self.playerListTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.playerListTableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.playerListTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.playerListTableView.beginUpdates()
    }
}

extension PlayerListViewController : PlayerListTableViewCellDelegate {
    func didDeletePlayer(_ btnIndexPath: IndexPath) {
        guard let player = fetchedResultController.object(at: btnIndexPath) as? Players else {
            return
        }
     
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Players.self))
        let predicate = NSPredicate(format: "name == %@", player.name!)
        fetchRequest.predicate = predicate
        if let result = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) {
            for object in result {
                appDelegate.persistentContainer.viewContext.delete(object as! NSManagedObject)
            }
        }
    }
}
