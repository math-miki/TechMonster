
//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by Miki Takahashi on 2019/04/12.
//  Copyright © 2019 MikiTakahashi. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    var maxStamina: Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    var staminaTimer: Timer!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", player.level)
        
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
        
        staminaTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cureStamina), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TechDraUtil.stopBGM()
    }
    
    @objc func cureStamina() {
        if stamina < maxStamina {
            stamina = min(stamina+1, maxStamina)
            staminaBar.progress = stamina / maxStamina
        }
    }
    
    @IBAction func startBattle() {
        if stamina >= 20 {
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startBattle", sender: nil)
        } else {
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが20以上必須です", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startBattle" {
            let battleVC = segue.destination as! BattleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
        }
    }

}
