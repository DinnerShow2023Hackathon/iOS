//
//  LeaveBookVC.swift
//  DinnerHack
//
//  Created by saint on 2023/04/29.
//

import UIKit
import SnapKit
import Then
import Moya

class LeaveBookVC: UIViewController {
    
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
    
    let addBookVC = PostingImageViewController()
    
    var bookList: [BookModel] = [
        BookModel(title: "잘난놈 심리학", contents: "여행을 몇 번 다녔음에도 왜 다니는 지에 관하여 명확한 말을 할 수 없더라고요. 그래서 이 책을 읽고 조금이나마 깨닫고 싶었어요. 깨달은 건 여행의 깊이만큼 소화하는데도 시간이 걸린다!", image: UIImage(named: "test04")!),
        BookModel(title: "왜 사업하는가", contents: "책은 우리 내부의 얼어붙은 바다를 깨기 위한 도끼가 되어야만 한다'라는 카프카의 말로 시작하는 이 책은 둔탁하게만 여겨지던 고전들을 날카롭게 벼려 전달합니다. 지루하게만 생각되던 고전을 이렇게 재밌어서 여태까지 살아남았구나로 재인식하게 만드는 이 책이 당신에게도 묵직한 도끼질이길 기대하며, 책을 놓아보내요", image: UIImage(named: "book1")!),
        BookModel(title: "데미안", contents: "미소를 건네는 것도 힘들 정도로 경직된 사회에 안전하게, 진정한 접촉을 이룰 수 있는 꿀팁을 전해줍니다. 대화 소재가 없을 때면 꺼내는 주제로만 생각하던 날씨 이야기를 새로 바라보게 되었습니다. 그 외에도 재치넘치는 필담이 일품인 책이니 얼른 데려가시죠 :)", image: UIImage(named: "book2")!),
        BookModel(title: "장자", contents: "현혹시키는 무수한 선택지들 속에서 뿌리 내릴 한 분야를 결정하기란 쉽지 않죠. 방랑을 최우선의 가치로 두던 저에게 정착의 아름다움을 알려준 책입니다. 당신도 무엇 하나에 깊게 빠져 있나요? 여러분의 방황에도 끝이 보이길 기대하며 이 책을 나눕니다!", image: UIImage(named:"book3")!),
        BookModel(title: "1Q84", contents: "감동을 받았어요.", image: UIImage(named: "bookimg")!),
        BookModel(title: "대중의 반역", contents: "자발적으로 자신보다 큰 의미의 일부가 되는 것은 사람이 누릴 수 있는 최고의 기쁨이다.", image: UIImage(named: "book4")!),
        BookModel(title: "잘난놈 심리학", contents: "여행을 몇 번 다녔음에도 왜 다니는 지에 관하여 명확한 말을 할 수 없더라고요. 그래서 이 책을 읽고 조금이나마 깨닫고 싶었어요. 깨달은 건 여행의 깊이만큼 소화하는데도 시간이 걸린다!", image: UIImage(named: "test04")!),
        BookModel(title: "왜 사업하는가", contents: "책은 우리 내부의 얼어붙은 바다를 깨기 위한 도끼가 되어야만 한다'라는 카프카의 말로 시작하는 이 책은 둔탁하게만 여겨지던 고전들을 날카롭게 벼려 전달합니다. 지루하게만 생각되던 고전을 이렇게 재밌어서 여태까지 살아남았구나로 재인식하게 만드는 이 책이 당신에게도 묵직한 도끼질이길 기대하며, 책을 놓아보내요", image: UIImage(named: "book1")!),
        BookModel(title: "데미안", contents: "미소를 건네는 것도 힘들 정도로 경직된 사회에 안전하게, 진정한 접촉을 이룰 수 있는 꿀팁을 전해줍니다. 대화 소재가 없을 때면 꺼내는 주제로만 생각하던 날씨 이야기를 새로 바라보게 되었습니다. 그 외에도 재치넘치는 필담이 일품인 책이니 얼른 데려가시죠 :)", image: UIImage(named: "book2")!),
        BookModel(title: "장자", contents: "현혹시키는 무수한 선택지들 속에서 뿌리 내릴 한 분야를 결정하기란 쉽지 않죠. 방랑을 최우선의 가치로 두던 저에게 정착의 아름다움을 알려준 책입니다. 당신도 무엇 하나에 깊게 빠져 있나요? 여러분의 방황에도 끝이 보이길 기대하며 이 책을 나눕니다!", image: UIImage(named:"book3")!),
        BookModel(title: "1Q84", contents: "감동을 받았어요.", image: UIImage(named: "bookimg")!),
        BookModel(title: "대중의 반역", contents: "자발적으로 자신보다 큰 의미의 일부가 되는 것은 사람이 누릴 수 있는 최고의 기쁨이다.", image: UIImage(named: "book4")!)
    ]
    
    // MARK: - Constants
    final let imageListLineSpacing: CGFloat = 32
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCVC()
    }
    
    private func registerCVC() {
        bookListCV.register(
            LeaveBookCVC.self, forCellWithReuseIdentifier: LeaveBookCVC.className)
    }
}

extension LeaveBookVC{
    func setLayout(){
        view.backgroundColor = .clear
        view.addSubViews([bookListCV, opacityLayer])
        
        bookListCV.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        opacityLayer.snp.makeConstraints{
            $0.leading.trailing.equalTo(bookListCV)
            $0.height.equalTo(128)
            $0.bottom.equalTo(bookListCV.snp.bottom)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LeaveBookVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 163.adjustedW, height: 235.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return imageListLineSpacing
    }
}

// MARK: - UICollectionViewDataSource
extension LeaveBookVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaveBookCVC.className, for: indexPath) as? LeaveBookCVC else { return UICollectionViewCell() }
        bookCell.dataBind(model: bookList[indexPath.row])
        return bookCell
    }
}

