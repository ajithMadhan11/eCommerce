//
//  ProductDescriptionViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 19/02/22.
//

import UIKit

class ProductDescriptionViewController: UIViewController {
    
    var expandedIndexSet:Set<IndexPath> = []
    
    var currentLikeStatus:Bool = false
    var bookMark:UIImage = UIImage(systemName: "bookmark")!
    
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productName.text = product.title
            self.productPrice.text = "$\(product.price)"
            self.offerDetails.text = "\(product.offer)% off"
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            self.stepper.currentValue = Int(product.quantitiesSelected)
            let totalReview = Utils.calculateReview(product: product)
            self.offerPrice.text = "$\(String(format:"%.2f", product.price - offer))"
            self.starRating.text = "\(String(format:"%.1f", totalReview.0))"
            self.reviewCount.setTitle("\(totalReview.1) reviews", for: .normal)
        }
    }
    
    
    private var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .systemRed
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        let attribute: NSMutableAttributedString =  NSMutableAttributedString(string:"$2.99")
        attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribute.length))
        txt.attributedText = attribute
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var addTocartBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.title = "Add"
        config.buttonSize = .medium
        config.background.backgroundColor = .systemBackground
        config.baseForegroundColor = .systemRed
        config.background.strokeColor = .systemGray4
        btn.configuration = config
        btn.addTarget(self, action: #selector(addToCartBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Natural Red Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var stepper:Stepper = {
        let stepper = Stepper(frame: CGRect.zero )
        stepper.clipsToBounds = true
        stepper.isHidden = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private var quantityDetails :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "1kg,Price"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var reviewCount :UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("out of 5", for: .normal)
        btn.tintColor = .systemGray
        btn.addTarget(self, action: #selector(showAllReviews), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var starRating :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "4.3"
        txt.font = UIFont.boldSystemFont(ofSize: 30)
        txt.textColor = .black
        
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var tableview:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(DescriptiontableViewCell.self, forCellReuseIdentifier: "TableCell")
        tableView.register(SimilarHeaderCell.self,forCellReuseIdentifier: SimilarHeaderCell.identifier)
        tableView.register(SimilarProductsTableCell.self, forCellReuseIdentifier: SimilarProductsTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.addSubview(ProductImage)
        view.addSubview(productName)
        view.addSubview(quantityDetails)
        view.addSubview(productPrice)
        view.addSubview(tableview)
        view.addSubview(addTocartBtn)
        view.addSubview(offerPrice)
        view.addSubview(offerDetails)
        view.addSubview(stepper)
        view.addSubview(starRating)
        view.addSubview(reviewCount)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAllReviews))
        starRating.isUserInteractionEnabled = true
        starRating.addGestureRecognizer(tap)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stepper.delegate = self
        setupNavbar()
        ShopActions.cartCollectionDelegate = self
        ShopActions.reloadBookMarksDelegate = self
        checkupFavandCart()
        self.tableview.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        reloadCollection()
        
        if Utils.isProductAddedToAnyList(product: data!) {
            bookMark = UIImage(systemName: "bookmark.fill")!
        }
        let barBtn = UIBarButtonItem(image: bookMark, style: .plain, target: self, action: #selector(addToListBtnTapped))
        self.navigationItem.rightBarButtonItem = barBtn
        checkTextColor()
    }
    
    
    private func checkupFavandCart(){
        for product in UserData.user?.itemsInCart ?? [] {
            if product.id == data?.id {
                self.addTocartBtn.isHidden = true
                self.stepper.isHidden = false
                self.stepper.currentValue = Int(self.data?.quantitiesSelected ?? 0)
                return
            }
        }
        self.addTocartBtn.isHidden = false
        self.stepper.isHidden = true
    }
    
    func reloadCollection(){
        if let cell = tableview.cellForRow(at: IndexPath(row: 2, section: 0)) as? SimilarProductsTableCell {
           cell.collectionView.reloadData()
        }
    }
    
    @objc func addToCartBtnTapped(){
        stepper.currentValue = 1
        guard let product = data else{return}
        self.stepper.isHidden = false
        self.addTocartBtn.isHidden = true
        ShopActions.addToCart(product: product)
    }
    
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = data?.title ?? "Product Details"
    }
    
    @objc func addToListBtnTapped(){
        let vc = UINavigationController(rootViewController: SelectCollectionVC())
        let vcc = vc.topViewController as! SelectCollectionVC
        vcc.product = self.data
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(),.large()]
            sheet.preferredCornerRadius = 10
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc func showAllReviews(){
        let vc = ReviewController()
        vc.data = self.data
        if Utils.isBroughtByUser(product: data!) {
            vc.reviewBtn.isHidden = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            ProductImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProductImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            ProductImage.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.30),
            
            productName.topAnchor.constraint(equalTo: ProductImage.bottomAnchor,constant: 10),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            offerDetails.topAnchor.constraint(equalTo: ProductImage.bottomAnchor,constant: 15),
            offerDetails.leadingAnchor.constraint(equalTo: productName.trailingAnchor,constant: 10),
            
            quantityDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            quantityDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            offerPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 10),
            offerPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            offerPrice.widthAnchor.constraint(equalToConstant: 60),
            
            productPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 17),
            productPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor,constant: 0),
            
            tableview.topAnchor.constraint(equalTo: addTocartBtn.bottomAnchor,constant: 5 ),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            starRating.topAnchor.constraint(equalTo: ProductImage.bottomAnchor,constant: 10),
            starRating.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            
            reviewCount.topAnchor.constraint(equalTo: starRating.bottomAnchor),
            reviewCount.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            addTocartBtn.topAnchor.constraint(equalTo: reviewCount.bottomAnchor,constant: 5),
            addTocartBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            addTocartBtn.heightAnchor.constraint(equalToConstant: 28),
            addTocartBtn.widthAnchor.constraint(equalToConstant: 100),
            
            stepper.topAnchor.constraint(equalTo: reviewCount.bottomAnchor,constant: 5),
            stepper.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            stepper.widthAnchor.constraint(equalToConstant: 100),
            stepper.heightAnchor.constraint(equalToConstant: 28),
            
        ])
    }
    
}

