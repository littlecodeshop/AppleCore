//
//  AppleCoreTests.swift
//  AppleCoreTests
//
//  Created by LittleCodeShop on 05/03/2023.
//

import XCTest
@testable import AppleCore

final class AppleCoreTests: XCTestCase {
    
   

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReadFromRom() {
        //GIVEN
        let appleone = AppleOne()
        //When
        let d8 = appleone.read(0xFF00)
        let ff17 = appleone.read(0xFF17)
        let last = appleone.read(0xFFFE)
        //Then
        XCTAssertEqual(d8, 0xD8)
        XCTAssertEqual(ff17, 0xC8)
        XCTAssertEqual(last, 0x0)
        
    }
    
    func testReadWriteFromRam() {
        //GIVEN
        let appleone = AppleOne()
       
        //When
        appleone.write(0x0, value: 0xBB)
        let bb = appleone.read(0x0)
        //Then
        XCTAssertEqual(bb, 0xBB)
        
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
