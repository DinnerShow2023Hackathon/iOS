//
//  CameBookVC.swift
//  DinnerHack
//
//  Created by saint on 2023/04/29.
//

import UIKit
import SnapKit
import Then
import Moya

class CameBookVC: UIViewController {
    
    private lazy var bookListCV : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isEditing = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsFocusDuringEditing = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.bottom = 60
        return collectionView
    }()
    
    private let opacityLayer = UIImageView().then{
        $0.image = UIImage(named: "opacityLayer")
    }
    
    let addBookBtn = UIButton().then{
        $0.setImage(UIImage(named: "addBtn"), for: .normal)
    }
    
    let addBookVC = PostingImageViewController()
    
    var bookList: [BookModel] = [
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg")
    ]
    
    // MARK: - Constants
    final let imageListLineSpacing: CGFloat = 32
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
        pressBtn()
    }
    
    private func registerCVC() {
        bookListCV.register(
            CameBookCVC.self, forCellWithReuseIdentifier: CameBookCVC.className)
    }
}

extension CameBookVC{
    func setLayout(){
        view.backgroundColor = .clear
        view.addSubViews([bookListCV, opacityLayer, addBookBtn])
        
        bookListCV.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        opacityLayer.snp.makeConstraints{
            $0.leading.trailing.equalTo(bookListCV)
            $0.height.equalTo(128)
            $0.bottom.equalTo(bookListCV.snp.bottom)
        }
        
        addBookBtn.snp.makeConstraints{
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(129.5)
            $0.height.equalTo(45.5)
        }
    }
    
    func pressBtn(){
        addBookBtn.press { [self] in
            
//            let navigationController = UINavigationController(rootViewController: PostingImageViewController())
//            navigationController.modalPresentationStyle = .fullScreen
//            present(navigationController, animated: true, completion: nil)
            
            addBookVC.modalPresentationStyle = .overFullScreen
            present(addBookVC, animated: true, completion:nil)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CameBookVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 163.adjustedW, height: 235.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return imageListLineSpacing
    }
}

// MARK: - UICollectionViewDataSource
extension CameBookVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: CameBookCVC.className, for: indexPath) as? CameBookCVC else { return UICollectionViewCell() }
        bookCell.dataBind(model: bookList[indexPath.row])
        return bookCell
    }
}
