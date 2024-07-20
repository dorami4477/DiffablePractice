//
//  NestViewController.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/20/24.
//

import UIKit

class NextViewController: UIViewController {

    let textField = UITextField()
    let confirmButton = UIButton()
    
    var nickName:String?
    //델리게이트 선언
    weak var delegate:NickNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(confirmButton)
    }
    
    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.backgroundColor = .systemOrange
        textField.borderStyle = .line
        if let nickName{
            textField.text = nickName
        }else{
            textField.text = nil
        }
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    

    @objc func confirmButtonTapped() {
        guard let name = textField.text else { return }
        //값전달하면서 일을 시킴
        delegate?.changeNickName(name)
        navigationController?.popViewController(animated: true)
    }

}

protocol NickNameDelegate:AnyObject{
    func changeNickName(_ name:String)
}

