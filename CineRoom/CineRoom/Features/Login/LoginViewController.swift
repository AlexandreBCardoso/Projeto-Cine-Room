//
//  LoginViewController.swift
//  Cine Room
//
//  Created by Lucas Munho on 23/02/21.
//

import UIKit

class LoginViewController: UIViewController {
	
	// MARK: - IBOutlet
	@IBOutlet weak var loginImageView: UIImageView!
	@IBOutlet weak var emailtextField: UITextField!
	@IBOutlet weak var senhaTextField: UITextField!
	@IBOutlet weak var createAccountButton: UIButton!
	@IBOutlet weak var connectButton: UIButton!
	
	// MARK: - Variable
	let controller: LoginController = LoginController()
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configTextField()
		configButton()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.showSpinner()
		
		self.controller.addStateDidChangeListener { (success) in
			if success {
				self.performSegue(withIdentifier: "segueHome", sender: nil)
			}
			self.removeSpinner()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.controller.removeStateDidChangeListener()
	}
	
	
	// MARK: - Function	
	private func configTextField() {
		self.emailtextField.delegate = self
		self.senhaTextField.delegate = self
		self.senhaTextField.inputAccessoryView = self.senhaTextField.inputToolbar()
	}
	
	private func configButton() {
		self.createAccountButton.layer.cornerRadius	= 5
		self.connectButton.layer.cornerRadius 		 	= 5
	}
	
	
	// MARK: - IBAction
	@IBAction func tappedConectar(_ sender: UIButton) {
		
		if self.controller.validateLogin(emailTextField: emailtextField,
													passwordTextField: senhaTextField) {
			
			self.showSpinner()
			
			self.controller.signIn(email: emailtextField.text, password: senhaTextField.text) { (success) in
				if success {
					print("=== LOGIN FIREBASE")
					Utils.saveUserDefaults(value: self.emailtextField.text, key: "email")
					self.performSegue(withIdentifier: "segueHome", sender: nil)
				} else {
					print("=== erro LOGIN FIREBASE")
//					Alert.showWrongAlert(on: self)
					// TODO: Tratar como UIView Animation
					self.showAlertAnimation()
					
				}
				self.removeSpinner()
			}
			
		} else {
			print("Entrada errada")
			
			if !self.emailtextField.validateEmail() {
				self.emailtextField.shake()
			}
			if !self.senhaTextField.validatePassword() {
				self.senhaTextField.shake()
			}
		}
	}
}

// MARK: - Extension TextField
extension LoginViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}
