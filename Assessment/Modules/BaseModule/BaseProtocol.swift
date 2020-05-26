//
//  BaseProtocol.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import Foundation

protocol BaseViewProtocol: class {
    func dismissViewController()
    func notifyUser(title:String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showMessage(title: String, message: String)
    func showMessage(title: String, message: String, cancelAction: @escaping (() -> Void))
    func showUndismissableMessage(title: String, message: String)
}

protocol BasePresenterProtocol: class {
    func viewDidLoad()
    func viewWillAppear()
}

extension BasePresenterProtocol{
    func viewWillAppear(){}
}

class BasePresenter {
    
}

