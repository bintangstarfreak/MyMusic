//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Bintang Aria Ramadhan on 20/03/21.
//  Copyright © 2021 Starfreak. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 1 {
            configure() //lalu buat func configure
        }
    }
    
    func configure() {
        //set up player
        
        
        //set up user interface element atau tampilan
    }
    


}
