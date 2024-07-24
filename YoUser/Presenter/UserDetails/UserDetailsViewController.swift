//
//  UserDetailsViewController.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import UIKit
import MapKit

final class UserDetailsViewController: UIViewController {
    
    private let viewModel: UserDetailViewModeling
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    
    init(viewModel: UserDetailViewModeling){//, updateUsersSubject: PassthroughSubject<Void, Never>?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        nameLabel.text = viewModel.fullname
    }
    
    private func configureMapView(){
        let location = viewModel.location
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "User Location"
        mapView.addAnnotation(annotation)
    }
    
}
