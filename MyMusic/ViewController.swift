//
//  ViewController.swift
//  MyMusic
//
//  Created by Bintang Aria Ramadhan on 18/03/21.
//  Copyright © 2021 Starfreak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
    }
    
    //fungsi untuk menambahkan list lagu
    func configureSongs() {
        songs.append(Song(name: "All The Time",
                          albumName: "Visible Idea",
                          artistNama: "The Sigit",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "When The Sun Goes Down",
                          albumName: "album",
                          artistNama: "Arctics Monkey",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Don't Look Back in Anger",
                          albumName: "Definetly Maybe",
                          artistNama: "OASIS",
                          imageName: "cover3",
                          trackName: "song3"))
    }
    
    //Tampilan table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        //configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController
            else {
                return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
}

struct Song {
      let name: String
      let albumName: String
      let artistNama: String
      let imageName: String
      let trackName: String
  }

