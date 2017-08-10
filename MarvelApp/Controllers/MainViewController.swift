//
//  MainViewController.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController {
    
    var marvelAPI = MarvelAPI()
    var characters = [Character]()
    var isGridView = true
    var isFiltering = false
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateModeView()
        requestCharacters()
    }
    
    //MARK: UI
    
    func setupUI() {
        self.navigationItem.title = "Marvel"
        let modeView = UIBarButtonItem(image: UIImage.grid(), style: .plain, target: self, action: #selector(changeModeView(sender:)))
        self.navigationItem.rightBarButtonItem = modeView
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
    
    func showDetails(character:Character) {
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(DetailsViewController.instance(character: character), animated: true)
    }
    
    //MARK: service
    
    func requestCharacters(name:String? = nil) {
        showSpinner()
        marvelAPI.characters(name: name, success: { characters in
            self.characters = characters
            self.reloadData()
            self.hideSpinner()
        }) { error in
            self.hideSpinner()
        }
    }
    
    //MARK: helpers
    
    func showSpinner() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        collectionView.isHidden = true
    }
    
    func hideSpinner() {
        activityIndicator.stopAnimating()
        tableView.isHidden = isGridView
        collectionView.isHidden = !isGridView
    }
}

extension MainViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestCharacters(name: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        requestCharacters()
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let character = characters[indexPath.row]
        cell.labelTitle.text = character.name
        cell.labelDescription.text = character.descriptionBio
        cell.imageMain.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(character: characters[indexPath.row])
    }
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        let character = characters[indexPath.row]
        cell.labelTitle.text = character.name
        cell.imageBackground.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
        cell.imageMain.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(character: characters[indexPath.item])
    }
}
