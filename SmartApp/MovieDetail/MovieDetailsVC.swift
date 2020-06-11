//
//  MovieDetailsVC.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsVC: BaseViewController {
  
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var imageView: SDAnimatedImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!

    var movieDetails: MovieDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.checkDeviceTypeAndUpdateUIConstraint()
        
        self.displayPosterImageAsBackground()
        
        self.movieTitleLabel.text = movieDetails!.title
        self.movieDescLabel.text = movieDetails!.overview
        self.dateLabel.text = self.changeDateFormatWith(selectedDate: movieDetails!.release_date!, formatter: .dateFormatter)
        self.voteAverageLabel.text = "\(Int(movieDetails!.vote_average * 10)) %"
        self.timeIntervalLabel.text = "0 hr 0 min"

        
        
        // Do any additional setup after loading the view.
    }
    

   private func checkDeviceTypeAndUpdateUIConstraint() -> Void {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            self.topContraint.constant = 310
        case .pad:
           self.topContraint.constant = 450
        case .unspecified:
            print("unspec")
        default:
            print("default")
            
            break
        }
    }
    
   private func displayPosterImageAsBackground() -> Void {
        //        let url = NSURL(string: "\(String.backDrop)\(movieDetails!.backdrop_path ?? "")")

        let url = NSURL(string: "\(String.moviePoster)\(movieDetails!.poster_path ?? "")")

        self.imageView!.sd_setImage(with: (url! as URL), placeholderImage: UIImage.init(named: "placeholder_Img"), options: [], progress: { (i, j, url) in
            
        }) { (image, error, cacheType, imageURL) in
            
        }
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
