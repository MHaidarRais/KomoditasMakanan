//
//  detailViewController.swift
//  KomoditasMakanan
//
//  Created by Haidar Rais on 11/8/17.
//  Copyright © 2017 Haidar Rais. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var labelkomoditas: UILabel!
    @IBOutlet weak var labelunit: UILabel!
    @IBOutlet weak var labelmangkukna: UILabel!
    @IBOutlet weak var labelkamari: UILabel!
    @IBOutlet weak var labelayena: UILabel!
    
    var passkomoditas:String?
    var passunit:String?
    var passmangkukna:String?
    var passkamari:String?
    var passayena:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelkomoditas.text = passkomoditas
        labelunit.text = passunit
        labelmangkukna.text = passmangkukna
        labelkamari.text = passkamari
        labelayena.text = passayena

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
