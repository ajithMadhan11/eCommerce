//
//  Stepper.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 01/03/22.
//

import Foundation
import UIKit

class Stepper:UIControl {

    var currentValue:Int = 1 {
        didSet {
            checkAndSetCurrentValue()
        }
    }
    
    
    weak var delegate:StepperDelegate?
    
    var addBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .small)
        let largeBoldBtn = UIImage(systemName: "plus", withConfiguration: largeConfig)
        btn.setImage(largeBoldBtn, for: .normal)
        config.background.backgroundColor = .systemBackground
        config.baseForegroundColor = .systemRed
        btn.configuration = config
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var steppervalue :UILabel = {
       let txt = UILabel(frame: CGRect.zero)
       txt.textColor = .systemRed
       txt.backgroundColor = .systemBackground
       txt.font = UIFont.systemFont(ofSize: 16)
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
       txt.translatesAutoresizingMaskIntoConstraints = false
       return txt
   }()
    
    private var subBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .small)
        let largeBoldBtn = UIImage(systemName: "minus", withConfiguration: largeConfig)
        btn.setImage(largeBoldBtn, for: .normal)
        config.background.backgroundColor = .systemBackground
        config.baseForegroundColor = .systemRed
        btn.configuration = config
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(subtractBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func checkAndSetCurrentValue(){
        
        if currentValue >= 0 && currentValue < 5 {
            addBtn.isEnabled = true
        }else{
            addBtn.isEnabled = false
        }
        if currentValue > 0 {
            subBtn.isEnabled = true
        }else{
            subBtn.isEnabled = false
        }
      
        steppervalue.text = "\(currentValue)"
        
    }
    
    @objc func addBtnTapped(){
        currentValue += 1
        if currentValue >= 5 {
            addBtn.isEnabled = false
            subBtn.isEnabled = true
        }
        checkAndSetCurrentValue()
        self.delegate?.stepperChanged(value: currentValue)
    }
    
    
    @objc func subtractBtnTapped(){
        currentValue -= 1
        if currentValue == 0 {
            subBtn.isEnabled = false
            addBtn.isEnabled = true
        }
        checkAndSetCurrentValue()
        self.delegate?.stepperChanged(value: currentValue)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(addBtn)

        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.addSubview(steppervalue)
        self.addSubview(subBtn)
        setupLayout()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            subBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subBtn.widthAnchor.constraint(equalToConstant: 45),
            subBtn.heightAnchor.constraint(equalToConstant: 45),

            steppervalue.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            steppervalue.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            addBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: 45),
            addBtn.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

protocol StepperDelegate:AnyObject {
    func stepperChanged(value:Int)
}


    
    

