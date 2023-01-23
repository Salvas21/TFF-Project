//
//  LoginView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-21.
//

import SwiftUI
import Foundation

struct Login: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var authError: Bool = false
    @State private var showHomeView = false
    @ObservedObject private var userId = UserId()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Three Fisherman Friends")
                    .font(.system(size: 28, weight: .heavy, design: .serif))
                    .offset(x: 0, y: -deviceHeight/14)
                
                Text("🎣")
                    .font(.system(size: 56))
                    .offset(x: 0, y: -deviceHeight/16)
                
                Text("Connexion")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                TextField("Courriel", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(5.0)
                    
                SecureField("Mot de passe", text: $password)
                    .padding()
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(5.0)

                NavigationLink(destination: HubView(userId: userId), isActive: $showHomeView, label: {
                    Button(action: {
                        DispatchQueue.main.async {
                             authenticate(email: email, password: password)
                        }
                    }, label: {
                        Text("Se connecter")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding()
                            .padding(.horizontal, 30)
//                            .background(Color.blue)
                            .background(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
                            .cornerRadius(10)
                    }).padding(.top, 40)
                })

                Link("S'inscrire", destination: URL(string: "http://tff.sexy/signup")!)
                    .padding()
                    .foregroundColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
            
            }.padding().alert(isPresented: $authError, content: {
                Alert(title: Text("Erreur"), message: Text("Vos informations de connexion sont invalides."), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func authenticate(email: String, password: String) {
//        if email.count != 0 && password.count != 0 {
//            APIFetcher().fetchAuthentication(email: email, password: password, completionHandler: { (user) in
//                DispatchQueue.main.async {
//                    if user.id != 0 {
//                        self.userId.id = user.id
//                        self.showHomeView = true
//                    } else {
//                        self.authError = true
//                    }
//                }
//            })
//        }
        self.showHomeView = true
    }
    
    
}

