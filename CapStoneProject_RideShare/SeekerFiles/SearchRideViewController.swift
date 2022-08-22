import UIKit


class SearchRideViewController: UIViewController {

    
    
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
    
    var filteredData: [String]!
    
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title="RidePool"

        filteredData = data
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    
}


extension SearchRideViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRide = filteredData[indexPath.row] // the ride you selected
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "RideDetail") as! RideDetailViewController
            detailVC.ride = selectedRide
            detailVC.time = dataMetaTime[indexPath.row]
            detailVC.provider = dataMetaProvider[indexPath.row]
            detailVC.vehicle = dataMetaVehicle[indexPath.row]
            detailVC.modalPresentationStyle = .fullScreen
            //present(detailVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(detailVC, animated:true)
        }
}


extension SearchRideViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        }
        
        for word in data {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredData.append(word)
            }
        }
        
        self.tableView.reloadData()
    }
}

