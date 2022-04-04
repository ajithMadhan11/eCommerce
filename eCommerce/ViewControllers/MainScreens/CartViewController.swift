//
//  CartViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class CartViewController: UIViewController,CartViewControllerDelegate {
    
    var gTotal:Double?
    
    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private var bagTotal :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Bag total"
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var bagTotalValue :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$18.99"
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var deliveryTxt :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Delivery charges"
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var deliveryValue :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "+ $1.99"
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var taxtxt :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "GST"
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var taxValue :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "+ $4.99"
        txt.textColor = .systemRed
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var totalTxt :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Grand Total"
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var totalValue :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$24.99"
        txt.textColor = .systemGreen
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "emptycart")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Your cart is Empty 😔"
        txt.textColor = .systemGray
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private let checkOutBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "cart")
        config.title = "Checkout"
        config.buttonSize = .large
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.background.backgroundColor = .systemGreen
        config.baseForegroundColor = .white
        btn.configuration = config
        btn.addTarget(self, action: #selector(checkOutProducts), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func checkOutProducts(){
        let viewControllerToPresent = CheckOutPageViewController()
        viewControllerToPresent.grandTotal = gTotal
        viewControllerToPresent.data = UserData.user
        viewControllerToPresent.grandTotal = gTotal
        self.navigationController?.pushViewController(viewControllerToPresent, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        ShopActions.delegate = self
        ShopActions.stepperDelegate = self
        setupNavbar()
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.addSubview(bagTotal)
        view.addSubview(bagTotalValue)
        view.addSubview(deliveryTxt)
        view.addSubview(deliveryValue)
        view.addSubview(taxtxt)
        view.addSubview(taxValue)
        view.addSubview(totalTxt)
        view.addSubview(totalValue)
        view.addSubview(checkOutBtn)
        calculateBagTotal()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        let clear = UIBarButtonItem(title: "Clear cart", style: .done, target: self, action: #selector(clearBtnTapped))
        clear.tintColor = .systemRed
        navigationItem.rightBarButtonItems = [clear]
        if UserData.user?.itemsInCart.count == 0 {
            navigationItem.rightBarButtonItems = []
        }
        
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "My Cart"
    }
    
    
    @objc func clearBtnTapped(){
        ShopActions.removeAllFromCart(allproduct: UserData.user?.itemsInCart ?? [] )
        let alert = UIAlertController(title: "Cart cleared", message: "All items in your Cart is cleared sucessfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        navigationItem.rightBarButtonItems = []
    }
    
    private func calculateBagTotal(){
        var total:Double = 0
        var tax:Double
        
        
        for product in UserData.user?.itemsInCart ?? [] {
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            total += Double((product.quantitiesSelected)) * (product.price - offer)
        }
        
        tax = total * 0.18
        gTotal = total + tax + 1.99
        if total == 0 {
            self.deliveryValue.text = "+ $0.00"
            gTotal = total + tax
            showEmptyCart()
        }else {
            self.deliveryValue.text = "+ $1.99"
            removeEmptyCart()
        }
        self.bagTotalValue.text = "$\(String(format:"%.2f", total))"
        self.taxValue.text = "+ $\(String(format:"%.2f", tax))"
        self.totalValue.text = "$\(String(format:"%.2f", gTotal!))"
    }
    
    private func showEmptyCart(){
        view.addSubview(img)
        view.addSubview(txt)
        checkOutBtn.isEnabled = false
        setupEmptyLayout()
    }
    
    private func removeEmptyCart(){
        img.removeFromSuperview()
        txt.removeFromSuperview()
        checkOutBtn.isEnabled = true
    }
    
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bagTotal.topAnchor,constant: -10),
            //            tableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.63),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bagTotal.bottomAnchor.constraint(equalTo: deliveryTxt.topAnchor,constant: -10),
            bagTotal.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            bagTotalValue.bottomAnchor.constraint(equalTo: deliveryTxt.topAnchor,constant: -10),
            bagTotalValue.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -22),
            
            deliveryTxt.bottomAnchor.constraint(equalTo: taxtxt.topAnchor,constant: -10),
            deliveryTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            deliveryValue.bottomAnchor.constraint(equalTo: taxtxt.topAnchor,constant: -10),
            deliveryValue.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -22),
            
            taxtxt.bottomAnchor.constraint(equalTo: totalTxt.topAnchor,constant: -10),
            taxtxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            taxValue.bottomAnchor.constraint(equalTo: totalTxt.topAnchor,constant: -10),
            taxValue.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -22),
            
            totalTxt.bottomAnchor.constraint(equalTo: checkOutBtn.topAnchor,constant: -10),
            totalTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            
            totalValue.bottomAnchor.constraint(equalTo: checkOutBtn.topAnchor,constant: -10),
            totalValue.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -22),
            
            checkOutBtn.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.93),
            checkOutBtn.heightAnchor.constraint(equalToConstant: 50),
            checkOutBtn.topAnchor.constraint(equalTo: totalTxt.bottomAnchor,constant: 10),
            checkOutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkOutBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            
            
        ])
        
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
}



extension CartViewController :UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.user?.itemsInCart.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as! CartCell
        
        cell.data = UserData.user?.itemsInCart[indexPath.row]
       
        cell.removefromCartBtnAction = { (product) in
            ShopActions.removeFromCart(product: product)
        }
        
        return cell
    }
    
}

extension CartViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    func reloadCartData() {
        self.tableView.reloadData()
        calculateBagTotal()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove", handler: {_,_,_ in
            guard let product = UserData.user?.itemsInCart[indexPath.row] else {return}
            ShopActions.removeFromCart(product: product)
        })
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
}

extension CartViewController:StepperInCartDelegate {
    func stepperChanged() {
        calculateBagTotal()
    }
}

