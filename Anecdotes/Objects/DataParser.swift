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
	
	init?(fileUrl: URL) {
		guard let xmlParser = XMLParser(contentsOf: fileUrl) else {
			return nil
		}
		
		self.xmlParser = xmlParser
		
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
		let element = parsingData.last
		
		if let anecdote = element as? RawAnecdote {
			anecdote.text += string
		}
	}
	
	func parserDidEndDocument(_ parser: XMLParser) {
		completion?(parsedData.compactMap({ Category(rawModel: $0) }))
		clearState()
	}
}
