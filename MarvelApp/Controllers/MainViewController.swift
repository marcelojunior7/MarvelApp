//
//  MainViewController.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var marvelAPI = MarvelAPI()
    var characters = [Character]()
    var isGridView = true
    var isFiltering = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateModeView()
    }
    
    //MARK: UI
    
    func setupUI() {
        self.navigationItem.title = "Marvel"
        let modeView = UIBarButtonItem(image: UIImage.grid(), style: .plain, target: self, action: #selector(changeModeView(sender:)))
        self.navigationItem.rightBarButtonItems = [modeView]
    }
    
    func updateModeView(_ sender : UIBarButtonItem? = nil) {
        if isGridView {
            tableView.isHidden = true
            collectionView.isHidden = false
            sender?.image = UIImage.grid()
        } else {
            tableView.isHidden = false
            collectionView.isHidden = true
            sender?.image = UIImage.list()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    //MARK: actions

    func changeModeView(sender: UIBarButtonItem) {
        isGridView = !isGridView
        updateModeView(sender)
    }
    
    //MARK: service
    
    func requestCharacters() {
        marvelAPI.characters(success: { characters in
            self.characters = characters
            self.reloadData()
        }) {
            
        }
    }
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
