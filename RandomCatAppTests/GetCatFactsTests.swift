//
//  GetCatFactsTests.swift
//  RandomCatAppTests
//
//  Created by Christian Bringino on 10/2/24.
//

import Foundation
import XCTest

@testable import RandomCatApp

class GetCatFactsTests: XCTestCase {
    func test_fetch_cat_details_success() throws {
        fetchCatDetailsSuccess { catModel in
            XCTAssertEqual(catModel.fact, "Cats sleep for 12-16 hours a day.")
            XCTAssertEqual(catModel.imageUrl?.absoluteString, "https://cdn2.thecatapi.com/images/251.jpg")
        } onError: { error in
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func test_fetch_cat_details_fail() throws {
        fetchCatDetailsFailed { catModel in
            XCTAssertNil(catModel)
        } onError: { error in
            XCTAssertNotNil(error)
        }
    }
}

// MARK: - Methods

private extension GetCatFactsTests {
    func fetchCatDetailsSuccess(
        onSuccess: @escaping SingleResult<CatModel>,
        onError: @escaping ErrorResult
    ) {
        Task {
            do {
                let results = try await mockFetchCatSuccess()
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
    
    func mockFetchCatSuccess() async throws -> (CatFactResult, [CatImageResult]) {
        let factResponse = CatFactResult(data: ["Cats sleep for 12-16 hours a day."])
        let imageResponse = [CatImageResult(url: "https://cdn2.thecatapi.com/images/251.jpg")]
        return (factResponse, imageResponse)
    }

    func fetchCatDetailsFailed(
        onSuccess: @escaping SingleResult<CatModel>,
        onError: @escaping ErrorResult
    ) {
        Task {
            do {
                let results = try await mockFetchCatFailure()
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
    
    func mockFetchCatFailure() async throws -> (CatFactResult, [CatImageResult]) {
        throw NSError(domain: "TestError", code: 1, userInfo: nil)
    }
}
