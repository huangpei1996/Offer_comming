//
//  Havefun.swift
//  Offer_comming
//
//  Created by 雅风 on 2017/5/18.
//  Copyright © 2017年 雅风. All rights reserved.
//
/*
 奖状的展示选择页
 */
import UIKit

class Havefun: UIViewController {

    var pageControl:UIPageControl?
    var collectionView: UICollectionView!
    let width:CGFloat = 200
    let image_arr = ["1","2","3"]
    var count = 1
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = CardLayout()
        layout.scale = 1.1
        layout.itemSize = CGSize(width: 300, height: 200)
        
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: view.bounds.width, height: view.bounds.height-40), collectionViewLayout: layout)
        
        collectionView.allowsSelection = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let imageView_background = UIImageView(frame: CGRect(x: 0,y: 0,width: view.bounds.width, height: view.bounds.height))
        //添加图片
        imageView_background.image=UIImage(named: "background")
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        collectionView.backgroundView?.addSubview(imageView_background)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        let button = UIButton(frame:CGRect(x:10, y:view.bounds.height-30, width:50, height:30))
        button.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        
        
        view.addSubview(collectionView)
        view.addSubview(button)
    }
    func tapped(){
        dismiss(animated: true, completion: nil) 
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension Havefun: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.backgroundColor =
            indexPath.item%2==0 ? UIColor(white: 1, alpha: 0) : UIColor(white: 1, alpha: 0)
        
        
        //创建imageView
        let imageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 300, height: 200))
        //添加图片
        imageView.layer.masksToBounds = true;
        imageView.layer.cornerRadius = 10
        imageView.image=UIImage(named: String(indexPath.item+1))
        //打开用户交互
        imageView.isUserInteractionEnabled = true
        
        
        //把imageView添加到滚动视图上
        cell.addSubview(imageView)
        print("indexPath",indexPath.item)
        
        
        
        return cell
    }
    // MARK: UICollectionViewDelegate的代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("(\((indexPath as NSIndexPath).section), \((indexPath as NSIndexPath).row))")
        var count = String(indexPath.row+1)
        let defaults = UserDefaults()
        
        defaults.set(count, forKey: "count")
        
        let mystroyBoard = self.storyboard
        
        let anotherView:UIViewController = (mystroyBoard?.instantiateViewController(withIdentifier: "havefundisplay"))! as
        UIViewController
        let display = Display()
        //display.string = String(indexPath.row+1)
        
        
        self.present(anotherView,animated: true, completion: nil)
        
    }
    
}
