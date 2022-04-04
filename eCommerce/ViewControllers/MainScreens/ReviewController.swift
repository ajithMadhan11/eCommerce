//
//  ReviewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/02/22.
//

import UIKit

class ReviewController: UIViewController {
    
    
    private var totalOne:Int?
    private var totalTwo:Int?
    private var totalThree:Int?
    private var totalFour:Int?
    private var totalFive:Int?
    private var totalStars:Int?
    var expandedIndexSet : Set<IndexPath> = []
    var reviews:[Comments] = []
    let sort = [Utils.sortReviews.favourable,Utils.sortReviews.critical]
    
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
    
            let totalStar = Utils.calculateTotalStars(product: product)
            let totalReview = Utils.calculateReview(product: product)
            reviews = product.itemsInComments
            totalOne = totalStar.0
            totalTwo = totalStar.1
            totalThree = totalStar.2
            totalFour = totalStar.3
            totalFive = totalStar.4
            totalStars = totalStar.0 + totalStar.1 + totalStar.2 + totalStar.3 + totalStar.4
            
            productName.text = product.title
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            productPrice.text = "$\(product.price)"
            offerDetails.text = "\(product.offer)% off"
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            offerPrice.text = "$\(String(format:"%.2f", product.price - offer))"
            self.starRating.text = "\(String(format:"%.1f",totalReview.0))"
            totalReviews.text = "out of 5"
        }
    }
    
    private var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var sheetTitle :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "User Ratings"
        txt.font = UIFont.boldSystemFont(ofSize: 22)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Natural Red Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .systemRed
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let reviewBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        btn.setTitle("Write a Review", for: .normal)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(writeNewReview), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc private func writeNewReview(){
        let vc = UINavigationController(rootViewController: WriteReviewVc())
        let vcc = vc.topViewController as! WriteReviewVc
        vcc.product = self.data
        present(vc, animated: true, completion: nil)
    }
    
    
    let sortBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
//        btn.addTarget(self, action: #selector(sortBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func sortBtnTappedAction(){
        let favour = UIAction(title: "Most Favourable", image: nil) { [weak self] (action) in

            self?.sortProducts(sort: .favourable)
         }

        let critical = UIAction(title: "Most Critical", image: nil) { [weak self] (action) in

            self?.sortProducts(sort: .critical)
         }
        
        let menu = UIMenu(title: "Sort By", options: .singleSelection, children: [favour,critical])
        
        sortBtn.menu = menu
        sortBtn.showsMenuAsPrimaryAction = true
        
       
        
    }
    
    
    private func sortProducts(sort:Utils.sortReviews){
        let sortedReview:[Comments]
        switch sort {
        case .favourable :
            sortedReview = reviews.sorted(by: { p1, p2 in
                return p1.star > p2.star
            })
            reviews.removeAll()
            reviews = sortedReview
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .critical:
            sortedReview = reviews.sorted(by: { p1, p2 in
                return p1.star < p2.star
            })
            reviews.removeAll()
            reviews = sortedReview
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        let attribute: NSMutableAttributedString =  NSMutableAttributedString(string:"$2.99")
        attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribute.length))
        txt.attributedText = attribute
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var starRating :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "4.3"
        txt.font = UIFont.boldSystemFont(ofSize: 55)
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var totalReviews:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "243 ratings"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var totalReviewsText:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "User Reviews (3)"
        txt.textColor = .black
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var barStack:UIStackView = {
        let barStack = UIStackView(frame: CGRect.zero)
        barStack.axis = .vertical
        barStack.alignment = .leading
        barStack.distribution = .fillEqually
        barStack.translatesAutoresizingMaskIntoConstraints = false
        return barStack
    }()
    
    private var emptyText:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "No comments yet!"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var ratiingStack:UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.alignment = .center
