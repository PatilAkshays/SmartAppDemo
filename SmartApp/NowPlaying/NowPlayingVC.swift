//
//  NowPlayingVC.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//
import UIKit

class NowPlayingVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var nowPlayingViewModel: NowPlayingViewModel!
    
    var movieList: [MovieDetails] = []
    var filteredMovielist: [MovieDetails] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.addSubview(self.refreshControl)

        self.fetchNowPlayingMovieList()
        self.addSearchBarToNaviagationBar()

        // Do any additional setup after loading the view.
    }
    
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)

    func addSearchBarToNaviagationBar() {
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .black
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    
    //Refresh Loader Method
       private lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
               #selector(self.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.red
           
           return refreshControl
       }()
       
       //Refresh Control Event/Action
       @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
            self.fetchNowPlayingMovieList()
       }

    
     private func fetchNowPlayingMovieList(){
            
        if Connectivity.isConnectedToInternet(){
            self.showLoading()
            self.nowPlayingViewModel?.requestNowPlayingMovieList(completion: { (response) in
                self.hideLoading()
                self.refreshControl.endRefreshing()

                if self.nowPlayingViewModel!.isNowPlayingMovieSuccess(){
                    self.movieList = []
                    self.filteredMovielist = []
                    self.movieList = response.movieList
                    self.filteredMovielist = self.movieList

                    self.collectionView.reloadData()
                }else{
                    print("Error + ",self.nowPlayingViewModel!.getNowPlayingMovieSuccessMsg())
                    self.showAlertWithAction(msg: self.nowPlayingViewModel!.getNowPlayingMovieSuccessMsg())

                }
            });
            
        }else{
                self.showAlertWithAction(msg: "Please Connect with Internet.")
                
            }
            
        }
    
    
    
    @objc func tableViewTapped(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let path = self.collectionView.indexPathForItem(at: location)
        if let indexPathForRow = path {
            self.showAlertWithDeleteMessage(msg: "Do you wnat to delete selected selected Movie?", index: indexPathForRow.row)
        }
    }
    
    
    //Method to display Action Alert
   private func showAlertWithDeleteMessage(msg: String, index: Int) {
          let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
          
          alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { action in
            self.filteredMovielist.remove(at: index)
            self.collectionView.deleteItems(at: [IndexPath.init(row: index, section: 0)])
              alert.dismiss(animated: true, completion: nil)
          }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
          
          // show the alert
          self.present(alert, animated: true, completion: nil)
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

extension NowPlayingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filteredMovielist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
       
        let movieDetails = self.filteredMovielist[indexPath.row]
       
        cell.movieTitleLabel.text = movieDetails.title
        cell.movieDescLabel.text = movieDetails.overview
        
        let tapGestureView = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped(_:)))
        tapGestureView.numberOfTapsRequired = 1
        cell.trashButton.addGestureRecognizer(tapGestureView)
        
        
        let url = NSURL(string: "\(String.moviePoster)\(movieDetails.poster_path ?? "")")
        
        cell.imageView!.sd_setImage(with: (url! as URL), placeholderImage: UIImage.init(named: "placeholder_Img"), options: [], progress: { (i, j, url) in

        }) { (image, error, cacheType, imageURL) in
            
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.SCREEN_WIDTH, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let movieDetailsVC = storyBoard.instantiateViewController(withIdentifier:"MovieDetailsVC") as! MovieDetailsVC
        movieDetailsVC.movieDetails = self.filteredMovielist[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

extension NowPlayingVC: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        filteredMovielist = searchText.isEmpty ? movieList : movieList.filter {
            
            return $0.title!.range(of: searchText, options: .caseInsensitive) != nil
        }
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            print("Backspace was pressed")
            return true
        }
        return true
        
    }
    
}
