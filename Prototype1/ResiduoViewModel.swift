//
//  ResiduoViewModel.swift
//  Prototype1
//
//  Created by Josue Galindo on 16/09/24.
//
import SwiftUI
import CoreLocation
import UIKit

class DonateClothesViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var clothType: String = "Camisa"
    @Published var size: String = ""
    @Published var contactInfo: String = ""
    @Published var location: CLLocation?
    @Published var image: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var clothTypes: [String] = ["Camisa", "Pantalones", "Chaqueta", "Zapatos", "Otros"]
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            location = firstLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }
    
    func sendDonation() {
        // Aquí puedes manejar el envío de la información de donación
        print("Tipo de ropa: \(clothType)")
        print("Talla: \(size)")
        print("Contacto: \(contactInfo)")
        if let location = location {
            print("Ubicación: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
        if let image = image {
            print("Foto seleccionada")
        }
    }
}

