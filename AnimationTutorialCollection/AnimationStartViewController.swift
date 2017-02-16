//
//  AnimationStartViewController.swift
//  AnimationTutorialCollection
//
//  Created by Ju on 2017/2/16.
//  Copyright © 2017年 Ju. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds: Double, completion:@escaping ()->()) {
  let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
  
  DispatchQueue.main.asyncAfter(deadline: popTime) {
    completion()
  }
}

class AnimationStartViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: IB outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  
  // MARK: further UI
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  
  // MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true
    
    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)
    
    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)
    
    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // For ...
    heading.center.x -= view.bounds.width
    username.center.x -= view.bounds.width
    password.center.x -= view.bounds.width
    
    // For clunds
    cloud1.alpha = 0.0
    cloud2.alpha = 0.0
    cloud3.alpha = 0.0
    cloud4.alpha = 0.0
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // For ...
    UIView.animate(withDuration: 0.5) { 
      self.heading.center.x += self.view.bounds.width
    }
    
    UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
      self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
      self.password.center.x += self.view.bounds.width
    }, completion: nil)

    // For clounds
    UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: { 
      self.cloud1.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
      self.cloud2.alpha = 1.0
    }, completion: nil)

    UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
      self.cloud3.alpha = 1.0
    }, completion: nil)

    UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
      self.cloud4.alpha = 1.0
    }, completion: nil)
  }
  
  // MARK: further methods
  
  @IBAction func login() {
    view.endEditing(true)
    
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
  
}

