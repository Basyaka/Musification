//
//  ArtistsViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit

class ArtistsViewController: UIViewController {
    
    var didSendEventClosure: ((ArtistsViewController.Event) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArtistsViewController {
    enum Event {
        case artists
    }
}
