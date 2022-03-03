//
//  ViewController.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    private var viewModel = WeatherViewModel()
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private var observer: NSKeyValueObservation?
    private var forecastObserver: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    private func setupView() {
        loadingIndicator.isHidden = true
        tblView.register(UINib(nibName: ForecastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ForecastTableViewCell.identifier)
        tblView.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        
    }
    
    private func setupBinding() {
        observer = viewModel.observe(\WeatherViewModel.isLoading, options: .new, changeHandler: {[weak self] model, info in
            DispatchQueue.main.async {
                self?.loadingIndicator.isHidden = !model.isLoading
            }
        })
        forecastObserver = viewModel.observe(\WeatherViewModel.forecastDay, options: .new, changeHandler: {[weak self] model, info in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        })
    }
    deinit {
        observer = nil
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell, let item = viewModel.forecastAtIndex(index: indexPath.row) {
            cell.configure(item: item)
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text, viewModel.isValidTerm(term: term) {
            viewModel.getCityForecast(term: term)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
}
