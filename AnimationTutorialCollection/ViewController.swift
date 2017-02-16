//
//  ViewController.swift
//  AnimationTutorialCollection
//
//  Created by Ju on 2017/2/16.
//  Copyright © 2017年 Ju. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let cellCount = 1

enum Chapter: String {
  case ChapterOne = "Getting Start With View Animations"
}

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let identifier = segue.identifier {
      switch identifier {
      case "Animation Start":
        let title = "Animation Start"
        let viewController = segue.destination as! AnimationStartViewController
        viewController.title = title
      default:
        print("Do nothing with segue")
      }
    }
  }
  
}

// MARK: - Collection View DataSource

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChapterCell
    cell.titleLabel.text = "Getting Start With View Animations"
    cell.backgroundColor = .red
    
    return cell
  }
}

// MARK: - Collection View Delegate

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width, height: 77)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
