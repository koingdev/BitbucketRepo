//
//  BitbucketViewModel.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import Foundation

class BitbucketViewModel {
    
    let repository: BitbucketRepositoryType
    
    init(repository: BitbucketRepositoryType = BitbucketRepository()) {
        self.repository = repository
    }
    
    func fetch(completion: @escaping ([Bitbucket]) -> Void) {
        repository.fetch("https://api.bitbucket.org/2.0/repositories") { [weak s = self] result in
            s?.resultHandler(result, completion: completion)
        }
    }
    
    func fetchMore(completion: @escaping ([Bitbucket]) -> Void) {
        repository.fetchMore { [weak s = self] result in
            s?.resultHandler(result, completion: completion)
        }
    }
    
    private func resultHandler(_ result: Result<[Bitbucket], Error>, completion: @escaping ([Bitbucket]) -> Void) {
        switch result {
        case .success(let datasource):
            completion(datasource)
        case .failure(let error):
            print(error.localizedDescription)
            completion([])
        }
    }
    
}
