//
//  ViewController.swift
//  AlertController
//
//  Created by Himanshu Ingole3 on 10/15/18.
//  Copyright © 2018 Himanshu Ingole3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func alertControllerTapped(_ sender: Any) {
        
        
        let actionItem1 = AlertAction(title: "Ok",
                                      tapAction: nil)
        let actionItem2 = AlertAction(title: "Cancel",
                                      tapAction: nil)
        let actionItem3 = AlertAction(title: "Edit",
                                      tapAction: nil)
        let actionItem4 = AlertAction(title: "Delete",
                                      tapAction: nil)
        let alertViewModel = AlertViewModel(title: "Motivational Quotes",
                                            message: "Be Impeccable With Your Word. Speak with integrity. Say only what you mean. Avoid using the word to speak against yourself or to gossip about others. Use the power of your word in the direction of truth and love.",
                                            numberOfButtonInRow: 2,
                                            actions: [actionItem1,
                                                      actionItem2,
                                                      actionItem3,
                                                      actionItem4])

        let vc = AlertController(viewModel: alertViewModel)
        present(vc,
                animated: true,
                completion: nil)
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
