//
//  TestViewController.swift
//  VKApp
//
//  Created by User on 13.02.2021.
//

import UIKit

class LoadingViewController: UIViewController {

    
    @IBOutlet weak var loadingIndicator: LoadingIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadingIndicator.isLoading = false
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let targetTabBarController = storyBoard.instantiateViewController(identifier: "TabBarController")
        self.present(targetTabBarController, animated: true, completion: nil)
        
    }

}
