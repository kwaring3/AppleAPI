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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewControllerState: SearchState = .displayAllResults {
        didSet {
            DispatchQueue.main.async {
                self.appleTableView.reloadData()
            }
        }
    }
    var searchResults = [Result]()
    private var results = [Result](){
        didSet {
            DispatchQueue.main.async {
                self.title = "Books (\(self.results.count))"
                self.appleTableView.reloadData()
            }
        }
    }
    
    enum SearchState {
        case isBeingSeached
        case displayAllResults
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appleTableView.dataSource = self
        getSwiftBooks()
        appleTableView.delegate = self
        searchBar.delegate = self
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = appleTableView.indexPathForSelectedRow, let destination = segue.destination as? AppleDetailViewController else {fatalError("index path nil")}
        let result = results[indexPath.row]
        destination.result = result
    }
    
    func getBooks(named keyword: String) {
        searchResults = results.filter {$0.trackName.contains(keyword)}
    }
    
    func getSwiftBooks() {
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
        switch viewControllerState{
        case.isBeingSeached:
            return searchResults.count
        case.displayAllResults:
            return results.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appleTableView.dequeueReusableCell(withIdentifier: "AppleCell" , for: indexPath)
        let resultsToSet = viewControllerState == .displayAllResults ? results[indexPath.row]: searchResults[indexPath.row]
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

extension AppleBooksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchBar.resignFirstResponder()
        //        guard let text = searchBar.text,
        //            let encodedSearchText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
        guard let text = searchBar.text else {
            return
        }
        if text == "" {
            viewControllerState = .displayAllResults
            searchResults = []
        } else {
            viewControllerState = .isBeingSeached
            getBooks(named: text)
        }
    }
    
}




