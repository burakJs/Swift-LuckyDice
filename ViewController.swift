//
//  ViewController.swift
//  LuckyDice
//
//  Created by Burak İmdat on 2.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblOyuncu1Skor: UILabel!
    @IBOutlet weak var lblOyuncu2Skor: UILabel!
    @IBOutlet weak var lblOyuncu1Puan: UILabel!
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    @IBOutlet weak var imgOyuncu1Durum: UIImageView!
    @IBOutlet weak var imgOyuncu2Durum: UIImageView!
    @IBOutlet weak var imgZar1: UIImageView!
    @IBOutlet weak var imgZar2: UIImageView!
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0, ikinciOyuncuPuanlari : 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru : 0, ikinciOyuncuSkoru : 0)
    var oyuncuSira : Int = 1
    
    var maxSetSayisi : Int = 5
    var suankiSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        Closure
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            print("1. kod satırı çalıştı")
//        }
//        print("2. kod satırı çalıştı")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            print("3. kod satırı çalıştı")
//        }
        
        if let arkaPlan = UIImage(named: "arkaPlan") {
            self.view.backgroundColor = UIColor(patternImage: arkaPlan)
        }
        
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if suankiSet > maxSetSayisi {
            return
        }
        zarDegerleriniUret()
    }
    
    func setSonucu(zar1 : Int, zar2 : Int){
        if oyuncuSira == 1 {
            //Yeni set başlamıştır
            
            oyuncuPuanlari.birinciOyuncuPuani = zar1 + zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.birinciOyuncuPuani)
            imgOyuncu1Durum.image = UIImage(named: "bekle")
            imgOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2. Oyuncuda"
            oyuncuSira = 2
            lblOyuncu2Puan.text = "0"
            
        } else {
            oyuncuPuanlari.ikinciOyuncuPuanlari = zar1 + zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.ikinciOyuncuPuanlari)
            imgOyuncu1Durum.image = UIImage(named: "onay")
            imgOyuncu2Durum.image = UIImage(named: "bekle")
            lblSetSonucu.text = "Sıra 1. Oyuncuda"
            oyuncuSira = 1
            // Set bitirme işlemleri
            
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuanlari {
                //1. oyuncu kazandı
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 1. oyuncu kazandı"
                suankiSet += 1
                lblOyuncu1Skor.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
            } else if oyuncuPuanlari.ikinciOyuncuPuanlari > oyuncuPuanlari.birinciOyuncuPuani {
                oyuncuSkorlari.ikinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 2. oyuncu kazandı"
                suankiSet += 1
                lblOyuncu2Skor.text = String(oyuncuSkorlari.ikinciOyuncuSkoru)
            } else {
                // Oyun berabere
                lblSetSonucu.text = "\(suankiSet). Set Berabere"
            }
            
            oyuncuPuanlari.birinciOyuncuPuani = 0
            oyuncuPuanlari.ikinciOyuncuPuanlari = 0
        }
    }
    
    func zarDegerleriniUret(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let zar1 = arc4random_uniform(6) + 1
            let zar2 = arc4random_uniform(6) + 1
            
            self.imgZar1.image = UIImage(named: String(zar1))
            self.imgZar2.image = UIImage(named: String(zar2))
            
            self.setSonucu(zar1: Int(zar1), zar2: Int(zar2))
            
            if self.suankiSet > self.maxSetSayisi {
                if self.oyuncuSkorlari.birinciOyuncuSkoru > self.oyuncuSkorlari.ikinciOyuncuSkoru {
                    self.lblSetSonucu.text = "Oyunun galibi 1. oyuncu"
                } else {
                    self.lblSetSonucu.text = "Oyunun galibi 2. oyuncu"
                }
            }
        }
        
        lblSetSonucu.text = "\(oyuncuSira). Oyuncu zar atıyor"
        imgZar1.image = UIImage(named: "bilinmeyenZar")
        imgZar2.image = UIImage(named: "bilinmeyenZar")
    }
}

