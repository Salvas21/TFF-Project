//
//  CatchView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-12-09.
//

import SwiftUI

struct CatchView: View {
    @State private var specie: String = ""
    @State private var weight: String = ""
    @State var image: UIImage? = nil
    @State var showCaptureImageView: Bool = false
    @State var sentFish: Bool = false
    @ObservedObject var btComm: BluetoothCommunicator
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Sauvegarder un poisson")
                    .foregroundColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
                    .underline()
                    .font(.largeTitle)
                    .padding(.vertical, 20)
                    .padding(.bottom, 40)
                VStack {
                    TextField("Espèce", text: $specie)
                        .padding()
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .cornerRadius(5.0)
                    TextField("Poids", text: $weight)
                        .padding()
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .cornerRadius(5.0)
                    Button("Prendre une photo") {
                        self.showCaptureImageView.toggle()
                    }
                    .padding()
                    Button("Sauvegarder") {
                        if (btComm.tripData.tripId != 0) {
                            DispatchQueue.main.async {
                                APIFetcher().fetchWind(coordinate: btComm.getLocationCoordinate()) { (WindInfo) in
                                    DispatchQueue.main.async {
                                        btComm.meteoData.wind = WindInfo.value ?? "0"
                                        btComm.updateMeteoData()
                                        APIFetcher().sendCatch(tripData: btComm.tripData, meteoData: btComm.meteoData, coordinates: btComm.getLocationCoordinate(), specie: specie, weight: weight, image: image?.jpegData(compressionQuality: 1.0) ?? Data("".utf8), completionHandler: { (resultCode) in
                                            DispatchQueue.main.async {
                                                sentFish.toggle()
                                                specie = ""
                                                weight = ""
                                                btComm.addCatch()
                                            }
                                        })
                                    }
                                }
                                
                                
                                
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .background(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .padding(.bottom, 25)
                }
                .padding()
            }
            .sheet(isPresented: $showCaptureImageView, content: {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
            })
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .accentColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
        .alert(isPresented: $sentFish, content: {
            Alert(title: Text("Succès"), message: Text("Votre poisson a bien été sauvegardé."), dismissButton: .default(Text("OK")))
        })
        
    }
}


// https://www.iosapptemplates.com/blog/swiftui/photo-camera-swiftui
struct CaptureImageView {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
