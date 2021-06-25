//
//  TableViewController.swift
//  APIMarvel
//
//  Created by admin on 22/6/21.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    let idCell = "CharacterCell"
    let client = NetworkClient()
    var allHeroes: [CharacterResult] = []
    var heroe: CharacterResult?
    var isLoading = false
    var offset: Int = 0
    var firstTime = true
    var characterPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(offset)
        
        //getMoreHeroes()
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        
        self.tableView?.register(UINib(nibName: idCell, bundle: nil), forCellReuseIdentifier: idCell)
        self.tableView?.register(tableViewLoadingCellNib, forCellReuseIdentifier: "loadingcellid")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return allHeroes.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! CharacterCell
            cell.setData(character: allHeroes[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //heroe = allHeroes[indexPath.row]
            //performSegue(withIdentifier: "HeroeDetail", sender: self)
            print("El id es: \(allHeroes[indexPath.row].id)")
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 50
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            loadMoreData()
        }
    }
    
    func getMoreHeroes() {
        client.getCharacters(offset: offset) { result in
            switch result {
            case .success(let characters):
                guard let secureResults = characters.data?.results else { return }
                
                self.offset += secureResults.count
                self.allHeroes.append(contentsOf: secureResults)
                self.tableView.reloadData()
                self.isLoading = false
                
                print("El último heroe es: \(characters.data?.results?.last)")
                print("Offset = \(self.offset)")
            case .failure(let error):
                // Vamos a mostrar una alerta al usuario con la descripcion del error
                print(error.errorDescription)
            }
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            getMoreHeroes()
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HeroeDetail" {
            guard let heroeDetailViewController = segue.destination as? HeroeDetailViewController else { return }
            heroeDetailViewController.character = heroe
            //heroeDetailViewController.allComics = heroe?.comics
        }
    }
    
    
}
