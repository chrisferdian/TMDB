//
//  CoordinatorTest.swift
//  TMDBTests
//
//  Created by TMLI IT DEV on 24/10/20.
//

import XCTest
@testable import TMDB

class CoordinatorTest: XCTestCase {

    let appCoordinator = dummyAppCoordinator()
    let mainCoordinator = dummyMainCoordinator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStoreChild() {
        appCoordinator.store(coordinator: mainCoordinator)
        XCTAssertTrue(!appCoordinator.childCoordinators.isEmpty)
    }

    func testFreeChild() {
        appCoordinator.free(coordinator: mainCoordinator)
        XCTAssertTrue(appCoordinator.childCoordinators.isEmpty)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class dummyAppCoordinator: BaseCoordinator {override func start() {}}

class dummyMainCoordinator: BaseCoordinator {override func start() {}}
