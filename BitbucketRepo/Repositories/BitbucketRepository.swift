//
//  BitbucketRepository.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BitbucketRepositoryType {
    var nextPageURL: String? { get }
    func fetch(_ url: String, completion: @escaping (Result<[Bitbucket], Error>) -> Void)
    func fetchMore(completion: @escaping (Result<[Bitbucket], Error>) -> Void)
}

class BitbucketRepository: BitbucketRepositoryType {
    
    private(set) var nextPageURL: String?
    let apiClient: ApiClientType
    
    init(apiClient: ApiClientType = ApiClient()) {
        self.apiClient = apiClient
    }

    func fetch(_ url: String, completion: @escaping (Result<[Bitbucket], Error>) -> Void) {
        apiClient.get(url: url) { [weak self] result in
            guard let s = self else { return }
            
            switch result {
            case .success(let json):
                s.nextPageURL = json["next"].string
                let result = json["values"].arrayValue.map { (valueJSON: JSON) -> Bitbucket in
                    return Bitbucket.parse(json: valueJSON)
                }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchMore(completion: @escaping (Result<[Bitbucket], Error>) -> Void) {
        guard let nextToken = nextPageURL else { return }
        fetch(nextToken, completion: completion)
    }
    
}
