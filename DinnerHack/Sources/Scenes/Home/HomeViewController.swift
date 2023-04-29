//
//  HomeViewController.swift
//  DinnerHack
//
//  Created by saint on 2023/04/30.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {

    private let appLabel = UILabel().then {
        $0.text = "책거리"
        $0.font = UIFont(name: "MapoFlowerIsland", size: 24.0)
    }
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["다가온 책", "지나간 책들"])
    
    private lazy var segmentedLineView = UIView(frame: CGRect(x: 30, y: 428, width: 343, height: 1)).then{
        $0.backgroundColor = .brown1
    }
    
    private let cameBookVC = CameBookVC()
    private let leaveBookVC = LeaveBookVC()
    
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil).then {
        $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        $0.delegate = self
        $0.dataSource = self
    }
    
    var dataViewControllers: [UIViewController] {
        [self.cameBookVC, self.leaveBookVC]
    }
    
    var currentPage: Int = 0 {
        didSet{
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.bg
        setLayout()
        setSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameBookVC.bookListCV.reloadData()
    }
}

extension HomeViewController{
    
    private func setSegmentedControl(){
        /// 현재 페이지 index 번호에 해당하는 segmentedcontrol이 아닐 때(for: .normal),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brown1,
                                                      .font: UIFont(name: "MapoFlowerIsland", size: 16.0)!], for: .normal)
        /// 현재 페이지 index 번호에 해당하는 segmentedControl일 때(for: .selected),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brown2,
                                                      .font: UIFont(name: "MapoFlowerIsland", size: 16.0)!], for: .selected)
        /// 페이지가 변경되어 index값이 달라졌을 때
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    @objc private func changeValue(control: UISegmentedControl) {
        /// currentPage 변수에 현재 선택된 Segmentcontrol의 index를 넣어줌 -> pageViewController와 index 번호 통일
        self.currentPage = control.selectedSegmentIndex
    }
    
    func setLayout(){
        view.addSubViews([appLabel, segmentedLineView])
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)
        
        appLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(23.adjustedH)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(24.adjustedW)
        }
        
        segmentedControl.snp.makeConstraints{
            $0.top.equalTo(appLabel.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(49)
        }
        
        segmentedLineView.snp.makeConstraints{
            $0.bottom.equalTo(segmentedControl.snp.bottom)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.height.equalTo(3)
        }
        
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom).offset(27.adjustedW)
            $0.bottom.equalToSuperview().offset(-40)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index - 1 >= 0
                /// 만약, '(현재 viewcontroller의 index 번호) - 1' 이 0보다 크거나 같다면~
        else { return nil }
        return self.dataViewControllers[index - 1] /// dataViewController 배열의 index 번호에서 1을 빼준다.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index + 1 < self.dataViewControllers.count /// 만약, '(현재 viewcontroller의 index 번호) + 1' 이 0보다 작다면~
        else { return nil }
        return self.dataViewControllers[index + 1] /// dataViewController 배열의 index 번호에서 1을 더해준다.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0],
              let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}
