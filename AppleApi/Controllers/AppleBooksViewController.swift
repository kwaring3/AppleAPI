//
//  AppleBooksViewController.swift
//  AppleApi
//
//  Created by Kevin Waring on 12/28/18.
//  Copyright © 2018 Kevin Waring. All rights reserved.
//

import UIKit

class AppleBooksViewController: UIViewController {

    @IBOutlet weak var appleTableView: UITableView!
    
    private var results = [Result](){
        didSet {
            DispatchQueue.main.async {
                self.appleTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       appleTableView.dataSource = self
        //AppleAPI.searchResults()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = appleTableView.indexPathForSelectedRow, let destination = segue.destination as? AppleDetailViewController else {fatalError("index path nil")}
        let result = results[indexPath.row]
        destination.result = result
    }
    

    
    func searchResults(keyWord: String) {
        AppleAPI.searchResults(keyword: "ios"){ (error, events) in
            if let error = error{
                print("error: \(error)")
            }else if let results = self.result {
                self.results = results
                print("\(events.count)")
            }
        }
        
    }
}
extension AppleBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appleTableView.dequeueReusableCell(withIdentifier: "AppleCell" , for: indexPath)
        let resultsToSet = results[indexPath.row]
        cell.textLabel?.text = resultsToSet.trackName
        return cell
    }
    
    
}