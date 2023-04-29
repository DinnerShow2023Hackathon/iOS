//
//  ViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/29.
//

import UIKit

class ViewController: UIViewController {

    private let nextBTN: UIButton = {
        $0.backgroundColor = .orange
        $0.setTitle("다음", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
 
        self.view.addSubview(nextBTN)
        nextBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 40,
            height: 40
        )

    }
    
    @objc func tapNextBTN() {
        let PostingViewController = PostingImageViewController()
        navigationController?.pushViewController(PostingViewController, animated: true)
    }



}

