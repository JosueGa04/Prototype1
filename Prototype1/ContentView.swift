//
//  ContentView.swift
//  Prototype1
//
//  Created by Josue Galindo on 29/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("red-wp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("RED-BAMX")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: Text("Login Page")) {
                            Text("Login")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 150,height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: Text("Register page")) {
                            Text("Registro")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 150,height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: GuestView().navigationBarBackButtonHidden(true)) {
                            Text("Visitante")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 150,height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
