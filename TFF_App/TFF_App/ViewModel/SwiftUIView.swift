//
//  SwiftUIView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-28.
//

import SwiftUI

struct View2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("POP")
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct SwiftUIView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: View2()) {
                Text("PUSH")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
