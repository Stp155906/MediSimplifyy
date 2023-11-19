import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate{
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        // Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for articles"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // added
        searchController.searchBar.delegate = self
    }
    
    // UISearchResultsUpdating Method
    func updateSearchResults(for searchController: UISearchController) {
        // This is called when the user updates the search text.
    }
    
    // Trigger the segue to the ResultsTableViewController when the user taps 'Search'
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            return
        }
        // Dismiss the searchController and then perform the segue
        searchController.dismiss(animated: true) {
            self.performSegue(withIdentifier: "segue", sender: searchTerm)
        }
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue",
           let searchTerm = sender as? String,
           let resultsVC = segue.destination as? ResultsTableViewController {
            resultsVC.searchTerm = searchTerm
        }
        
    }
    
}
