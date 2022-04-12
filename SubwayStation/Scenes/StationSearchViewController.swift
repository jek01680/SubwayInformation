//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 정은경 on 2022/04/11.
//

import SnapKit
import UIKit
import Alamofire

class StationSearchViewController: UIViewController {
    private var stations:[Station] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        setTableViewLayout()
        
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }

    private func setTableViewLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    
    private func requestStationName(from stationName: String){
        let urlString = "http://openAPI.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        
        //한글깨짐 방지
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result
                else { return }
                
                self.stations = data.stations
                self.tableView.reloadData()

            }
            .resume()
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = station.stationName
        content.secondaryText = station.lineNumber
        cell.contentConfiguration = content
        
        return cell
    }
    
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc = StationListViewController(station: station)
        navigationController?.pushViewController(vc, animated: true)
    }
}


