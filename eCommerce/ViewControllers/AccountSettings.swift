//
//  AccountSettings.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 17/03/22.
//

import Foundation
import UIKit

class AccountSettingsVC:UIViewController {
    
    var UserDetails:User?{
        didSet {
            guard let UserDetails = UserDetails else {
                return
            }
            self.nameInput.text = UserDetails.name
            self.emailInput.text = UserDetails.email
            self.phoneInput.text = UserDetails.phone
            self.addressInput.text = UserDetails.address
            self.userImage.image = UIImage(data: UserDetails.userImage!,scale: 0.1)
        }
    }
    
    private var userImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "defaultUser")
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var editBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Change profile picture", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    
    private let name:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Name"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.setContentHuggingPriority(.required, for: .horizontal)
        txt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
        txt.font = UIFont.systemFont(ofSize: 18)
        return txt
    }()
    
    private let nameInput:UITextField = {
        let nameInput = UITextField(frame: CGRect.zero)
        nameInput.placeholder = "User name"
        nameInput.font = UIFont.systemFont(ofSize: 16)
        nameInput.keyboardType = .alphabet
        nameInput.borderStyle = UITextField.BorderStyle.roundedRect
        nameInput.clearButtonMode = UITextField.ViewMode.whileEditing
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        return nameInput
    }()
    
    private let email:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Email"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.setContentHuggingPriority(.required, for: .horizontal)
        txt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
        txt.font = UIFont.systemFont(ofSize: 18)
        return txt
    }()
    
    private let emailInput:UITextField = {
        let emailInput = UITextField(frame: CGRect.zero)
        emailInput.placeholder = "User email"
        emailInput.font = UIFont.systemFont(ofSize: 16)
        emailInput.keyboardType = .emailAddress
        emailInput.borderStyle = UITextField.BorderStyle.roundedRect
        emailInput.clearButtonMode = UITextField.ViewMode.whileEditing
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        return emailInput
    }()
    
    private let phone:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Phone"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.setContentHuggingPriority(.required, for: .horizontal)
        txt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
        txt.font = UIFont.systemFont(ofSize: 18)
        return txt
    }()
    
    private let phoneInput:UITextField = {
        let phoneInput = UITextField(frame: CGRect.zero)
        phoneInput.placeholder = "User phone number"
        phoneInput.font = UIFont.systemFont(ofSize: 16)
        phoneInput.keyboardType = .numberPad
        phoneInput.borderStyle = UITextField.BorderStyle.roundedRect
        phoneInput.clearButtonMode = UITextField.ViewMode.whileEditing
        phoneInput.translatesAutoresizingMaskIntoConstraints = false
        return phoneInput
    }()
    
    private let address:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Address"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.setContentHuggingPriority(.required, for: .horizontal)
        txt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
        txt.font = UIFont.systemFont(ofSize: 18)
        return txt
    }()
    
    private let addressInput:UITextField = {
        let addressInput = UITextField(frame: CGRect.zero)
        addressInput.placeholder = "User address"
        addressInput.font = UIFont.systemFont(ofSize: 16)
        addressInput.keyboardType = .default
        addressInput.borderStyle = UITextField.BorderStyle.roundedRect
        addressInput.clearButtonMode = UITextField.ViewMode.whileEditing
        addressInput.translatesAutoresizingMaskIntoConstraints = false
        return addressInput
    }()
    
    private let addressStack:UIStackView = {
        let ns = UIStackView(frame: CGRect.zero)
        ns.axis = .horizontal
        ns.spacing = 8
        ns.distribution = .fillProportionally
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    
    private let phoneStack:UIStackView = {
        let ns = UIStackView(frame: CGRect.zero)
        ns.axis = .horizontal
        ns.spacing = 8
        ns.distribution = .fillProportionally
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    
    private let nameStack:UIStackView = {
        let ns = UIStackView(frame: CGRect.zero)
        ns.axis = .horizontal
        ns.spacing = 8
        ns.distribution = .fillProportionally
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    private let emailStack:UIStackView = {
        let ns = UIStackView(frame: CGRect.zero)
        ns.axis = .horizontal
        ns.spacing = 8
        ns.distribution = .fillProportionally
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    private let applyBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.title = "Apply changes"
        config.buttonSize = .large
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.background.backgroundColor = .systemGreen
        config.baseForegroundColor = .white
        btn.configuration = config
        btn.addTarget(self, action: #selector(applyBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func applyBtnTapped(){
        guard let name = nameInput.text,let email = emailInput.text,let phone = phoneInput.text,let address = addressInput.text else { return }
        if !email.isValidEmail(){
            let alert = UIAlertController(title: "Wrong Email", message: "\nIt seems like you have entered a wrong email please check it try again!\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if !name.isValidName(){
            let alert = UIAlertController(title: "Wrong Name", message: "\nIt seems like you have entered a wrong Name please check it try again!\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phone.trimmingCharacters(in: .whitespacesAndNewlines) == "" || address.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let alert = UIAlertController(title: "Fields are emplty!", message: "\nPlease fill all fields before submitting\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        ShopActions.saveUserDetails(name: name, email: email, phone: phone, address: address)
        let alert = UIAlertController(title: "User details updated!", message: "\nUser Details has been updated sucessfully!\n", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            ShopActions.reloadAccountSections()
          }))
        
        present(alert, animated: true, completion:nil)
        
    }
    
    @objc func editBtnTapped(){
        
           let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.getImage(source: .camera)
           }))

           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
               self.getImage(source: .photoLibrary)
           }))

           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.popoverPresentationController?.sourceView = self.view
           self.present(alert, animated: true, completion: nil)
    }

    
    func getImage(source:UIImagePickerController.SourceType){
        let vc = UIImagePickerController()
        vc.sourceType = source
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(userImage)
        view.addSubview(editBtn)
        view.addSubview(nameStack)
        nameStack.addArrangedSubview(name)
        nameStack.addArrangedSubview(nameInput)
        
        view.addSubview(emailStack)
        emailStack.addArrangedSubview(email)
        emailStack.addArrangedSubview(emailInput)
        
        view.addSubview(phoneStack)
        phoneStack.addArrangedSubview(phone)
        phoneStack.addArrangedSubview(phoneInput)
        
        view.addSubview(addressStack)
        addressStack.addArrangedSubview(address)
        addressStack.addArrangedSubview(addressInput)
        
        view.addSubview(applyBtn)
        
        hideKeyboardWhenTappedAround()
        setupLayout()
        setupNavbar()
        
        nameInput.delegate = self
        emailInput.delegate = self
        phoneInput.delegate = self
        addressInput.delegate = self
    }
    
    private func setupNavbar(){
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "Edit User Details"
        let closeBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeBtnTapped))
        self.navigationItem.rightBarButtonItem = closeBtn
    }
    
    @objc func closeBtnTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editBtn.topAnchor.constraint(equalTo: userImage.bottomAnchor,constant: 5),
            editBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameStack.topAnchor.constraint(equalTo: editBtn.bottomAnchor,constant: 10),
            nameStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            nameStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            emailStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor,constant: 15),
            emailStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            emailStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            phoneStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor,constant: 15),
            phoneStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            phoneStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            addressStack.topAnchor.constraint(equalTo: phoneStack.bottomAnchor,constant: 15),
            addressStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            addressStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            applyBtn.topAnchor.constraint(equalTo: addressStack.bottomAnchor,constant: 20),
            applyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyBtn.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.9)
        ])
    }
    
}

extension AccountSettingsVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {return}
        guard let pngImage = image.pngData()
        else{
            print("Error Saving Image")
            return
        }
        ShopActions.saveProfileImage(image: pngImage)
        self.userImage.image = image
    }
}

extension AccountSettingsVC:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let currentText = textField.text ?? ""
        switch textField {
        case nameInput:
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 20
        case emailInput:
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        case phoneInput:
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
        case addressInput:
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 60
        default:
            return true
        }
    }
}
