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
    
    static var bookList: [BookModel] = [
        BookModel(title: "여행의 이유", contents: "꿀잼", image: "test04"),
        BookModel(title: "책은 도끼다", contents: "책은 도끼다.", image: "book1"),
        BookModel(title: "낯선 사람에게 말 걸기", contents: "여자 번호 땄어요.", image: "book2"),
        BookModel(title: "전념", contents: "전념하자", image: "book3"),
        BookModel(title: "노인과 바다", contents: "감동을 받았어요.", image: "bookimg")
    ]
    
    lazy var bookListCV : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.bottom = 60
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    private let opacityLayer = UIImageView().then{
        $0.image = UIImage(named: "opacityLayer")
    }
    
    let addBookBtn = UIButton().then{
        $0.setImage(UIImage(named: "addBtn"), for: .normal)
    }
    
    let addBookVC = PostingImageViewController()
    
    
    // MARK: - Constants
    final let imageListLineSpacing: CGFloat = 32
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
        pressBtn()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("DismissModalView"),
            object: nil
        )
    }
    
    // MARK: - Functions
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async { [self] in
            
            /// modalVC가 dismiss될때 컬렉션뷰를 리로드해줍니다.
            print(CameBookVC.bookList)
            bookListCV.reloadData()
            print("reload 성공!")
        }
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
            bookListCV.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailBookVC = DetailViewController()
        detailBookVC.bookdata = CameBookVC.bookList[indexPath.row]
        detailBookVC.modalPresentationStyle = .overFullScreen
        present(detailBookVC, animated: true, completion:nil)
    }
}

// MARK: - UICollectionViewDataSource
extension CameBookVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CameBookVC.bookList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: CameBookCVC.className, for: indexPath) as? CameBookCVC else { return UICollectionViewCell() }
        bookCell.dataBind(model: CameBookVC.bookList[indexPath.row])
        return bookCell
    }

}
