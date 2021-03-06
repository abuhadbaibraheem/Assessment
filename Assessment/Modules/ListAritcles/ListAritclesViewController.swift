//
//  ListAritclesViewController.swift
//  Assessment
//
//  Created Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ListAritclesViewController: BaseViewController {

    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(resource: R.nib.aritcleCell), forCellReuseIdentifier: R.reuseIdentifier.aritcleCell.identifier)
            tableView.tableFooterView = UIView()
        }
    }
    
    var presenter: ListAritclesPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTapBar()
    }
    
    private func setTapBar(){
        title = presenter?.titleVC()
        setupBarButtonCustom()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2784313725, green: 0.8823529412, blue: 0.7490196078, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    func setupBarButtonCustom(){
        setSideMenuBarButtonCustom()
        setSearchAndMoreBarButtonCustom()
    }

    func setSideMenuBarButtonCustom(){
        //Back buttion
        let sideMenuBarButton: UIButton = UIButton()
        
        let sideImage = R.image.openMenu()!
        sideMenuBarButton.setImage(sideImage, for: UIControl.State())
        sideMenuBarButton.addTarget(self, action: #selector(onClciksideMenu), for: UIControl.Event.touchUpInside)
        sideMenuBarButton.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: sideMenuBarButton)
        navigationItem.leftBarButtonItem = barButton
    }
    
    func setSearchAndMoreBarButtonCustom(){
        let moreBarButton: UIButton = UIButton()
        let moreImage = R.image.more()!
        moreBarButton.setImage(moreImage, for: .normal)
        moreBarButton.addTarget(self, action: #selector(onClcikBackMore), for: UIControl.Event.touchUpInside)
        let moreButton = UIBarButtonItem(customView: moreBarButton)
        //Back buttion
        let searchBarButton: UIButton = UIButton()
        let arrowImage =  R.image.search()!
        searchBarButton.setImage(arrowImage, for: UIControl.State())
        searchBarButton.addTarget(self, action: #selector(onClcikBackSearch), for: UIControl.Event.touchUpInside)
        searchBarButton.sizeToFit()
        let searchButton = UIBarButtonItem(customView: searchBarButton)
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
    }
    
    @objc func onClciksideMenu(){
   
    }
    
    @objc func onClcikBackMore(){
      
    }
    
    @objc func onClcikBackSearch(){
        
    }
}

extension ListAritclesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.lastaritcles?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.aritcleCell.identifier, for: indexPath) as! AritcleCell
        cell.populate(aritcle: presenter?.lastaritcles?.results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellHeight.sritcleTableCell
    }
   
}

extension ListAritclesViewController: ListAritclesViewProtocol{
    func populateTableView(){
        tableView.reloadData()
    }
}
