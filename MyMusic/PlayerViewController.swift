//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Bintang Aria Ramadhan on 20/03/21.
//  Copyright © 2021 Starfreak. All rights reserved.
//

import AVFoundation //music player plugin
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    //properti user interface element
    private let albumImageView: UIImageView = {
    //anonymus closure
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
       //anonymus closure
           let label = UILabel()
           label.textAlignment = .center
           label.numberOfLines = 0 //line wrap
           label.font = UIFont(name: "Helvetica-Bold", size: 25)
           return label
    }()
    
    private let albumNameLabel: UILabel = {
          //anonymus closure
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 //line wrap
            label.textColor = .gray
            return label
    }()
    
    private let artistNameLabel: UILabel = {
          //anonymus closure
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0 //line wrap
            label.font = UIFont(name: "Helvetica-Bold", size: 15)
            return label
    }()
    
    let playPauseButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure() //lalu buat func configure
        }
    }
    
    func configure() {
        //set up player
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                print("urlString is nil")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                print("player is nil")
                return
            }
            
            //membuat volume awal standart volume 50%
            player.volume = 0.5
            
            player.play()
        }
        
        catch  {
            print("error occured")
        }
        
        //set up user interface element atau tampilan
        //album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        
        //labels: songname, album, artist
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 50,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 10 + 100,
                                       width: holder.frame.size.width-20,
                                       height: 70)
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName

        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        
        //Players controls
        
        //buat propert nilai
        let backButton = UIButton()
        let nextButton = UIButton()
        
        //buat tampilan button di frame
        //buat variabel property dulu
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 50
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        //add action for each button nanti masukan dari func yang dibuat dibawah atau di MVC pattern
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        //image and styling button
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(backButton)
        holder.addSubview(nextButton)
        
        //cara membuat slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-60,
                                            width: holder.frame.size.width-40,
                                            height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_ :)), for: .valueChanged)
        holder.addSubview(slider)
    }
    
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true { //dikasih boolean true karena player tanda? itu opsional
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink Image
            UIView.animate(withDuration: 0.3, animations: {
                self.albumImageView.frame = CGRect(x: 40,
                                                   y: 40,
                                                   width: self.holder.frame.size.width-70,
                                                   height: self.holder.frame.size.width-70)
            })
        } else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //increase image//shrink Image
            UIView.animate(withDuration: 0.3, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
            })
        }
        
        
    }
    
    @objc func didTapBackButton() {
       if position > 0 {
           position = position - 1
           player?.stop()
           for subview in holder.subviews {
               subview.removeFromSuperview()
           }
           return configure()
       }
    }
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            return configure()
        }
    }
    
    
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        //adjust player volume
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    


}
