//
//  MapView.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes  on 11/11/25.
//

import UIKit
import MapKit

class MapView: UIView {
    // --- Define elements --- //
    var mapView:MKMapView!
    var buttonLoading:UIButton!
    var buttonCurrentLocation:UIButton!
    var buttonSearch:UIButton!
    var buttonLegend:UIButton!
    
    // --- Setup elements and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupMapView()
        setupButtonLoading()
        setupButtonCurrentLocation()
        setupButtonSearch()
        setupButtonLegend()
        initConstraints()
    }
    
    // --- Setup Functions --- //
    func setupMapView(){
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        mapView.showsUserLocation = true
        self.addSubview(mapView)
    }
    func setupButtonLoading(){
        buttonLoading = UIButton(type: .system)
        buttonLoading.setTitle(" Loading ... ", for: .normal)
        buttonLoading.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonLoading.setImage(UIImage(systemName: "circle.dotted"), for: .normal)
        buttonLoading.layer.backgroundColor = UIColor.black.cgColor
        buttonLoading.tintColor = .white
        buttonLoading.layer.cornerRadius = 10
        buttonLoading.layer.shadowOffset = .zero
        buttonLoading.layer.shadowRadius = 4
        buttonLoading.layer.shadowOpacity = 0.7
        buttonLoading.translatesAutoresizingMaskIntoConstraints = false
        buttonLoading.isEnabled = false
        self.addSubview(buttonLoading)
    }
    func setupButtonCurrentLocation(){
        buttonCurrentLocation = UIButton(type: .system)
        buttonCurrentLocation.setImage(UIImage(systemName: "location.circle"), for: .normal)
        buttonCurrentLocation.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        buttonCurrentLocation.tintColor = .darkGray
        buttonCurrentLocation.layer.cornerRadius = 10
        buttonCurrentLocation.layer.shadowOffset = .zero
        buttonCurrentLocation.layer.shadowRadius = 4
        buttonCurrentLocation.layer.shadowOpacity = 0.4
        buttonCurrentLocation.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCurrentLocation)
    }
    func setupButtonSearch(){
        buttonSearch = UIButton(type: .system)
        buttonSearch.setTitle(" Search places...  ", for: .normal)
        buttonSearch.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonSearch.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        buttonSearch.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        buttonSearch.tintColor = .darkGray
        buttonSearch.layer.cornerRadius = 10
        buttonSearch.layer.shadowOffset = .zero
        buttonSearch.layer.shadowRadius = 4
        buttonSearch.layer.shadowOpacity = 0.4
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.isHidden = true
        self.addSubview(buttonSearch)
    }
    func setupButtonLegend(){
        buttonLegend = UIButton(type: .system)
        buttonLegend.setImage(UIImage(systemName: "info.circle"), for: .normal)
        buttonLegend.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        buttonLegend.tintColor = .darkGray
        buttonLegend.layer.cornerRadius = 10
        buttonLegend.layer.shadowOffset = .zero
        buttonLegend.layer.shadowRadius = 4
        buttonLegend.layer.shadowOpacity = 0.4
        buttonLegend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLegend)
    }
    
    // --- Constratins --- //
    func initConstraints(){
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            mapView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            mapView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.95),
            
            buttonLoading.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            buttonLoading.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            buttonLoading.widthAnchor.constraint(equalToConstant: 240),
            buttonLoading.heightAnchor.constraint(equalToConstant: 40),
            
            buttonCurrentLocation.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -8),
            buttonCurrentLocation.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -8),
            buttonCurrentLocation.heightAnchor.constraint(equalToConstant: 36),
            buttonCurrentLocation.widthAnchor.constraint(equalToConstant: 36),
            
            buttonSearch.bottomAnchor.constraint(equalTo: buttonCurrentLocation.bottomAnchor),
            buttonSearch.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSearch.heightAnchor.constraint(equalTo: buttonCurrentLocation.heightAnchor),
            
            buttonLegend.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 4),
            buttonLegend.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: 8),
            buttonLegend.heightAnchor.constraint(equalToConstant: 36),
            buttonLegend.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

