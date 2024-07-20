//
//  FirstViewController.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/20/24.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {

    let nameLabel = UILabel()
    let changeNameButton = UIButton()
    
    var nickName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(changeNameButton)
    }
    
    private func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        changeNameButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        changeNameButton.setTitle("이름 바꾸기", for: .normal)
        changeNameButton.backgroundColor = .systemBlue
        changeNameButton.addTarget(self, action: #selector(changeNameButtonTapped), for: .touchUpInside)
    }
    

    @objc func changeNameButtonTapped() {
        let NextVC = NextViewController()
       // NextVC.nickName = nickName
        NextVC.delegate = self
        navigationController?.pushViewController(NextVC, animated: true)
    }
}


extension FirstViewController:NickNameDelegate{
    func changeNickName(_ name: String) {
        nickName = name
        nameLabel.text = name + "님 안녕!"
    }
}

