//
//  ForecastTableViewCell.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {
    static let identifier = "ForecastTableViewCell"
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblAvgTemp: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        lblDate.font = UIFont.preferredFont(forTextStyle: .body)
        lblHumidity.font = UIFont.preferredFont(forTextStyle: .body)
        lblPressure.font = UIFont.preferredFont(forTextStyle: .body)
        lblDescription.font = UIFont.preferredFont(forTextStyle: .body)
        lblAvgTemp.font = UIFont.preferredFont(forTextStyle: .body)
        ivIcon.isAccessibilityElement = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: Forecast) {
        lblDate.text = String(format: "date_label".localized(), item.getDateString())
        lblAvgTemp.text = String(format: "avg_temp_label".localized(), item.getAvgTemp())
        lblPressure.text = String(format: "pressure_label".localized(), item.getPressure())
        lblHumidity.text = String(format: "humidity_label".localized(), item.getHumidity())
        
        accessibilityLabel = String(format: "cell_accessbility".localized(), item.getDateString(), item.getAvgTemp(), item.getPressure(), item.getHumidity(), item.forecastDescription());
        
        lblDescription.text = String(format: "description_label".localized(), item.forecastDescription())
        ivIcon.sd_setImage(with: item.getIconUrl(), placeholderImage: nil, options: [.progressiveLoad])
        ivIcon.accessibilityLabel = item.forecastDescription()
    }
}
