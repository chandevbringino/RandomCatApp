//
//  RandomCatAPI.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/2/24.
//

import Foundation

class RandomCatAPI {
    var randomCatFactUrl: String { "https://meowfacts.herokuapp.com/" }
    var randomCatImageUrl: String { "https://api.thecatapi.com/v1/images/search" }
}

// MARK: - Methods

extension RandomCatAPI {
    func fetchCatDetails(
        onSuccess: @escaping SingleResult<CatModel>,
        onError: @escaping ErrorResult
    ) {
        Task {
            do {
                let results = try await fetchCat()
                let catImageUrl = URL(string: results.1.first?.url ?? "")
                let fact = results.0.data.first ?? ""
                let cat = CatModel(
                    fact: fact,
                    imageUrl: catImageUrl
                )
                onSuccess(cat)
            } catch {
                onError(error)
            }
        }
    }
}

// MARK: - Async / Await

private extension RandomCatAPI {
    func fetchCatFact() async throws -> CatFactResult {
        let url = URL(string: randomCatFactUrl)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CatFactResult.self, from: data)
    }

    func fetchCatImage() async throws -> [CatImageResult] {
        let url = URL(string: randomCatImageUrl)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([CatImageResult].self, from: data)
    }

    func fetchCat() async throws -> (CatFactResult, [CatImageResult]) {
        async let result1 = fetchCatFact()
        async let result2 = fetchCatImage()
        
        let combinedResults = try await (result1, result2)
        return combinedResults
    }
}
