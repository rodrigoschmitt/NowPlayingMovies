//
//  Movies_iOSTests.swift
//  Movies-iOSTests
//
//  Created by Rodrigo Andrade on 03/12/16.
//  Copyright © 2016 DevMac. All rights reserved.
//

import XCTest
@testable import Movies_iOS

class Movies_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetMovies() {
        
        let expectationMovie = expectation(description: "Expectation for MoviesManager")
        
        let moviesManager = MoviesManager()
        
        moviesManager.getMovies({ (movies, error) -> () in
            if error == nil {
                XCTAssertTrue((movies?.count)! > 0)
            } else {
                XCTFail(error.debugDescription)
            }
            
            expectationMovie.fulfill()
        })
        
        waitForExpectations(timeout: 3.0) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
    
}
