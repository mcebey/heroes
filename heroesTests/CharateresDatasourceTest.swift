//
//  CharateresDatasourceTest.swift
//  heroesTests
//
//  Created by Manuel Alejandro Cebey on 27/2/22.
//

import Foundation
import XCTest
import Resolver
@testable import heroes

class CharacterDataSourceTest: XCTestCase {

    override class func setUp() {
        Resolver.resetTestRegistrations()
        Resolver.root = .test
    }

    func test_get_characteres_ok() {

        let expectation = XCTestExpectation(description: "MarveApi get Characters")
        let api = MarvelApiServiceProtocolMock()
        api.getCharactersHandler = { (page, elements, completion) in
            let characterResponse = CharacterResponse(id: 1, name: "MyHero", description: "MyHero", thumbnail: ThumbnailResponse.init(path: "/someplace", ext: "jpg"))
            let data = DataClassResponse<[CharacterResponse]>(offset: 0, limit: 1, total: 2, count: 3, results: [characterResponse]);
             let result = MarvelResponse(code: 200, status: "ok", data: data)
            completion(result, nil)
        }

        Resolver.test.register(MarvelApiServiceProtocol.self) { api }
        @LazyInjected var datasource: MarvelCharactersDatasourceProtocol

        datasource.getCharacters(page: 0, elements: 1) { data, error in
            XCTAssertNil(error, "Response with error")
            XCTAssertNotNil(data, "Response was nil")
            XCTAssertEqual(data?.count, 1)
            XCTAssertEqual(data?.first?.name, "MyHero")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_get_characteres_ko() {

        let expectation = XCTestExpectation(description: "MarveApi get Characters")
        let api = MarvelApiServiceProtocolMock()
        api.getCharactersHandler = { (page, elements, completion) in
            completion(nil, .decoded)
        }

        Resolver.test.register(MarvelApiServiceProtocol.self) { api }
        @LazyInjected var datasource: MarvelCharactersDatasourceProtocol

        datasource.getCharacters(page: 0, elements: 1) { data, error in
            XCTAssertNotNil(error, "Response with error")
            XCTAssertNil(data, "Response was nil")
            XCTAssertEqual(error, .decoded)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_get_character_ok() {

        let expectation = XCTestExpectation(description: "MarveApi get Characters")
        let api = MarvelApiServiceProtocolMock()
        api.getCharacterHandler = { (id, completion) in
            let characterResponse = CharacterResponse(id: 1, name: "MyHero", description: "MyHero", thumbnail: ThumbnailResponse.init(path: "/someplace", ext: "jpg"))
            let data = DataClassResponse<[CharacterResponse]>(offset: 0, limit: 1, total: 2, count: 3, results: [characterResponse]);
             let result = MarvelResponse(code: 200, status: "ok", data: data)
            completion(result, nil)
        }

        Resolver.test.register(MarvelApiServiceProtocol.self) { api }
        @LazyInjected var datasource: MarvelCharactersDatasourceProtocol

        datasource.getCharacter(id: 1) { data, error in
            XCTAssertNil(error, "Response with error")
            XCTAssertNotNil(data, "Response was nil")
            XCTAssertEqual(data?.name, "MyHero")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func test_get_character_ko() {

        let expectation = XCTestExpectation(description: "MarveApi get Characters")
        let api = MarvelApiServiceProtocolMock()
        api.getCharacterHandler = { (id, completion) in
            completion(nil, .decoded)
        }

        Resolver.test.register(MarvelApiServiceProtocol.self) { api }
        @LazyInjected var datasource: MarvelCharactersDatasourceProtocol

        datasource.getCharacter(id: 1) { data, error in
            XCTAssertNotNil(error, "Response with error")
            XCTAssertNil(data, "Response was nil")
            XCTAssertEqual(error, .decoded)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }


}
