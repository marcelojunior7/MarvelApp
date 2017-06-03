//
//  DetailsViewController.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

enum SegmentedOptions: Int {
    case bio, comics, series, stories, events
    
    var description : String {
        get { return "\(self)" }
    }
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageTopBackground: UIImageView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var buttonMoreDetails: UIButton!
    @IBOutlet weak var labelBio: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var character:Character!
    let options:[SegmentedOptions] = [.bio, .comics, .series, .stories, .events]

    class func instance(character:Character) -> DetailsViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        controller.character = character
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupSegmented()
    }
    
    //MARK: UI
    
    func initUI() {
        self.navigationItem.title = character?.name
        labelBio.text = character.descriptionBio.isEmpty ? "no information" : character.descriptionBio
        imageTopBackground.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
        imageCharacter.af_setImage(withURL:URL(string: character.thumbnail?.fullPath() ?? "")!, placeholderImage: UIImage.placeholder())
    }
    
    func setupSegmented() {
        segmentedControl.tintColor = UIColor.mainColor()
        segmentedControl.removeAllSegments()
        options.forEach({option in
            self.segmentedControl.insertSegment(withTitle: option.description, at: self.segmentedControl.numberOfSegments, animated: true)
        })
        segmentedControl.selectedSegmentIndex = options.index(of: .bio) ?? 0
        segmentedDidSelect(segmentedControl)
    }
    
    @IBAction func segmentedDidSelect(_ sender: UISegmentedControl) {
        let option = options[sender.selectedSegmentIndex]
        if option == .bio {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    @IBAction func details(_ sender: Any) {
        guard let url = character.linkDetails else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items()[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func items() -> [Item] {
        let option = options[segmentedControl.selectedSegmentIndex]
        switch option {
        case .comics:
            return character.comics ?? []
        case .series:
            return character.series ?? []
        case .stories:
            return character.stories ?? []
        case .events:
            return character.events ?? []
        default:
            return []
        }
    }
}