//        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var reviewStack:UIStackView = {
        let barStack = UIStackView(frame: CGRect.zero)
        barStack.axis = .horizontal
        barStack.alignment = .leading
        barStack.distribution = .equalSpacing
        barStack.translatesAutoresizingMaskIntoConstraints = false
        
        return barStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavbar()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 280.0
        
        ShopActions.commentsDelgate = self
        setupViews()
        
        checkForEmptyReviews()
        sortBtnTappedAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkTextColor()
    }
    
    private func checkForEmptyReviews(){
        if data?.itemsInComments.count == 0 {
            self.tableView.isHidden = true
            self.sortBtn.isHidden = true
            self.emptyText.isHidden = false
        }else {
            self.tableView.isHidden = false
            self.sortBtn.isHidden = false
            self.emptyText.isHidden = true
        }
    }
    
    private func calculatePercent(total:Int?,tStars:Int?) -> Float{
        guard let totalx = total else { return 0.0}
        guard let tStarsx = tStars else { return 0.0 }
        return Float(totalx) / Float(tStarsx)
    }
    
    private var tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    func setupViews(){
        view.addSubview(ProductImage)
        view.addSubview(productName)
        view.addSubview(offerPrice)
        view.addSubview(productPrice)
        view.addSubview(offerDetails)
        //        view.addSubview(totalReviewsText)
        
        let one = BarView(frame: CGRect.zero, index: 1, total: totalOne ?? 0, setProgress:calculatePercent(total: totalOne, tStars: totalStars), color: .systemGray)
        let two = BarView(frame: CGRect.zero, index: 2, total: totalTwo ?? 0, setProgress: calculatePercent(total: totalTwo, tStars: totalStars), color: .systemGray)
        let three = BarView(frame: CGRect.zero, index: 3, total: totalThree ?? 0, setProgress: calculatePercent(total: totalThree, tStars: totalStars), color: .systemGray)
        let four = BarView(frame: CGRect.zero, index: 4, total: totalFour ?? 0, setProgress: calculatePercent(total: totalFour, tStars: totalStars), color: .systemGray)
        let five = BarView(frame: CGRect.zero, index: 5, total: totalFive ?? 0, setProgress: calculatePercent(total: totalFive, tStars: totalStars), color: .systemGray)
        
        barStack.addArrangedSubview(five)
        barStack.addArrangedSubview(four)
        barStack.addArrangedSubview(three)
        barStack.addArrangedSubview(two)
        barStack.addArrangedSubview(one)
        barStack.clipsToBounds = true
        
        ratiingStack.addArrangedSubview(starRating)
        ratiingStack.addArrangedSubview(totalReviews)
        ratiingStack.clipsToBounds = true
        
        reviewStack.addArrangedSubview(ratiingStack)
        reviewStack.addArrangedSubview(barStack)
        reviewStack.clipsToBounds = true
        view.addSubview(reviewStack)
        
        view.addSubview(reviewBtn)
        view.addSubview(sortBtn)
        view.addSubview(emptyText)
        emptyText.isHidden = true
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        NSLayoutConstraint.activate([
            
            ProductImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            ProductImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            ProductImage.widthAnchor.constraint(equalToConstant: 50),
            ProductImage.heightAnchor.constraint(equalToConstant: 50),
            
            productName.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            offerPrice.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            offerPrice.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            productPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor,constant: 10),
            
            offerDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            offerDetails.leadingAnchor.constraint(equalTo: productPrice.trailingAnchor,constant: 5),
            
            
            five.widthAnchor.constraint(equalTo: view.widthAnchor),
            five.heightAnchor.constraint(equalToConstant: 7),
            
            four.widthAnchor.constraint(equalTo: view.widthAnchor),
            four.heightAnchor.constraint(equalToConstant: 7),
            
            three.widthAnchor.constraint(equalTo: view.widthAnchor),
            three.heightAnchor.constraint(equalToConstant: 7),
            
            two.widthAnchor.constraint(equalTo: view.widthAnchor),
            two.heightAnchor.constraint(equalToConstant: 7),
            
            one.widthAnchor.constraint(equalTo: view.widthAnchor),
            one.heightAnchor.constraint(equalToConstant: 7),
            
            barStack.widthAnchor.constraint(equalToConstant: 280),
            barStack.heightAnchor.constraint(equalToConstant: 70),
            
            ratiingStack.heightAnchor.constraint(equalToConstant: 70),
            
            reviewStack.topAnchor.constraint(equalTo: ProductImage.bottomAnchor,constant: 10),
            reviewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            reviewStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
//            reviewStack.widthAnchor.constraint(equalToConstant: 80),
            
            reviewBtn.topAnchor.constraint(equalTo: reviewStack.bottomAnchor,constant: 20),
            reviewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            
            sortBtn.topAnchor.constraint(equalTo: reviewStack.bottomAnchor,constant: 20),
            sortBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            tableView.topAnchor.constraint(equalTo: reviewBtn.bottomAnchor,constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
            
            emptyText.topAnchor.constraint(equalTo: reviewBtn.bottomAnchor,constant: 10),
            emptyText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
           checkTextColor()
        }
    
    private func checkTextColor(){
        if traitCollection.userInterfaceStyle == .dark {
            self.starRating.textColor = .systemGray
        }
        else {
            self.starRating.textColor = .black
        }
    }
    
    private func setupNavbar(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "Product Ratings & Reviews"
    }
    
}

extension ReviewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.itemsInComments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.data = reviews[indexPath.row]
        if expandedIndexSet.contains(indexPath) {
            cell.reviewDesc.numberOfLines = 0
            cell.reviewTitle.numberOfLines = 0
        } else {
            cell.reviewDesc.numberOfLines = 3
            cell.reviewTitle.numberOfLines = 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 15

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10  
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}

extension ReviewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(expandedIndexSet.contains(indexPath)){
            expandedIndexSet.remove(indexPath)
        } else {
            expandedIndexSet.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

extension ReviewController:reloadCommentsDelegate {
    func reloadCommentsTable() {
        DispatchQueue.main.async { [weak self] in
            self?.reviews = self?.data?.itemsInComments ?? []
            self?.tableView.reloadData()
            self?.reviewBtn.isHidden = true
            self?.checkForEmptyReviews()
            
        }
    }
}