extension ProductDescriptionViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 200
        }else if indexPath.row == 1{
            return 20
        }
//        return UITableView.noIntrinsicMetric
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! DescriptiontableViewCell
            cell.myDes.pDescription.text = "\(data?.productDetails ?? "")\n\nNutrition Content (100g)\n\n \(data?.nutritions ?? "" )"
            if expandedIndexSet.contains(indexPath){
                cell.showDetailView()
            }else{
                cell.hideDetailView()
            }
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: SimilarProductsTableCell.identifier, for: indexPath) as! SimilarProductsTableCell
            cell.currentCategory = self.data?.category
            cell.currentProduct = self.data?.id
            cell.collectionView.delegate = self
            cell.collectionView.isPrefetchingEnabled = false
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SimilarHeaderCell.identifier) as! SimilarHeaderCell
            cell.data = "Similar Products"
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(expandedIndexSet.contains(indexPath)){
            expandedIndexSet.remove(indexPath)
        } else {
            expandedIndexSet.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! DescriptiontableViewCell
        cell.hideDetailView()
    }
}



extension ProductDescriptionViewController:StepperDelegate {
    func stepperChanged(value: Int) {
        guard let product = data else {return}
        if value == 0 {
            ShopActions.removeFromCart(product: product)
            self.addTocartBtn.isHidden = false
            self.stepper.isHidden = true
            return
        }
        ShopActions.StepperValuechanged(with:value,on:product)
    }
}



extension ProductDescriptionViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let vc = ProductDescriptionViewController()
        let newData = Utils.filterDataWithCategory(category: self.data!.category ?? "",except:self.data!.id)[indexPath.row]
        vc.data = newData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductDescriptionViewController:AddtoCartCollectionDelegate {
    
    func reloadProductCell(cell: UICollectionViewCell) {
        if let mycell = tableview.cellForRow(at: IndexPath(row: 2, section: 0)) as? SimilarProductsTableCell {
        let cellPath = mycell.collectionView.indexPath(for: cell)
        guard let cellPath = cellPath else {
            print("Cannot find the CellPath in collection")
            return
        }
            mycell.collectionView.reloadItems(at: [cellPath])
        }
    }
}

extension ProductDescriptionViewController:reloadBookMarkDelegate {
    func reloadBookMark() {
        if Utils.isProductAddedToAnyList(product: data!) {
            bookMark = UIImage(systemName: "bookmark.fill")!
        }else {
            bookMark = UIImage(systemName: "bookmark")!
        }
        let barBtn = UIBarButtonItem(image: bookMark, style: .plain, target: self, action: #selector(addToListBtnTapped))
        self.navigationItem.rightBarButtonItem = barBtn
    }
}


