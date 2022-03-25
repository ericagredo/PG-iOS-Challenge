//
//  PG_iOS_ChallengeTests.swift
//  PG iOS ChallengeTests
//
//  Created by Eric Agredo on 3/22/22.
//

import XCTest
@testable import PG_iOS_Challenge

class PG_iOS_ChallengeTests: XCTestCase {
    
    func testItemWithNoURL() {
        let item = Item(id: 534343, type: "comment", title: "Tester", kids: [1345, 5768], by: "ericagredo")
        XCTAssertNil(item.url)
       }
    func testItemWithNoKids() {
        let item = Item(id: 534343, type: "comment", title: "Tester", by: "ericagredo")
        XCTAssertNil(item.kids)
       }
    func testItemWithKids(){
        let item = Item(id: 534343, type: "comment", title: "Tester", kids: [1345, 5768], by: "ericagredo")
        XCTAssertGreaterThan(item.kids?.count ?? 0, 1)
    }
    
    func testTypeOfItem(){
        let vm = StoryViewModel()
        Task{
            await vm.convertToItems(ids: [30795846])
            
            XCTAssertEqual(vm.items.first?.type, "story")
        }
        
        
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
