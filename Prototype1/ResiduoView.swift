import SwiftUI
import MapKit

class DonateClothesViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var clothType: String = "Camisa"
    @Published var size: String = ""
    @Published var contactInfo: String = ""
    @Published var location: CLLocation?
    @Published var image: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var clothTypes: [String] = ["Camisa", "Jeans", "Chaqueta", "Zapatos", "Otros"]
    @Published var locationStatus: String = "Esperando ubicación..."
    
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationStatus = "Solicitando ubicación..."
        switch locationManager?.authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationStatus = "Acceso a la ubicación denegado. Por favor, habilite el acceso en la configuración."
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.requestLocation()
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            locationManager?.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            locationStatus = "Ubicación obtenida"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
        locationStatus = "Error al obtener la ubicación. Intente nuevamente."
    }
    
    func sendDonation() {
        // Handle sending donation information
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

struct ResiduoView: View {
    @StateObject private var viewModel = DonateClothesViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Logo and User Settings
                        HStack {
                            Image("RED-BAMX")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Spacer()
                            
                            Button(action: {
                                // Handle user settings action
                            }) {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        Text("Reportar Ropa")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.bottom, 10)
                        
                        Picker("Tipo de ropa", selection: $viewModel.clothType) {
                            ForEach(viewModel.clothTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        TextField("Talla de ropa (Ej: M, L, XL)", text: $viewModel.size)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        TextField("Contacto (Email o Teléfono)", text: $viewModel.contactInfo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Text(viewModel.locationStatus)
                            .foregroundColor(.white)
                            .padding()
                        
                        Button(action: {
                            viewModel.requestLocation()
                        }) {
                            Text("Enviar Ubicación")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.showImagePicker = true
                        }) {
                            Text("Tomar Foto")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        .sheet(isPresented: $viewModel.showImagePicker) {
                            ImagePicker(image: $viewModel.image, sourceType: .camera)
                        }
                        
                        Button(action: {
                            viewModel.sendDonation()
                        }) {
                            Text("Enviar Donación")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Back to Dashboard")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 70)
            }
            .navigationBarTitle("Reportar Residuo", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}

#Preview {
    ResiduoView()
}
