//
//  MypageViewController.swift
//  Instagram
//
//  Created by 上田大河 on 2022/12/04.
//

import UIKit
import Firebase
import SVProgressHUD

class MypageViewController: UIViewController {
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    
    
    var postData: PostData!

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Auth.auth().currentUser?.displayName
        self.myNameLabel.text = "\(name!)"

        // Do any additional setup after loading the view.
    }
    @IBAction func optionButton(_ sender: Any) {
        print("DEBUG_PRINT: mypageoptionがタップされました。")
        
        let mypageoptionViewController = storyboard!.instantiateViewController(withIdentifier: "mypageoption") as! MypageOptionViewController
        present(mypageoptionViewController, animated: true)
    }
    
    
}
