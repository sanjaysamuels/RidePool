//
//  TrackViewController.swift
//  Seeker2
//
//  Created by Jeswin Johncy on 2022-08-12.
//

import UIKit


class TrackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dateField: UIDatePicker!
    
    var date = Date()
    
    

    @IBAction func datePickerChanged(_ sender: Any) {
        date = dateField.date
    }
    
    
    @IBAction func submitBtn(_ sender: UIButton) {

        let requestSubmitVC = storyboard?.instantiateViewController(withIdentifier: "RideRequestSubmit") as! RideRequestSubmitConfirmViewController
            requestSubmitVC.source = srcField.text!
            requestSubmitVC.dest = destField.text!
            requestSubmitVC.date = date
            //detailVC.modalPresentationStyle = .fullScreen
            //present(detailVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(requestSubmitVC, animated:true)
    }
    @IBOutlet weak var srcField: UITextField!
    
    @IBOutlet weak var destField: UITextField!
    @IBOutlet var myTableView: UITableView!
    
    let data = [
        "Kitchener -> Waterloo",
        "Waterloo -> Bramlea",
        "Bramlea -> Brampton",
        "Kitchener -> Toronto",
        "Cambridge -> Waterloo",
        "Toronto -> Bramlea",
        "Doon -> Waterllo",
        "Guelph -> Brampton",
        "Mississauga -> Doon",
    ]
    
    let dataMetaTime = [
        "2:30pm Today",
        "3:30pm Today",
        "4:00pm Today",
        "4:30pm Today",
        "9:30pm Tommorrow",
        "10:00am Tommorrow",
        "10:15am Tommorrow",
        "10:45am Tommorrow",
        "2:00pm Tommorrow",
    ]
    
    let dataMetaProvider = [
        "David Morgan",
        "John Stanly",
        "Harry James",
        "Ben McKean",
        "Kate April",
        "John Stanly",
        "Harry James",
        "April Adams",
        "Jordan Ish",
    ]
    
    let dataMetaVehicle = [
        "Tesla X",
        "Honda Accord",
        "Tesla Y",
        "1893 Shamrock",
        "Honda City",
        "Bricklin SV-1",
        "Chevrole 1500 Extended Cab",
        "GMC 2500 Crew Cab",
        "Nissan 300ZX",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateField.minimumDate = date
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=data[indexPath.row]+" | "+dataMetaTime[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRide = data[indexPath.row] // the ride you selected
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "RideDetail") as! RideDetailViewController
            detailVC.ride = selectedRide
            detailVC.time = dataMetaTime[indexPath.row]
            detailVC.provider = dataMetaProvider[indexPath.row]
            detailVC.vehicle = dataMetaVehicle[indexPath.row]
            //detailVC.modalPresentationStyle = .fullScreen
            //present(detailVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(detailVC, animated:true)
        }
      @objc func goDetail(){
          guard let vc = storyboard?.instantiateViewController(identifier: "RideDetail") as? RideDetailViewController else {
              return
          }
          //present(vc, animated: true, completion: nil)

          self.navigationController?.pushViewController(vc, animated:true)
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
