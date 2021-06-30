//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var events: UICollectionView!
    @IBOutlet weak var series: UICollectionView!
    @IBOutlet weak var comics: UICollectionView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    //MARK: - Variables
    
    var detailCell: MCell = MCell(xibName: "ComicsCell", idReuse: "ComicsCell")
    var seriesCell: MCell = MCell(xibName: "SeriesCell", idReuse: "SerieCell")
    var eventCell: MCell = MCell(xibName: "EventsCell", idReuse: "EventsCell")
    var detailHero = CharacterResult()
    var allComics: [ComicResult] = []
    var allSeries: [SeriesResult] = []
    var allEvents: [EventResult] = []
    var client = NetworkClient()
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerEvents()
        registerComics()
        registerSeries()
        
        setCharacterData(data: detailHero)
        comicSetup()
        
        
    }
    
    // MARK: - CARGANDO COMICS
    
    func comicSetup(){
        
        guard let secureId = detailHero.id else{return}
        print("hola \(secureId)")
        
        client.getComics(characterId: secureId){result in
            switch result {
            case .success(let comicos):
                
                guard let secureComicos = comicos.data?.results else {return}
                
                self.allComics.append(contentsOf: secureComicos)
                self.comics.reloadData()
                
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription as Any)
            }
        }
        
        client.getSeries(characterId: secureId){result in
            switch result {
            
            case .success(let series):
                
                guard let secureSeries = series.data?.results else {return}
                
                self.allSeries.append(contentsOf: secureSeries)
                self.series.reloadData()
                print("hola event2 \(self.allSeries)")
                
            case .failure(let error):
                // Mostrar una alerta al usuario con el errorDescription
                print(error.errorDescription as Any)
            }
        }
        client.getEvents(characterId: secureId){result in
            switch result {
            
            case .success(let events):
                
                guard let secureevents = events.data?.results else {return}
                
                self.allEvents.append(contentsOf: secureevents)
                self.events.reloadData()
                print("hola event2 \(self.allEvents)")
                
            case .failure(let error):
                // Mostrar una alerta al usuario con el errorDescription
                print(error.errorDescription as Any)
            }
        }
        
    }
    
    // MARK: - CARGANDO LAS CELL
    
    func registerComics() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 200, height: 250)
        
        
        comics.setCollectionViewLayout(layout, animated: true)
        comics.register(UINib(nibName: detailCell.xibName, bundle: nil), forCellWithReuseIdentifier: detailCell.idReuse)
        
    }
    func registerSeries() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 250, height: 250)
        
        
        series.setCollectionViewLayout(layout, animated: true)
        series.register(UINib(nibName: seriesCell.xibName, bundle: nil), forCellWithReuseIdentifier: seriesCell.idReuse)
        
    }
    
    func registerEvents() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 250, height: 250)
        
        
        events.setCollectionViewLayout(layout, animated: true)
        events.register(UINib(nibName: eventCell.xibName, bundle: nil), forCellWithReuseIdentifier: eventCell.idReuse)
        
    }
    
    // MARK: - CHARACTER DATA
    
    func setCharacterData (data: CharacterResult){
        detailName.text = data.name
        detailDescription.text = data.description == "" ? "Not description found" : data.description
        
        guard let securePath = data.thumbnail?.path else { return }
        
        let secureURL = securePath.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: "\(secureURL).jpg")
        
        detailImage.kf.setImage(with: url)
    }
    
    // MARK: - COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comics {
            return allComics.count
        } else if collectionView == series {
            return allSeries.count
        } else if collectionView == events {
            return allEvents.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == comics {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! ComicsCell
            
            cell.setComic(data: allComics[indexPath.row])
            
            return cell
        } else if collectionView == series {
            let serieCell = collectionView.dequeueReusableCell(withReuseIdentifier: seriesCell.idReuse, for: indexPath) as! SeriesCell

            serieCell.setSeries(data: allSeries[indexPath.row])
            
            return serieCell
        } else {
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCell.idReuse, for: indexPath) as! EventsCell
            
            eventCell.setEvent(data: allEvents[indexPath.row])
            
            return eventCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cell: UICollectionViewCell
        if collectionView == comics {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! ComicsCell
        } else if collectionView == series{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: seriesCell.idReuse, for: indexPath) as! SeriesCell
        } else if collectionView == events{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCell.idReuse, for: indexPath) as! EventsCell
        } else {
            cell = UICollectionViewCell()
        }
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize  = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
    }
    
    
}
