import UIKit

class ResultsTableViewController: UITableViewController {
    
    var articleIDs: [String] = [] // This array will hold the article IDs fetched from the API.
    var articles: [Article] = [] // This will hold the full article details fetched from the API.
    var searchTerm: String? // The search term that was entered in the previous view controller.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let searchTerm = searchTerm {
            APIService.shared.fetchArticleIDs(searchTerm: searchTerm) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedArticleIDs):
                        self?.articleIDs = fetchedArticleIDs
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    
    // Add a new function to fetch articles based on articleIDs
    func fetchArticles(articleIDs: [String]) {
        // Implement this method to fetch article details based on IDs
        // You will need to call a function from APIService similar to fetchArticleIDs
        // For example:
        // APIService.shared.fetchArticleDetails(ids: articleIDs) { [weak self] result in
        //     DispatchQueue.main.async {
        //         switch result {
        //         case .success(let fetchedArticles):
        //             self?.articles = fetchedArticles
        //             self?.tableView.reloadData()
        //         case .failure(let error):
        //             print(error.localizedDescription)
        //         }
        //     }
        // }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count // Use articles.count here
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        // Configure the rest of your cell here
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedID = articleIDs[indexPath.row]
        APIService.shared.fetchArticleDetails(ids: [selectedID]) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedArticles):
                    self?.performSegue(withIdentifier: "detailSegueIdentifier", sender: fetchedArticles.first)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegueIdentifier",
           let destinationVC = segue.destination as? DetailViewController,
           let article = sender as? Article {
            destinationVC.article = article
        }
        
    }
    
}
