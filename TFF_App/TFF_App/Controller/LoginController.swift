//
//  LoginController.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-21.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var signUpField: UITextField!
    @IBOutlet weak var username: UITextField!;
    @IBOutlet weak var password: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attribString = NSMutableAttributedString(string: "S'inscrire !")
        let url = "https://google.ca"
        
        attribString.setAttributes([.link: url], range: NSMakeRange(5, 10))
        
        signUpField.attributedText = attribString
        signUpField.isUserInteractionEnabled = true;
    }
    
    
    
    
    
    @IBAction func connection(_ sender: UIButton) {
    }
    
    
    
}
