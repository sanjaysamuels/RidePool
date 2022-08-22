//
//  RideRequestViewController.swift
//  Seeker2
//
//  Created by Jeswin Johncy on 2022-08-13.
//




import UIKit
//import FloatingPanel



class RideRequestViewController: UIViewController //FloatingPanelControllerDelegate
{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
//        let fpc = FloatingPanelController()
//        fpc.delegate = self
        
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? TrackViewController else {
            return
        }
//        fpc.set(contentViewController: contentVC)
//        fpc.addPanel(toParent: self)
        self.navigationController?.pushViewController(contentVC, animated:true)

        
    }
    

}
