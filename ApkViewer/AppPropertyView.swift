//
//  AppPropertyView.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 1/5/21.
//

import SwiftUI

struct AppPropertyView: View {
    var propertyName:String
    var propertyValue:String
    var body: some View {
        HStack {
            Text(propertyName)
                .fontWeight(.medium)
            Text(propertyValue)
                .multilineTextAlignment(.leading)
                .lineLimit(80)
                
        }.font(.body)
    }
}

struct AppPropertyView_Previews: PreviewProvider {
    static var previews: some View {
        AppPropertyView(propertyName: "App Name:", propertyValue: "My App")
    }
}
