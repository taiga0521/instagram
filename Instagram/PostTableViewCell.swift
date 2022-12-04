//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 上田大河 on 2022/11/26.
//

import UIKit
import FirebaseStorageUI
import SVProgressHUD

class PostTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var myPageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setPostData(_ postData: PostData) {
        //画面の表示
        //SDWebImageActivityIndicator.gray = グレーのぐるぐる回るアイコン
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        var allComment = self.commentLabel.text!
        
        if postData.comments.isEmpty == true {
            self.commentLabel.text! = "コメントなし"
            self.commentLabel.textColor = .gray
        } else {
            allComment.removeAll()
            self.commentLabel.textColor = .black
            
            if postData.comments.count == 1 {
                self.commentLabel.text! = postData.comments.first!
            } else {
                allComment.removeAll()
                for comment in postData.comments.prefix(postData.comments.count - 1) {
                    allComment += comment
                    allComment += "\n"
                    self.commentLabel.text! = allComment
                }
                let lastLine = postData.comments.last!
                allComment += lastLine
                self.commentLabel.text! = allComment
            }
        }
        
        //日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
    @IBAction func commentButton(_ sender: Any) {
        
        }
    
}
