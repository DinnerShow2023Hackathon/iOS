//
//  ViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/29.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {

    private let appLabel = UILabel().then {
        $0.text = "책거리"
        $0.font = UIFont(name: "MapoFlowerIsland", size: 24.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.bg
        setLayout()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    @objc func tapNextBTN() {
        let PostingViewController = PostingImageViewController()
        navigationController?.pushViewController(PostingViewController, animated: true)
    }
}

extension HomeViewController{
    func setLayout(){
        view.addSubViews([appLabel])
        
        appLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(23.adjustedH)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.adjustedW)
        }
    }
}

