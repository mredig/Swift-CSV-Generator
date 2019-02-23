//
//  CSV Generator.swift
//  CSV Generator
//
//  Created by Michael Redig on 2/23/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

public class CSVGenerator {
	/**
	Sometimes CSV files have an additional line starting the file, typically commented out with a #, often containing meta data
	*/
	public var firstLine = ""
	private var columns = [CSVColumn]()
	public var separator = Separators.comma
	
	public enum Separators: String {
		case comma = ","
		case semicolon = ";"
		case tab = "\t"
		case space = " "
	}
	
	private class CSVColumn {
		let index: Int
		let title: String
		var data = [String]()
		
		init(index: Int, title: String) {
			self.index = index
			self.title = title
		}
	}
	
	/**
	Initialize the csv generator with titles for each column.
	
	- Parameter columnTitles: array of strings in order from left to right of column titles. Also establishes the number of columns for this instance
	*/
	init(with columnTitles: [String]) {
		for (index, title) in columnTitles.enumerated() {
			let column = CSVColumn(index: index, title: title)
			columns.append(column)
		}
	}
	
	/**
	Adds a row to the CSV file.
	
	- Parameter data: dictionary where key matches a column title and the value matches the value for this row, in that particular column. non matching keys are ignored
	*/
	public func appendRow(with data: [String: String]) {
		for column in columns {
			if let value = data[column.title] {
				column.data.append(value)
			} else {
				column.data.append("")
			}
		}
	}
	
	/**
	Generates a string formatted as a CSV file
	- Returns: String formatted as a CSV file
	*/
	public func generateCSV() -> String {
		
		//insert first line if it exists
		var rStr = ""
		if !firstLine.isEmpty {
			rStr = "\(firstLine)\n"
		}
		
		
		//set up columns
		for column in columns {
			var title = column.title
			title = escapeCharacters(in: title)
			rStr += title + separator.rawValue
		}
		rStr = String(rStr.dropLast()) //remove trailing comma, now that the row is finished
		rStr += "\n"
		
		//get total number of rows
		guard let count = columns.first?.data.count else { return rStr } //cant fail, actually
		
		//generate rows
		for index in 0..<count {
			for column in columns {
				var value = column.data[index]
				value = escapeCharacters(in: value)
				rStr += value + separator.rawValue
			}
			rStr = String(rStr.dropLast()) //remove trailing comma, now that the row is finished
			rStr += "\n"
		}
		rStr = String(rStr.dropLast()) //remove trailing newline, now that the document is finished
		return rStr
	}
	
	private func escapeCharacters(in value: String) -> String {
		var value = value
		if value.contains(separator.rawValue) {
			if value.contains("\"") {
				value = value.replacingOccurrences(of: "\"", with: "\"\"")
			}
			value = "\"\(value)\""
		}
		return value
	}
}
