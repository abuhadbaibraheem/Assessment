//
//  ListAritclesProtocols.swift
//  Assessment
//
//  Created Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ListAritclesWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol ListAritclesPresenterProtocol: BasePresenterProtocol {
    var lastaritcles: AritclesEntity? { get set }
    
    func aritclesLoaded(aritcles: AritclesEntity?)
    func aritclesLoadingError(error:String)
    func titleVC() -> String
    
}

//MARK: Interactor -
protocol ListAritclesInteractorProtocol: class {
    
    var presenter: ListAritclesPresenterProtocol?  { get set }
    func getListAritcles()
}

//MARK: View -
protocol ListAritclesViewProtocol: BaseViewProtocol {
    
    var presenter: ListAritclesPresenterProtocol?  { get set }
    func populateTableView()
}
