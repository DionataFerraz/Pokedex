//
//  PokemonListPresenterTests.swift
//  PokedexTests
//
//  Created by Dionata Leonel Machado Ferraz on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

@testable import Pokedex
import XCTest

class PokemonListPresenterTests: XCTestCase {
    
    func testFetchData() {
        let expectation = XCTestExpectation(description: "")
        
        let presenter = PokemonListPresenter()
        let view = PokemonListViewMock {
            expectation.fulfill()
        }
        presenter.view = view
        presenter.fetchData()
        
        wait(for: [expectation], timeout: 1)
    }
}

class PokemonListViewMock: PokemonListViewType {
    let fullFill: () -> Void
    
    init(fullFill: @escaping () -> Void) {
        self.fullFill = fullFill
    }
    
    func reloadData() {
        self.fullFill()
    }
}
