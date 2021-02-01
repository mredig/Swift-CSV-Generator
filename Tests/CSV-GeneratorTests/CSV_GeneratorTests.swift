//
//  CSV_GeneratorTests.swift
//  CSV GeneratorTests
//
//  Created by Michael Redig on 2/23/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import XCTest
@testable import CSV_Generator

class CSV_GeneratorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCSVGeneration() {
		let intendedResult = """
#haha stupid first line
foo,bar,wham,bam
9,1,"Commas, and ""double quotes"" and tigers! oh, my!",0
8,1,"Commas, and ""double quotes"" and tigers! oh, my!",1
7,1,"Commas, and ""double quotes"" and tigers! oh, my!",2
6,1,"Commas, and ""double quotes"" and tigers! oh, my!",3
5,1,"Commas, and ""double quotes"" and tigers! oh, my!",4
4,1,"Commas, and ""double quotes"" and tigers! oh, my!",5
3,1,"Commas, and ""double quotes"" and tigers! oh, my!",6
2,1,"Commas, and ""double quotes"" and tigers! oh, my!",7
1,1,"Commas, and ""double quotes"" and tigers! oh, my!",8
0,1,"Commas, and ""double quotes"" and tigers! oh, my!",9
"""
		let generator = CSVGenerator(with: ["foo", "bar", "wham", "bam"])
		generator.firstLine = "#haha stupid first line"
		
		for index in 0..<10 {
			let info = ["foo": String(9-index), "bar": String(1), "wham": "Commas, and \"double quotes\" and tigers! oh, my!", "bam": String(index)]
			generator.appendRow(with: info)
		}
		
		let csv = generator.generateCSV()
		XCTAssertTrue(intendedResult == csv)
	}
	
	func testNewlineEscape() {
		let intendedResult = """
foo,bar
"here is a ""line""
here is \"\"\"\"another\"\"\"\", same cell",pasta
macaroni and cheese,pizza!
"""
		let col1 = "foo"
		let col2 = "bar"
		let generator = CSVGenerator(with: [col1, col2])
		
		generator.appendRow(with: [col1: "here is a \"line\"\nhere is \"\"another\"\", same cell", col2: "pasta"])
		generator.appendRow(with: [col1: "macaroni and cheese", col2: "pizza!"])

		let csv = generator.generateCSV()
		XCTAssertTrue(intendedResult == csv, csv)
	}

}
