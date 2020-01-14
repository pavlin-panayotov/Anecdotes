//
//  Dropdown.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 9.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class Dropdown: NibView {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var textField: UITextField!
	@IBOutlet private weak var contentStackView: UIStackView!
	
	private var hasSelectedItem = false
	private lazy var picker: UIPickerView = {
		let picker = UIPickerView()
		picker.dataSource = self
		picker.delegate = self
		return picker
	}()
	
	var options: [String] = [] {
		didSet {
			optionsChanged()
		}
	}
	
	var title: String? {
		get { titleLabel.text }
		set { titleLabel.text = newValue }
	}
	
	var placeholder: String? {
		get { textField.placeholder }
		set { textField.placeholder = newValue }
	}
	
	// Default `5`.
	var subviewsSpacing: CGFloat {
		get { contentStackView.spacing }
		set { contentStackView.spacing = newValue }
	}
	
	var selectedOptionIndex: Int? {
		guard hasSelectedItem else {
			return nil
		}
		
		return picker.selectedRow(inComponent: 0)
	}
	
	var selectedOption: String? {
		guard let selectedOptionIndex = selectedOptionIndex else {
			return nil
		}
		
		return options[safe: selectedOptionIndex]
	}
	
	// MARK: - Overrides
	override func initialSetup() {
		super.initialSetup()
		
		subviewsSpacing = 5
		setupTextField()
	}
	
	// MARK: - Private
	private func setupTextField() {
		textField.delegate = self
		textField.inputView = picker
		textField.tintColor = .clear
	}
	
	private func optionsChanged() {
		picker.reloadAllComponents()
	}
}

// MARK: - UIPickerViewDataSource
extension Dropdown: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(
		_ pickerView: UIPickerView,
		numberOfRowsInComponent component: Int) -> Int {
		
		return options.count
	}
}

// MARK: - UIPickerViewDelegate
extension Dropdown: UIPickerViewDelegate {
	func pickerView(
		_ pickerView: UIPickerView,
		titleForRow row: Int,
		forComponent component: Int) -> String? {
		
		return options[safe: row]
	}
	
	func pickerView(
		_ pickerView: UIPickerView,
		didSelectRow row: Int,
		inComponent component: Int) {
		
		textField.text = options[safe: row]
	}
}

extension Dropdown: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		hasSelectedItem = true
		textField.text = selectedOption
	}
}
