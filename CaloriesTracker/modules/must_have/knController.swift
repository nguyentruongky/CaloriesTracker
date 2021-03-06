//
//  knController.swift
//  Ogenii
//
//  Created by Ky Nguyen on 3/17/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
enum knNavBarStatus {
    case hidden
    case show
    case doNotCheck
}

class knController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navBarHidden != .doNotCheck {
            navigationController?.hideBar(navBarHidden == .hidden)
        }
    }
    
    var stateView: knStateView?
    
    func setupView() { }
    func fetchData() { }
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
    
    func addState() {
        if stateView == nil {
            stateView = knStateView()
        }
        if view.subviews.contains(stateView!) { return }
        view.addSubview(stateView!)
        stateView!.fill(toView: view)
    }
    
    var navBarHidden = knNavBarStatus.doNotCheck
    var statusBarStyle = UIStatusBarStyle.lightContent
        { didSet { setNeedsStatusBarAppearanceUpdate() } }
    var statusBarHidden = false { didSet { setNeedsStatusBarAppearanceUpdate() }}

    override var preferredStatusBarStyle: UIStatusBarStyle { return statusBarStyle }
    override var prefersStatusBarHidden: Bool { return statusBarHidden }
}

class knTableController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerCells()
    }
    
    func setupView() { }
    func registerCells() { }
    func fetchData() { }
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100 }
}

class knCustomTableController: knController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    func registerCells() {}
    
    lazy var tableView: UITableView = { [weak self] in
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.dataSource = self
        tb.delegate = self
        return tb
        }()
    
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension knCustomTableController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100 }
}

class knCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    init() { super.init(collectionViewLayout: UICollectionViewFlowLayout()) }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    func registerCells() { }
    func setupView() { }
    func fetchData() { }
    
    deinit { print("Deinit \(NSStringFromClass(type(of: self)))") }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 0 }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { return UICollectionViewCell() }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { return UIScreen.main.bounds.size }
}

