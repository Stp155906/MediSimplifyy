import UIKit

class ResultsTableViewController: UITableViewController {
    var articles: [Article] = [] // This will hold your search results

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view, typically from a nib.
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Return the number of sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count // Return the number of rows in the section
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title // Assuming 'Article' has a 'title' property

        return cell
    }
}
