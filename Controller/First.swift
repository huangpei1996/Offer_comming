//
//  First.swift
//  Offer_comming
//
//  Created by 雅风 on 2017/5/16.
//  Copyright © 2017年 雅风. All rights reserved.
//

/*
 应用首页
 */

import UIKit

class First: UIViewController {

    @IBAction func go_offer(_ sender: Any) {
        let mystroyBoard = self.storyboard
        
        let anotherView:UIViewController = (mystroyBoard?.instantiateViewController(withIdentifier: "offer"))! as
        UIViewController
        self.present(anotherView,animated: true, completion: nil)
    }
    @IBAction func go_contract(_ sender: Any) {
        let mystroyBoard = self.storyboard
        
        let anotherView:UIViewController = (mystroyBoard?.instantiateViewController(withIdentifier: "contract"))! as
        UIViewController
        self.present(anotherView,animated: true, completion: nil)
    }
    @IBAction func go_havefun(_ sender: Any) {
        let mystroyBoard = self.storyboard
        
        let anotherView:UIViewController = (mystroyBoard?.instantiateViewController(withIdentifier: "havefun"))! as
        UIViewController
        self.present(anotherView,animated: true, completion: nil)
    }
           override func viewDidLoad() {
        super.viewDidLoad()

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
