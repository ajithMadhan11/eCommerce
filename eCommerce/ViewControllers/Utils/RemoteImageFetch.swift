//
//  RemoteImageFetch.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 09/03/22.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

extension UIImageView {
    
    func loadImage(link: String){
        let url = URL(string: link)
        image = nil
        activityView.center = self.center
        self.addSubview(activityView)
        activityView.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: link as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            return
        }
        self.image = UIImage(named: "default")
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }
            
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: link as AnyObject)
                        
                        self.image = imageToCache
                    }else{
                        self.image = UIImage(named: "default")
                    }
                }
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.image = UIImage(named: "default")
                }
            }
        }.resume()
    }
}
