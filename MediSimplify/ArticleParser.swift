import Foundation

class ArticleParser: NSObject, XMLParserDelegate {
    
    // Array to hold articles parsed from the XML.
    private var articles: [Article] = []
    private var foundIDs: [String] = []
    private var currentElement: String = ""
    private var foundCharacters: String = ""
    private var currentArticle: Article?
    
    // Parses XML data and returns an array of Article objects.
    func parseArticles(from data: Data) -> [Article] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return articles
    }

    // Parses XML data and returns an array of IDs.
    func parseIDs(from data: Data) -> [String] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return foundIDs
    }
    
    // XMLParserDelegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "PubmedArticle" {
            currentArticle = Article(id: "", title: "", authors: [], abstract: "", publicationDate: "", journalName: "")
        } else if elementName == "ArticleTitle" || elementName == "AbstractText" || elementName == "Author" || elementName == "Year" || elementName == "Month" || elementName == "Day" || elementName == "Title" || elementName == "PMID" {
            foundCharacters = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundCharacters += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "PMID" {
            currentArticle?.id = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        } else if elementName == "ArticleTitle" {
            currentArticle?.title = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        } else if elementName == "AbstractText" {
            currentArticle?.abstract = (currentArticle?.abstract ?? "") + foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
        } else if elementName == "PubmedArticle" {
            if let article = currentArticle {
                articles.append(article)
            }
            currentArticle = nil
        } else if elementName == "Author" {
            currentArticle?.authors?.append(foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines))
        } else if elementName == "Year" {
            if currentElement == "PubDate" {
                currentArticle?.publicationDate = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else if elementName == "Month" {
            if currentElement == "PubDate" {
                currentArticle?.publicationDate? += "-\(foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines))"
            }
        } else if elementName == "Day" {
            if currentElement == "PubDate" {
                currentArticle?.publicationDate? += "-\(foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines))"
            }
        } else if elementName == "Title" {
            currentArticle?.journalName = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        foundCharacters = ""
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        articles = []
        foundIDs = []
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        // Parsing is done
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parse error: \(parseError.localizedDescription)")
    }
}

