//
//  ViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

    }
    
    @objc func tapNextBTN() {
        let PostingViewController = PostingImageViewController()
        navigationController?.pushViewController(PostingViewController, animated: true)
    }
}

extension HomeViewController{
    
}

