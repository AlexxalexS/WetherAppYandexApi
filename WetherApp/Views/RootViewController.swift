import UIKit
import CoreLocation

class RootViewController: UIViewController {

    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .large)

    let searchController = UISearchController()

    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    private var citiesArray: [Weather] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private var filteredCitiesArray: [Weather] = []

    private var nameCitiesArray = ["Санкт-Петербург", "Москва", "Салават", "Уфа", "Кострома", "Оренбург"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupTableView()
        addCities()
        setupAnimation()
    }

    private func setupNavigationController() {
        title = "Погода"
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false

        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tappedPlusButton))
        navigationItem.rightBarButtonItem = plusButton
    }

    @objc private func tappedPlusButton() {

        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.spinner.startAnimating()
            self.nameCitiesArray.append(city)
            self.addCities()
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupAnimation() {
        view.addSubview(spinner)
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }

    private func addCities() {
        citiesArray = []
        getCityWeather(citiesArray: nameCitiesArray) { index, weather in
            var item = weather
            item.name = self.nameCitiesArray[index]
            self.citiesArray.append(item)
            if self.nameCitiesArray.count == self.citiesArray.count {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                }
            }

        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

// MARK: - UITableViewDelegate

extension RootViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let weather = isFiltering ? filteredCitiesArray[indexPath.row] : citiesArray[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.weatherModel = weather
        show(detailVC, sender: self)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            if self.isFiltering {
                let editingRow = self.filteredCitiesArray[indexPath.row]
                guard let index = self.filteredCitiesArray.firstIndex(of: editingRow) else { return }

                self.citiesArray = self.citiesArray.filter({ $0.name !=  self.filteredCitiesArray[index].name })
                self.filteredCitiesArray.remove(at: index)
            } else {
                let editingRow = self.citiesArray[indexPath.row]
                guard let index = self.citiesArray.firstIndex(of: editingRow) else { return }
                self.citiesArray.remove(at: index)
            }

            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}

// MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCitiesArray.count
        }
        return citiesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.reuseId,
            for: indexPath
        ) as? WeatherTableViewCell else {
            return WeatherTableViewCell()
        }

        if isFiltering {
            let city = filteredCitiesArray[indexPath.row].name
            let condition = filteredCitiesArray[indexPath.row].conditionString
            let temp = filteredCitiesArray[indexPath.row].temp

            cell.configure(city: city, condition: condition, temperature: String(temp))
        } else {
            let city = citiesArray[indexPath.row].name
            let condition = citiesArray[indexPath.row].conditionString
            let temp = citiesArray[indexPath.row].temp

            cell.configure(city: city, condition: condition, temperature: String(temp))
        }


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

extension RootViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentSearchText(text)
        print(text)
    }

    private func filterContentSearchText(_ searchText: String) {
        filteredCitiesArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }

}
