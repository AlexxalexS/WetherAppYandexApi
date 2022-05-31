import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let reuseId = "WeatherTableViewCell"

    private let city: UILabel = {
        let city = UILabel()
        city.textColor = .label
        city.text = ""
        city.translatesAutoresizingMaskIntoConstraints = false
        return city
    }()

    private let condition: UILabel = {
        let temperature = UILabel()
        temperature.textColor = .secondaryLabel
        temperature.font = UIFont.systemFont(ofSize: 12, weight: .light)
        temperature.text = ""
        temperature.translatesAutoresizingMaskIntoConstraints = false
        return temperature
    }()

    private let temperature: UILabel = {
        let temperature = UILabel()
        temperature.textColor = .label
        temperature.text = ""
        temperature.translatesAutoresizingMaskIntoConstraints = false
        return temperature
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    public func configure(city: String, condition: String, temperature: String) {
        self.city.text = city
        self.condition.text = condition
        self.temperature.text = temperature + " ℃"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        city.text = nil
        condition.text = nil
        temperature.text = nil
    }

    private func setupView() {
        contentView.addSubview(city)
        contentView.addSubview(condition)
        contentView.addSubview(temperature)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

}

// MARK: - Setup Constraints
extension WeatherTableViewCell {

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            city.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            city.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            temperature.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            temperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            temperature.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            condition.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            condition.trailingAnchor.constraint(equalTo: temperature.leadingAnchor, constant: -8),
            condition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

}
