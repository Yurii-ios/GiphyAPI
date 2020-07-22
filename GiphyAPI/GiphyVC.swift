//
//  GiphyVC.swift
//  GiphyAPI
//
//  Created by Yurii Sameliuk on 21/07/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//
import SDWebImage
import UIKit

class GiphyVC: UIViewController {
    
    
    @IBOutlet var gifTableView: UITableView!
    @IBOutlet var gifSearchBar: UISearchBar!
    
    private var giphyNetwork = GiphyNetwork()
    var gifs = [Gif]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar()
        tableDelegate()
        
        gifTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        loadDefault()
    }
    
    func searchBar() {
        navigationItem.titleView = gifSearchBar
        gifSearchBar.delegate = self
        gifSearchBar.returnKeyType = .search
    }
    
    func tableDelegate() {
        gifTableView.delegate = self
        gifTableView.dataSource = self
    }
    
    func loadDefault() {
        if gifSearchBar.searchTextField.text!.count <= 0 {
            searchGifs(for: "kitten")
        }
        gifTableView.reloadData()
    }
    
    func searchGifs(for searchText: String) {
        giphyNetwork.loadData(search: searchText) { [weak self] gifArray in
            if gifArray != nil {
                print(gifArray!.gifs.count)
                self?.gifs = gifArray!.gifs
                self?.gifTableView.reloadData()
                
            }
        }
    }
    
}

extension GiphyVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myImageView = UIImageView()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let currentImageUrl = gifs[indexPath.row].getGifURL()
        
        guard let url = URL(string: currentImageUrl) else { return cell }
        
        myImageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground], completed: nil)
        cell.addSubview(myImageView)
        myImageView.frame = cell.bounds
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func image (imageView : UIImageView, indexPath: IndexPath) -> UIImage? {
        let currentImageUrl = gifs[indexPath.row].getGifURL()
        guard let url = URL(string: currentImageUrl) else { fatalError()}
        imageView.sd_setImage(with: url, completed: nil)
        
        return imageView.image
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as? DetailVC else {
            fatalError("Unable to instantiate DetailVC")
        }
        let myImagesView = UIImageView()
        
        vc.gif = image(imageView: myImagesView, indexPath: indexPath)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension GiphyVC:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if searchBar.text != nil {
            if let searchBar = searchBar.text {
                searchGifs(for: searchBar )
                
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
        searchGifs(for: "kitten")
    }
}
