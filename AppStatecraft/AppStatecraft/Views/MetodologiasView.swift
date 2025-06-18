//
//  MetodologiasView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 17/06/25.
//

import SwiftUI

struct MetodologiasView: View {
    
    var body: some View {
       
        NavigationView {
            VStack(alignment: .leading) {
                Text("Explore metodologias para despertar sua criatividade!")
                    .padding(.leading, 20)
                Spacer()
                   
                    
            }
            .navigationTitle("Metodologias")
            
           .frame(maxWidth: .infinity, alignment: .leading)
    
        }
        
        
    }
}
