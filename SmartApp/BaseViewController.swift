//
//  BaseViewController.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//


import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //Method to display Action Alert
    func showAlertWithAction(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //Method to display Action Alert 
    func showAlertWithTitle(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //Method to display Loader
    func showLoading() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading"
        
    }
    
    //Method to hide Loader
    func hideLoading() {
        
        MBProgressHUD.hide(for: self.view, animated: true)
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
extension String {
    public static let moviePoster = "https://image.tmdb.org/t/p/w342"
    public static let backDrop = "https://image.tmdb.org/t/p/original"

    static let dateFormatter = "MMMM dd, yyyy"

}

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

extension UIViewController {
    
    func changeDateFormatWith(selectedDate: String, formatter : String) -> String{
        
        let dateFormatter = DateFormatter()
        
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date : Date = dateFormatter.date(from: selectedDate)!
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        if dateString == nil{
            return ""
        }
        return dateString;
    }
}
