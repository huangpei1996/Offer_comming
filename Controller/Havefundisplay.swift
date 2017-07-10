//
//  Havefundisplay.swift
//  Offer_comming
//
//  Created by 雅风 on 2017/5/18.
//  Copyright © 2017年 雅风. All rights reserved.
//

import UIKit

class Havefundisplay: UIViewController,UITextViewDelegate {
    var imagePickerController =  UIImagePickerController()
    
    var imagePickerController_2 = UIImagePickerController()	// 图片控件
    @IBOutlet weak var Image_2: UIImageView!
   
    @IBOutlet weak var tv_title: UITextView!

    @IBOutlet weak var tv_name: UITextView!
    @IBOutlet weak var tv_text1: UITextView!
    @IBOutlet weak var tv_text2: UITextView!
    @IBOutlet weak var tv_name2: UITextView!
    @IBOutlet weak var tv_date: UITextView!
    @IBAction func Image_get(_ sender: Any) {
        present(selectorController, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil) 
    }
    
    @IBAction func share(_ sender: Any) {
        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupport() {
            let alertVC = UIAlertController(title: "提示", message: "分享到", preferredStyle: UIAlertControllerStyle.actionSheet)
            let acSure = UIAlertAction(title: "好友", style: UIAlertActionStyle.destructive) { (UIAlertAction) -> Void in
                
                let image = UIImage(fromView: self.View_2)
                self.sendImage(image: image!, inScene: WXSceneSession)
                print("click Sure")
            }
            let acSure_2 = UIAlertAction(title: "朋友圈", style: UIAlertActionStyle.destructive) { (UIAlertAction) -> Void in
                let image = UIImage(fromView: self.View_2)
                self.sendImage(image: image!, inScene: WXSceneTimeline)
                print("click Sure")
            }
            let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
                print("click Cancel")
            }
            alertVC.addAction(acSure)
            alertVC.addAction(acSure_2)
            alertVC.addAction(acCancel)
            self.present(alertVC, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertView.init(title: "分享失败",
                                         message: "您没有安装微信或者微信版本过低",
                                         delegate: self,
                                         cancelButtonTitle: "好的")
            alert.show()
    }
    }
    @IBOutlet weak var View_2: UIView!
    @IBAction func download(_ sender: Any) {
        let image = UIImage(fromView: View_2)
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil) // 把截取到的图像保存到相册中
        // 最后提示用户保存成功即可
        let alert = UIAlertView.init(title: "存储照片成功",
                                     message: "您已将照片存储于图片库中，打开照片程序即可查看。",
                                     delegate: self,
                                     cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBOutlet weak var Image_3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_title.delegate = self
        tv_name.delegate = self
        tv_text1.delegate = self
        tv_text2.delegate = self
        tv_date.delegate = self
        tv_name2.delegate = self
        Image_3.layer.masksToBounds = true;
        Image_3.layer.cornerRadius = Image_3.frame.size.width/2
        
        let defaults = UserDefaults()
        let count = defaults.object(forKey: "count") as! String!
        
        Image_2.image = UIImage(named: count!)
        print("string",count)
        // Do any additional setup after loading the view.
    }
    private func sendImage(image: UIImage, inScene: WXScene) -> Bool {
        let ext = WXImageObject()
        ext.imageData = UIImagePNGRepresentation(image)
        let message=WXMediaMessage()
        message.title=nil
        message.description=nil
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.draw(in: CGRect(x:0, y:0, width:100, height:100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage!)
        
        let req=SendMessageToWXReq()
        req.text=nil
        req.message=message
        req.bText=false
        // 分享到微信的场景
        req.scene = Int32(inScene.rawValue)
        
        return WXApi.send(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
            textView.text = ""
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = -150
        })
        
        
        
        print("2 textViewDidBeginEditing")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("4 textView")
        
        print("text：\(textView.text) length = \(textView.text?.characters.count)")
        
        // 回车时退出编辑
        if text == "\n"
        {
            //            textView.endEditing(true)
            // 或
            //            self.view.endEditing(true)
            // 或
            textView.resignFirstResponder()
            //键盘收回，view放下
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y = 0
            })
            return true
        }
        return true
    }
   
    
    
    
    
    
}
//MARK: 扩展图片选择和结果返回
extension Havefundisplay: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: 图片选择器界面
    // MARK: 用于弹出选择的对话框界面
    var selectorController: UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil)) // 取消按钮
        controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
            self.selectorSourceType(.camera)
        }) // 拍照选择
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in
            self.selectorSourceType_2(.photoLibrary)
        }) // 相册选择
        return controller
    }
    func selectorSourceType(_ type: UIImagePickerControllerSourceType) {
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        // 打开图片选择器
        present(imagePickerController, animated: true, completion: nil)
    }
    func selectorSourceType_2(_ type: UIImagePickerControllerSourceType) {
        imagePickerController_2.sourceType = type
        imagePickerController_2.delegate = self
        // 打开图片选择器
        present(imagePickerController_2, animated: true, completion: nil)
    }

    
    // MARK: 当图片选择器选择了一张图片之后回调
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true, completion: nil) // 选中图片, 关闭选择器...这里你也可以 picker.dismissViewControllerAnimated 这样调用...但是效果都是一样的...
        
        Image_3.image = info[UIImagePickerControllerOriginalImage] as? UIImage // 显示图片
        Image_3.contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
    }
    
    // MARK: 当点击图片选择器中的取消按钮时回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) // 效果一样的...
    }
}

