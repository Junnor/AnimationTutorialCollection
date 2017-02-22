//
//  AnimationStartViewController.swift
//  AnimationTutorialCollection
//
//  Created by Ju on 2017/2/16.
//  Copyright © 2017年 Ju. All rights reserved.
//

// For the spring animation

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
  
  
  var statusPosition = CGPoint.zero
  
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
    statusPosition = status.center
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
    
    // For login button
    loginButton.center.y += 30
    loginButton.alpha = 0.0
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // For ...
    UIView.animate(withDuration: 0.5) { 
      self.heading.center.x += self.view.bounds.width
    }
    
    UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
      self.username.center.x += self.view.bounds.width
    }, completion: nil)

    UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
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
    
    // For login button
    UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y -= 30
      self.loginButton.alpha = 1.0
    }, completion: nil)
    
    animateCloud(cloud: cloud1)
    animateCloud(cloud: cloud2)
    animateCloud(cloud: cloud3)
    animateCloud(cloud: cloud4)
  }
  
  
  func removeMessage(index: Int) {
    UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: { 
      self.status.center.x += self.view.bounds.size.width
    }) { _ in
      self.status.isHidden = true
      self.status.center = self.statusPosition
      
      self.showMessage(index: index+1)
    }
  }
  
  func showMessage(index: Int) {
    label.text = messages[index]
    
    UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
      self.status.isHidden = false
    }) { _ in
      delay(seconds: 2.0, completion: { 
        if index < self.messages.count - 1 {
          self.removeMessage(index: index)
        } else {
          self.resetForm()
        }
      })
    }
    
  }
  
  func resetForm() {
    UIView.transition(with: self.status, duration: 0.22, options: [.transitionFlipFromTop], animations: {
      self.status.isHidden = true
      self.status.center = self.statusPosition
    }, completion: nil)
    
    UIView.animate(withDuration: 0.22, delay: 0.5, options: [], animations: { 
      self.spinner.center = CGPoint(x: -20, y: 16)
      self.spinner.alpha = 0.0
      
      self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
      self.loginButton.bounds.size.width -= 80
      self.loginButton.center.y -= 60
    }, completion: nil)
  }
  
  func animateCloud(cloud: UIImageView) {
    let cloudSpeed = 60.0 / view.frame.size.width
    let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
    UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: [.curveLinear],animations: {
      cloud.frame.origin.x = self.view.frame.size.width
    }, completion: {_ in
      cloud.frame.origin.x = -cloud.frame.size.width
      self.animateCloud(cloud: cloud)
    })
  }

  
  // MARK: further methods
  
  @IBAction func login() {
    view.endEditing(true)
    
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80
    }, completion: { _ in
      self.showMessage(index: 0)
    })
    
    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: { 
      self.loginButton.center.y += 60
      self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
      
      self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.bounds.height/2)
      self.spinner.alpha = 1.0
    }, completion: { (finished) in
//      self.spinner.stopAnimating()
    })
    
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
  
}

