//
//  HeroeDetailViewController.swift
//  APIMarvel
//
//  Created by admin on 23/6/21.
//

import UIKit
import Kingfisher

class HeroeDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var comicsCollection: UICollectionView!
    @IBOutlet weak var storiesCollection: UICollectionView!
    
    
    //MARK: - Variables
    var misCells: MCell = MCell(xibName: "ComicCVCell", idReuse: "ComicCVCell")
    var character: CharacterResult?
    var allComics: [Comics]?
    let client = NetworkClient()
    var offset = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.comicsCollection.delegate = self
        self.comicsCollection.dataSource = self
        
        //self.storiesCollection.dataSource = self
        //self.storiesCollection.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        comicsCollection.setCollectionViewLayout(layout, animated: true)
        //storiesCollection.setCollectionViewLayout(layout, animated: true)
        
        // Register cell classes
        self.comicsCollection!.register(UINib(nibName: misCells.xibName, bundle: nil), forCellWithReuseIdentifier: misCells.idReuse)
        //self.storiesCollection!.register(UINib(nibName: misCells.xibName, bundle: nil), forCellWithReuseIdentifier: misCells.idReuse)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let secureComics = character?.comics else { return 0}
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: misCells.idReuse, for: indexPath) as! ComicCVCell
        
        //let myAlbum = allAlbums[indexPath.row]
        guard let secureComics = allComics else { return cell}
        cell.setData(comic: secureComics[indexPath.row])
        print(indexPath.row)
        
        return cell
    }
    
    
    //MARK: - Functions
//    func getHeroeDetail() {
//        guard let secureCharacterId = character?.id else { return }
//        
//        client.getCharacterDetail(offset: offset, characterId: secureCharacterId) { result in
//            switch result {
//            case .success(let characters):
//                guard let secureResults = characters.data?.results else { return }
//                
//                self.offset += secureResults.count
//                self.allHeroes.append(contentsOf: secureResults)
//                self.comicsCollection.reloadData()
//                self.isLoading = false
//                
//                print("El último heroe es: \(characters.data?.results?.last)")
//                print("Offset = \(self.offset)")
//            case .failure(let error):
//                // Vamos a mostrar una alerta al usuario con la descripcion del error
//                print(error.errorDescription)
//            }
//        }
//        
//        
//        client.getCharacters(offset: offset) { result in
//            switch result {
//            case .success(let characters):
//                guard let secureResults = characters.data?.results else { return }
//                
//                self.offset += secureResults.count
//                self.allHeroes.append(contentsOf: secureResults)
//                self.tableView.reloadData()
//                self.isLoading = false
//                
//                print("El último heroe es: \(characters.data?.results?.last)")
//                print("Offset = \(self.offset)")
//            case .failure(let error):
//                // Vamos a mostrar una alerta al usuario con la descripcion del error
//                print(error.errorDescription)
//            }
//        }
//    }
    
    
    
    func setCharacterData() {
        guard let securePath = character?.thumbnail?.path else { return }
        guard let secureExtension = character?.thumbnail?.thumbExtension else { return }
        
        let url = URL(string: "\(securePath.replacingOccurrences(of: "http", with: "https")).\(secureExtension)")
        guard let secureURL = url else { return }
        
        navigationTitle.title = character?.name
        heroeDescription.text = character?.description
        heroeImage.kf.setImage(with: secureURL)
        heroeImage.layer.cornerRadius = 8
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct MCell {
    var xibName: String
    var idReuse: String
}
