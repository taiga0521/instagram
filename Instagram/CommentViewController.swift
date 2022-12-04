//
//  CommentViewController.swift
//  Instagram
//
//  Created by 上田大河 on 2022/11/27.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var postData: PostData!
    
    
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        imageView.sd_setImage(with: imageRef)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //コメントを押した時に呼び出させるメソッド
    @IBAction func commentButton(_ sender: Any) {
        if let comment = commentTextField.text {
            if comment.isEmpty {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }
        }
        
        //HUDで投稿完了を表示す
        SVProgressHUD.showSuccess(withStatus: "コメントを送信しました")
        //投稿処理が完了したので先頭画面に戻る
        //rootViewControllerは先頭画面に戻るやつ！
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        let name = Auth.auth().currentUser?.displayName
        let comment = self.commentTextField.text
        let commentName = "\(name!) : \(comment!)"
        //postData.comments.append("\(name!) : \(comment!)\n")
        
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion(["\(commentName)"])
        
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": updateValue])
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
