import UIKit
import SDWebImageSVGCoder

class DetailViewController: UIViewController {

    var weatherModel: Weather?

    private let cityNameLabel = UILabel()
    private let wetherImageView = UIImageView()
    private let temp = UILabel()
    private let condition = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupContent()
        setupImage()
    }

    private func setupView() {
        view.backgroundColor = .white
        [cityNameLabel, wetherImageView, temp, condition].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupContent() {
        title = weatherModel?.name
        cityNameLabel.text = weatherModel?.name
        temp.text = "\(weatherModel?.temp ?? 0.0)"
        condition.text = weatherModel?.conditionString
    }

    private func setupImage() {
        guard let icon = weatherModel?.conditionCode else { return }
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg") else { return }

        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)

        wetherImageView.sd_setImage(with: url)
    }

}

extension DetailViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            wetherImageView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 24),
            wetherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wetherImageView.heightAnchor.constraint(equalToConstant: 200),
            wetherImageView.widthAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            temp.topAnchor.constraint(equalTo: wetherImageView.bottomAnchor, constant: 24),
            temp.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            condition.topAnchor.constraint(equalTo: temp.bottomAnchor, constant: 16),
            condition.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
