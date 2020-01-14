//
//  CreateAnecdoteViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 14.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class CreateAnecdoteViewController: ScrollViewController {
	
	private let categoryPicker = Dropdown()
	private let authorTextField = UITextField()
	private let anecdoteTextView = UITextView()
	
	private lazy var keyboardBlockingGesture: UITapGestureRecognizer = {
		let tapGestureRecognizer = UITapGestureRecognizer()
		tapGestureRecognizer.addTarget(self, action: #selector(keyboardBlockingViewTapped))
		return tapGestureRecognizer
	}()
	
	private lazy var keyboardBlockingView: UIView = {
		let blockingView = UIView()
		blockingView.addGestureRecognizer(keyboardBlockingGesture)
		return blockingView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Създаване на анекдот"
		scrollSubviewsInsets = UIEdgeInsets(vertical: 10, horizontal: 20)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Създай",
			style: .plain,
			target: self,
			action: #selector(createAnecdote)
		)
		
		setupCategoryPicker()
		setupAuthorTextField()
		setupAnecdoteTextView()
		
		addScrollSubviews(
			categoryPicker,
			authorTextField,
			anecdoteTextView
		)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIViewController.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIViewController.keyboardWillHideNotification,
			object: nil
		)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		NotificationCenter.default.removeObserver(
			self,
			name: UIViewController.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.removeObserver(
			self,
			name: UIViewController.keyboardWillHideNotification,
			object: nil
		)
	}
	
	// MARK: - Actions
	@objc
	private func createAnecdote() {
		guard
			let author = authorTextField.text,
			author.isEmpty == false,
			let categoryString = categoryPicker.selectedOption,
			let category = DataManager.shared.categories.first(where: { $0.name == categoryString }),
			let anecdoteText = anecdoteTextView.text,
			anecdoteText.isEmpty == false
			else {
				showEnterAllDataAlert()
				return
		}
		
		let anecdote = Anecdote(text: anecdoteText, author: author)
		category.append(anecdote: anecdote)
		DataManager.shared.saveCategories()
		navigationController?.popViewController(animated: true)
		
		showSuccessAlert()
	}
	
	@objc
	private func keyboardBlockingViewTapped(_ sender: Any) {
		hideKeyboard()
	}
	
	// MARK: - Private
	private func setupCategoryPicker() {
		categoryPicker.title = "Категория"
		categoryPicker.placeholder = "Избери"
		categoryPicker.options = [""] + DataManager.shared.categories.map { $0.name }
	}
	
	private func setupAuthorTextField() {
		authorTextField.placeholder = "Автор"
		authorTextField.delegate = self
		authorTextField.borderStyle = .roundedRect
		authorTextField.returnKeyType = .next
	}
	
	private func setupAnecdoteTextView() {
		anecdoteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		anecdoteTextView.layer.borderWidth = 1
		anecdoteTextView.layer.cornerRadius = 4
		anecdoteTextView.layer.borderColor = UIColor.separator.cgColor
		anecdoteTextView.font = authorTextField.font
	}
	
	private func showEnterAllDataAlert() {
		let alert = UIAlertController(
			title: "Грешка",
			message: "Въведи всички полета",
			preferredStyle: .alert
		)
		
		alert.addAction(UIAlertAction(title: "Окей", style: .cancel, handler: nil))
		
		present(alert, animated: true)
	}
	
	private func showSuccessAlert() {
		let alert = UIAlertController(
			title: "Съобщение",
			message: "Анекдотът е добавен успешно",
			preferredStyle: .alert
		)
		
		alert.addAction(UIAlertAction(title: "Окей", style: .cancel, handler: nil))
		
		navigationController?.present(alert, animated: true)
	}
	
	private func showKeyboardBlockingView() {
		hideKeyboardBlockingView()
		
		view.addFullSizedSubview(
			keyboardBlockingView,
			bottomPadding: scrollView.contentInset.bottom
		)
	}
	
	private func hideKeyboardBlockingView() {
		keyboardBlockingView.removeFromSuperview()
	}
	
	// MARK: - Notifications
	@objc
	private func keyboardWillShow(_ notificaiton: Notification) {
		guard
			let rawKeyboardFrame = notificaiton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey],
			let keyboardFrame = (rawKeyboardFrame as? NSValue)?.cgRectValue
			else {
				return
		}
		
		scrollView.contentInset.bottom = keyboardFrame.height - (tabBarController?.tabBar.bounds.height ?? 0)
		scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
		showKeyboardBlockingView()
	}
	
	@objc
	private func keyboardWillHide(_ notificaiton: Notification) {
		scrollView.contentInset.bottom = 0
		scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
		hideKeyboardBlockingView()
	}
}

// MARK: - UITextFieldDelegate
extension CreateAnecdoteViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		anecdoteTextView.becomeFirstResponder()
		return true
	}
}
