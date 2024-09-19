//
//  GuestView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI

struct GuestView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView {
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
                    
                        VStack(spacing: 20) {
                            NavigationLink(destination: ConocenosView().navigationBarBackButtonHidden(true)) {
                                CardView(title: "Conocenos", color: .blue)
                            }
                            
                            NavigationLink(destination: Text("Second Card Destination")) {
                                CardView(title: "Empresa", color: .green)
                            }
                            
                            NavigationLink(destination: PersonaView().navigationBarBackButtonHidden(true)) {
                                CardView(title: "Persona", color: .red)
                            }
                            
                            NavigationLink(destination: ResiduoView()) {
                                CardView(title: "Donar Ropa", color: .purple)
                            }
                        }
                        .padding()
                    }
                    .padding(.top, 20)
                }
                .navigationBarTitle("Dashboard", displayMode: .inline)
                .navigationBarBackButtonHidden(true)

            }
        }
    }
}

struct CardView: View {
    var title: String
    var color: Color
            
    var body: some View {
        ZStack {
            color
                .cornerRadius(15)
                .shadow(radius: 5)
                    
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 150)
    }
}

#Preview {
    GuestView()
}
