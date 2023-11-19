//
//  APIService.swift
//  MediSimplify
//
//  Created by Shantalia Z on 11/18/23.
//

import Foundation
import Foundation

class APIService {
    static let shared = APIService()
    let baseURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"

    // eSearch: Fetches a list of IDs based on a search term
    func fetchArticleIDs(searchTerm: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let searchURL = "\(baseURL)esearch.fcgi?db=pubmed&term=\(searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        performRequest(urlString: searchURL) { result in
            switch result {
            case .success(let data):
                // Parse XML data to extract IDs and call completion
                let parser = ArticleParser()
                let ids = parser.parseIDs(from: data)
                completion(.success(ids))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // eFetch: Fetches detailed information for a given list of IDs
    // eFetch: Fetches detailed information for a given list of IDs
    func fetchArticleDetails(ids: [String], completion: @escaping (Result<[Article], Error>) -> Void) {
        let joinedIDs = ids.joined(separator: ",")
        let fetchURL = "\(baseURL)efetch.fcgi?db=pubmed&id=\(joinedIDs)&retmode=xml"
        performRequest(urlString: fetchURL) { result in
            switch result {
            case .success(let data):
                // Parse XML data to extract article details and call completion
                let parser = ArticleParser()
                let articles = parser.parseArticles(from: data) // Replace with the correct parsing method
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    // Helper function to perform a network request
    private func performRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(APIError.noData))
            }
        }
        task.resume()
    }

    enum APIError: Error {
        case invalidURL
        case noData
    }
}
