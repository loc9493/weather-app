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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: Forecast) {
        lblDate.text = String(format: "date_label".localized(), item.getDateString())
        lblAvgTemp.text = String(format: "avg_temp_label".localized(), String(item.temp.day))
        lblPressure.text = String(format: "pressure_label".localized(), String(item.pressure))
        lblHumidity.text = String(format: "humidity_label".localized(), String(item.humidity))
        if let desc = item.forecastDescription() {
            lblDescription.text = String(format: "description_label".localized(), desc)
        }
        ivIcon.sd_setImage(with: item.getIconUrl(), placeholderImage: nil, options: [.progressiveLoad])
    }
}
