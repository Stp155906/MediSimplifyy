//
//  Article.swift
//  MediSimplify
//
//  Created by Shantalia Z on 11/18/23.
//

import Foundation
//
//  Article.swift
//  nlmapp
//
//  Created by Shantalia Z on 10/17/23.
//
import Foundation



struct Article {
    var id: String            // Corresponds to PubMed ID (PMID)
    var title: String         // Title of the article
    var authors: [String]?    // List of authors (this might require additional parsing)
    var abstract: String?     // Abstract of the article
    var publicationDate: String?  // Date of publication (CreateDate in DocSum)
    var journalName: String?  // Journal name if available
    // ... other properties as necessary

    init(id: String, title: String, authors: [String]? = nil, abstract: String? = nil, publicationDate: String? = nil, journalName: String? = nil) {
        self.id = id
        self.title = title
        self.authors = authors
        self.abstract = abstract
        self.publicationDate = publicationDate
        self.journalName = journalName
    }
}



