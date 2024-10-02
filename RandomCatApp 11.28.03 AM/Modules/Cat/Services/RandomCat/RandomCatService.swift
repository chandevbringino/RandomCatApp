//
//  RandomCatService.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/2/24.
//

import Foundation

class RandomCatService: RandomCatServiceProtocol {
    private let api: RandomCatAPI
    
    init(api: RandomCatAPI) {
        self.api = api
    }
}

// MARK: - Methods

extension RandomCatService {
    func getCatDetails(
        onSuccess: @escaping SingleResult<CatModel>,
        onError: @escaping ErrorResult
    ) {
        api.fetchCatDetails(
            onSuccess: onSuccess,
            onError: onError
        )
    }
}
