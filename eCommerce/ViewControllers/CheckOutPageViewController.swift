//
//  CheckOutPageViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/02/22.
//

import UIKit
import Razorpay

class CheckOutPageViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    var grandTotal:Double?
    var paymentOptions:[Utils.paymentMethods] = [Utils.paymentMethods.COD,Utils.paymentMethods.PAYNOW]
    var selectedPaymentType:Utils.paymentMethods = Utils.paymentMethods.COD
    var razorpay: RazorpayCheckout!
    var couponAppliedStatus:Bool?
    
    var data:User? {
        didSet{
            guard let user = data else {return}
            self.address.text = user.address
            self.name.text = user.name
            self.phone.text = user.phone
            self.total.text = "$\(String(format:"%.2f", grandTotal!))"
        }
    }
    
    var addressTxt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Delivery address"
        txt.font = UIFont.boldSystemFont(ofSize:16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let editBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("edit", for: .normal)
        btn.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let applyBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Apply", for: .normal)
        btn.addTarget(self, action: #selector(couponApplied), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let changePayBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("change", for: .normal)
        btn.addTarget(self, action: #selector(changePayBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var address:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "42,Andal nagar , near CSI church Mahalingapuram Pollachi - 642002"
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let phoneTxt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Contact details"
        txt.font = UIFont.boldSystemFont(ofSize:16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let phone:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "7448308493"
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let name:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "userName"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let checkoutMethodTxt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Payment method"
        txt.font = UIFont.boldSystemFont(ofSize:16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let checkoutMethod:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "cash on delivery"
        txt.textColor = .systemPink
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let couponText:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Do you have a coupon code?"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let couponInput:UITextField = {
        let couponInput = UITextField(frame: CGRect.zero)
        couponInput.placeholder = "Enter your coupon"
        couponInput.font = UIFont.systemFont(ofSize: 14)
        couponInput.borderStyle = UITextField.BorderStyle.roundedRect
        couponInput.clearButtonMode = UITextField.ViewMode.whileEditing
        couponInput.translatesAutoresizingMaskIntoConstraints = false
        return couponInput
    }()
    
    let couponStatus:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Coupon applied sucessfully!"
        txt.textColor = .systemGreen
        txt.font = UIFont.systemFont(ofSize:12)
        txt.isHidden = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let totaltxt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Grand Total"
        txt.font = UIFont.boldSystemFont(ofSize:16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let total:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$0.00"
        txt.textColor = .systemGreen
        txt.font = UIFont.boldSystemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let coupontotaltxt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Coupon Discount"
        txt.font = UIFont.boldSystemFont(ofSize:16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let coupontotal:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$0.00"
        txt.textColor = .systemGreen
        txt.font = UIFont.boldSystemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    let terms:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "By placing an order you agree our Terms and Condition"
        txt.textColor = .systemGray
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private let checkOutBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.title = "Place order"
        config.buttonSize = .large
        config.background.backgroundColor = .systemGreen
        config.baseForegroundColor = .white
        btn.configuration = config
        btn.addTarget(self, action: #selector(placeOrderBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    private lazy var couponCollection:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:makeLayout())
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    @objc func placeOrderBtnTapped(){
        switch selectedPaymentType {
        case .COD:
            guard let grandTotal = grandTotal else { return }
            ShopActions.checkOutProducts(total: grandTotal, paymentMode: .COD)
            addCouponToUser()
            let alert = UIAlertController(title: "Order placed!✅", message: "Your order has been placed successfully please check my order section in you profile for more details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        case .PAYNOW:
            self.showPaymentForm()
        }
    }
    
    @objc func changePayBtnTapped(){
        let alert = UIAlertController(title: "Choose Payment Mode", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 10, width: 250, height: 170))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (UIAlertAction) in
            
            self?.checkoutMethod.text = self?.selectedPaymentType.rawValue
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    
    @objc func editBtnTapped(){
        let alert = UIAlertController(title: "Change Address", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.delegate = self
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.textFields?.first?.text = UserData.user?.address
        alert.addAction(UIAlertAction(title: "change", style: .default, handler: {[weak self] _ in
            guard let newAddress = alert.textFields?.last?.text, !newAddress.isEmpty else {  return  }
            ShopActions.updateAddress(user: UserData.user!, newAddress: newAddress)
            self?.address.text = newAddress
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "Checkout"
    }
    
    private func showPaymentForm(){
        let options: [String:Any] = [
            "amount": "\(Int(grandTotal!*100))",
                    "currency": "INR",
                    "description": "Total amount",
                    "image": "https://cf.ltkcdn.net/greenliving/images/std/137652-347x346r1-eco_shopping_option.JPG",
                    "name": "Green Shoppers Checkout",
                    "prefill": [
                        "contact": "\(UserData.user?.phone ?? "7448308494")",
                        "email": "\(UserData.user?.email ?? "ajith.madhan")"
                    ],
                    "theme": [
                        "color": "#11E72A"
                    ]
                ]
        razorpay.open(options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_test_4EbEUzaUGUn5Kj", andDelegate: self)
        view.backgroundColor = .systemBackground
        view.addSubview(addressTxt)
        view.addSubview(editBtn)
        view.addSubview(address)
        view.addSubview(phoneTxt)
        view.addSubview(name)
        view.addSubview(phone)
        view.addSubview(checkoutMethod)
        view.addSubview(changePayBtn)
        view.addSubview(checkoutMethodTxt)
        view.addSubview(coupontotaltxt)
        view.addSubview(coupontotal)
        view.addSubview(totaltxt)
        view.addSubview(total)
        view.addSubview(terms)
        view.addSubview(checkOutBtn)
        view.addSubview(couponInput)
        view.addSubview(couponText)
        view.addSubview(applyBtn)
        view.addSubview(couponStatus)
        view.addSubview(couponCollection)
        setupLayout()
        setupNavbar()
        hideKeyboardWhenTappedAround()
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
    }
    
    @objc func changeImage() {
             
         if counter < 3 {
              let index = IndexPath.init(item: counter, section: 0)
              self.couponCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.couponCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter = 1
           }
      }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
           
            addressTxt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            addressTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            editBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            editBtn.leadingAnchor.constraint(equalTo: addressTxt.trailingAnchor,constant: 5),
            
            address.topAnchor.constraint(equalTo: addressTxt.bottomAnchor,constant: 10),
            address.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            address.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            phoneTxt.topAnchor.constraint(equalTo: address.bottomAnchor,constant: 15),
            phoneTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            name.topAnchor.constraint(equalTo: phoneTxt.bottomAnchor,constant: 10),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            phone.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 10),
            phone.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            phone.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            checkOutBtn.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.95),
            checkOutBtn.heightAnchor.constraint(equalToConstant: 50),
            checkOutBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            checkOutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            terms.bottomAnchor.constraint(equalTo: checkOutBtn.topAnchor,constant: -10),
            terms.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            terms.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
        
            totaltxt.bottomAnchor.constraint(equalTo: terms.topAnchor,constant: -10),
            totaltxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            total.bottomAnchor.constraint(equalTo: terms.topAnchor,constant: -10),
            total.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            coupontotaltxt.bottomAnchor.constraint(equalTo: totaltxt.topAnchor,constant: -10),
            coupontotaltxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            coupontotal.bottomAnchor.constraint(equalTo: totaltxt.topAnchor,constant: -10),
            coupontotal.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            changePayBtn.bottomAnchor.constraint(equalTo: coupontotaltxt.topAnchor,constant: -5),
            changePayBtn.leadingAnchor.constraint(equalTo: checkoutMethodTxt.trailingAnchor,constant: 5),
            
            checkoutMethod.bottomAnchor.constraint(equalTo: coupontotaltxt.topAnchor,constant: -10),
            checkoutMethod.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            
            checkoutMethodTxt.bottomAnchor.constraint(equalTo: coupontotaltxt.topAnchor,constant: -10),
            checkoutMethodTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            couponStatus.topAnchor.constraint(equalTo: couponInput.bottomAnchor,constant: 10),
            couponStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            
            couponInput.topAnchor.constraint(equalTo: couponText.bottomAnchor,constant: 10),
            couponInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            couponInput.widthAnchor.constraint(equalTo:view.widthAnchor,multiplier: 0.75),
            couponInput.heightAnchor.constraint(equalToConstant: 40),

            applyBtn.topAnchor.constraint(equalTo: couponText.bottomAnchor,constant: 15),
            applyBtn.leadingAnchor.constraint(equalTo: couponInput.trailingAnchor,constant: 10),
            
            couponText.topAnchor.constraint(equalTo: phone.bottomAnchor,constant: 10),
            couponText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
        
            couponCollection.topAnchor.constraint(equalTo: couponStatus.bottomAnchor,constant: 10),
            couponCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            couponCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            couponCollection.bottomAnchor.constraint(equalTo: checkoutMethodTxt.topAnchor,constant: -10),
        ])
    }
    
}

extension CheckOutPageViewController :UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(35)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentOptions[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch paymentOptions[row] {
        case .COD:
            self.selectedPaymentType = .COD
        case .PAYNOW:
            self.selectedPaymentType = .PAYNOW
        }
    }
}


extension CheckOutPageViewController : RazorpayPaymentCompletionProtocol {


    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        let alert = Utils.presentAlert(withTitle: "Alert", message: str)
        self.present(alert, animated: true, completion: nil)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        guard let grandTotal = grandTotal else{return}
        ShopActions.checkOutProducts(total: grandTotal, paymentMode: .PAYNOW)
        addCouponToUser()
        let alert = UIAlertController(title: "Order placed!✅", message: "Your order has been placed successfully please check my order section in you profile for more details.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CheckOutPageViewController{
    
    private func disableCouponMethod(){
        self.couponInput.isEnabled = false
        self.couponText.isEnabled = false
        self.applyBtn.isEnabled = false
        applyBtn.setTitle("Applied!", for: .normal)
    }
    
    private func addCouponToUser(){
        guard let enteredCoupon = couponInput.text else {return}
        
        for coupon in UserData.allCoupons ?? [] {
            if coupon.code == enteredCoupon.uppercased(){
                ShopActions.addToUserCoupons(coupon: coupon)
                return
            }
        }
    }
    
    @objc func couponApplied(){
        guard let enteredCoupon = couponInput.text else {return}
        for coupon in UserData.allCoupons ?? [] {
            if coupon.code == enteredCoupon.uppercased(){
                for userCoupon in UserData.user?.appliedCouponsList ?? [] {
                    if userCoupon.code == coupon.code {
                        self.couponStatus.isHidden = false
                        self.couponStatus.textColor = .systemRed
                        self.couponStatus.text = "You can only use this coupon once!"
                        return
                    }
                }
                if grandTotal! >= coupon.treshHold {
                    disableCouponMethod()
                    
                    self.couponStatus.isHidden = false
                    let discount = grandTotal! * (Double(coupon.discount)/100)
                    grandTotal = grandTotal! - discount
                    self.couponStatus.textColor = .systemGreen
                    self.couponStatus.text = "Coupon applied successfully!"
                    self.total.text = "$\(String(format:"%.2f", grandTotal!))"
                    self.coupontotal.text = "$\(String(format:"%.2f", discount))"
                    return
                }else{
                    self.couponStatus.isHidden = false
                    self.couponStatus.textColor = .systemRed
                    self.couponStatus.text = "Coupon failed please buy products more than $\(coupon.treshHold)"
                    return
                }
            }
        }
        self.couponStatus.isHidden = false
        self.couponStatus.textColor = .systemRed
        self.couponStatus.text = "Please Enter a valid Coupon code!"
        return
    }
    
}




extension CheckOutPageViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
        cell.data = UserData.couponImages[indexPath.row]
        cell.pageControl.currentPage = indexPath.row
        return cell
    }
}


extension CheckOutPageViewController {

    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                return Utils.configureSection(itemHeight: 1, itemWidth: 1, groupHeight: 1, groupWidth: 1, ItemCount: 1, hasHeader: false, isVerticalScroll: true, isHorizontal: true)
        }
        return layout
    }
    
  
}

extension CheckOutPageViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 60
    }
}
