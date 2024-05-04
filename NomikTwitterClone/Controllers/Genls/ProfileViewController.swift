//
//  ProfileViewController.swift
//  NomikTwitterClone
//
//  Created by Pinocchio on 2024/4/30.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var isStatusBarHidden: Bool = true
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        //這行程式碼設置了 statusBar 的透明度為 0
        view.layer.opacity = 0
        return view
    }()
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(profileTableView)
        view.addSubview(statusBar)
        
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        profileTableView.tableHeaderView = headerView
        
        //系統會自動調整這些偏移量以避免內容被螢幕上的其他視圖遮蔽
        profileTableView.contentInsetAdjustmentBehavior = .never
        //導航列會被隱藏起來，不再顯示在畫面上
        navigationController?.navigationBar.isHidden = true
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
        ])
        
        
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    //當滾動發生時，這個方法會被調用，並且可以讓你在滾動過程中執行一些自定義的邏輯
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //這個值會告訴你內容在垂直方向上相對於滾動視圖的位置。向下滾動，值會增加；向上滾動，值會減少
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false
            //0.3 秒內以恆定速度將 statusBar 的透明度從當前值（假設是 0）改變到 1，從而使狀態列完全顯示出來。
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            }completion: { _ in }
        }else if yPosition < 150 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            }completion: { _ in }
        }
    }
}
