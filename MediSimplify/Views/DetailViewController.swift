import UIKit

class DetailViewController: UIViewController {

    // Declare a property to hold the article data
    var article: Article?

    // IBOutlets for your labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    
    @IBOutlet weak var publicationDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the article data to populate your UI elements
        if let articleData = article {
            titleLabel.text = articleData.title
            authorsLabel.text = articleData.authors?.joined(separator: ", ")
            publicationDateLabel.text = articleData.publicationDate
            abstractTextView.text = articleData.abstract
        }
    }
}
