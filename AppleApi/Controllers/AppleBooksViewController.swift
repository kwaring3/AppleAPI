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
                self.title = "Books (\(self.results.count))"
                self.appleTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       appleTableView.dataSource = self
        searchResults(keyWord: "swift")
        appleTableView.delegate = self
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = appleTableView.indexPathForSelectedRow, let destination = segue.destination as? AppleDetailViewController else {fatalError("index path nil")}
        let result = results[indexPath.row]
        destination.result = result
    }
    

    
    func searchResults(keyWord: String) {
        AppleAPI.searchResults(keyword: "swift"){ (error, results) in
            if let error = error{
                print("error: \(error)")
            }else if let results = results {
                self.results = results
                print("\(results.count)")
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
        cell.detailTextLabel?.text = resultsToSet.description
        cell.imageView?.image = UIImage(named: "closedBook")
        
        return cell
    }
    
    
}
extension AppleBooksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
