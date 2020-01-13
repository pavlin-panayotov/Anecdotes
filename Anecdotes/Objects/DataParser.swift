//
//  DataParser.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 13.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class DataParser: NSObject, XMLParserDelegate {
	
	private let xmlParser: XMLParser
	private(set) var parsedData: [RawCategory] = []
	private var parsingData: [RawXmlObjectProtocol] = []
	private var completion: GetItemClosure<[Category]>?
	
	init?(fileName: String) {
		guard
			let path = Bundle.main.path(forResource: "anecdotes", ofType: "xml"),
			let xmlString = try? String(contentsOfFile: path, encoding: .utf8),
			let xmlData = xmlString.data(using: .utf8)
			else {
				return nil
		}
		
		self.xmlParser = XMLParser(data: xmlData)
		
		super.init()
		
		self.xmlParser.delegate = self
	}
	
	// MARK: - Private
	private func clearState() {
		completion = nil
		parsedData = []
		parsingData = []
	}
	
	// MARK: - Public
	func parse(completion: @escaping GetItemClosure<[Category]>) {
		self.completion = completion
		xmlParser.parse()
	}
}

// MARK: - XMLParserDelegate
extension DataParser {
	func parser(
		_ parser: XMLParser,
		didStartElement elementName: String,
		namespaceURI: String?,
		qualifiedName qName: String?,
		attributes attributeDict: [String : String] = [:]) {
		
		switch elementName {
		case "category":
			let category = RawCategory(attributeDict: attributeDict)
			parsingData.append(category)
			parsedData.append(category)
			
		case "anecdote":
			parsingData.append(RawAnecdote(attributeDict: attributeDict))
			
		case "categories":
			break
			
		default:
			break
		}
	}
	
	func parser(
		_ parser: XMLParser,
		didEndElement elementName: String,
		namespaceURI: String?,
		qualifiedName qName: String?) {
		
		let element = parsingData.last
		
		if element is RawCategory {
			// categories are added on "start parsing element"
		} else if let anecdote = element as? RawAnecdote {
			parsedData.last?.append(anecdote: anecdote)
		}
		
		if parsingData.isEmpty == false {
			parsingData.removeLast()
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		let trimmedString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
		guard trimmedString.isEmpty == false else {
			return
		}
		
		let element = parsingData.last
		
		if let anecdote = element as? RawAnecdote {
			anecdote.text += trimmedString
		}
	}
	
	func parserDidEndDocument(_ parser: XMLParser) {
		completion?(parsedData.compactMap({ Category(rawModel: $0) }))
		clearState()
	}
}
