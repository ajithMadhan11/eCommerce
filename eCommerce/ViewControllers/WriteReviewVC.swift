//
//  WriteReviewVC.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 26/03/22.
//

import Foundation
import UIKit

class WriteReviewVc:UIViewController {
    
    var currentStarRating:Int?
    
    var product:Product?
    
    let starData:[Utils.starValues] = [
        Utils.starValues(value: 1, label: .one),
        Utils.starValues(value: 2, label: .two),
        Utils.starValues(value: 3, label: .three),
        Utils.starValues(value: 4, label: .four),
        Utils.starValues(value: 5, label: .five)
    ]
    
    private let titleInput:UITextField = {
        let titleInput = UITextField(frame: CGRect.zero)
        titleInput.placeholder = "Title"
        titleInput.borderStyle = .none
        titleInput.font = UIFont.systemFont(ofSize: 16)
        titleInput.keyboardType = .alphabet
        titleInput.backgroundColor = .systemGray6
        titleInput.translatesAutoresizingMaskIntoConstraints = false
        return titleInput
    }()
    
    private let textView:UITextView = {
        let textBox = UITextView(frame: CGRect.zero)
        textBox.translatesAutoresizingMaskIntoConstraints = false
        textBox.autocorrectionType = .no
        textBox.text = "Review (Optional)"
        textBox.backgroundColor = .systemGray6
        textBox.textColor = .systemGray
        textBox.font = UIFont.preferredFont(forTextStyle: .body)
        textBox.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textBox
    }()
    
    private let mainStack:UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.distribution = .fill
        stack.alignment = .firstBaseline
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.title = "Write a Review"
        let applyBtn = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitBtnTapped))
        self.navigationItem.rightBarButtonItem = applyBtn
    }
    
    @objc func submitBtnTapped(){
        guard let title = titleInput.text,let desc = textView.text else { return }
        if title.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            let alert = UIAlertController(title: nil, message: "\nTitle cannot be empty\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if currentStarRating == nil {
            let alert = UIAlertController(title: nil, message: "\nPlease select a star rating\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        ShopActions.createNewComment(title: title, starRating: currentStarRating!, des: desc,product:product!)
        ShopActions.reloadComments()
        self.dismiss(animated: true, completion: nil)
    }
    
    let starCollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:WriteReviewVc.makeStarLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStack)
        titleInput.setLeftPaddingPoints(10)
        titleInput.setRightPaddingPoints(10)
        titleInput.delegate = self
        
        starCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        starCollectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier)
        starCollectionView.dataSource = self
        starCollectionView.delegate = self
        starCollectionView.translatesAutoresizingMaskIntoConstraints = false
        starCollectionView.backgroundColor = .systemGray6
        starCollectionView.allowsMultipleSelection = false
        starCollectionView.setContentHuggingPriority(.required, for: .vertical)
        
        mainStack.addArrangedSubview(starCollectionView)
        mainStack.addArrangedSubview(titleInput)
        mainStack.addArrangedSubview(textView)
        
        textView.delegate = self
        textView.resignFirstResponder()
        
        setupNavbar()
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleInput.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleInput.heightAnchor.constraint(equalToConstant: 50),
            
            textView.widthAnchor.constraint(equalTo: view.widthAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            starCollectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            starCollectionView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    
}

extension WriteReviewVc {
    static func makeStarLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let inset: CGFloat = 5
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let group:NSCollectionLayoutGroup
            
            group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitem: item, count: 5)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
//            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                    heightDimension: .absolute(30.0))
            
//            let header = NSCollectionLayoutBoundarySupplementaryItem(
//                layoutSize: headerSize,
//                elementKind: UICollectionView.elementKindSectionHeader,
//                alignment: .top)
            
//            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }
}

extension WriteReviewVc:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
        cell.selectedStar = starData[indexPath.row]
        return cell
    }
}

extension WriteReviewVc:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentStarRating = starData[indexPath.row].value
    }
    
}

extension WriteReviewVc:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 40
        }
}

extension WriteReviewVc:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Review (Optional)"  {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Review (Optional)"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 250
   }
    
}
