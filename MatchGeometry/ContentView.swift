//
//  ContentView.swift
//  MatchGeometry
//
//  Created by Shubham Kamdi on 11/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var switchedView: Bool = false
    @State private var nameSpaceId1: String = ""
    @State private var nameSpaceId2: String = "id1"
    @State private var nameSpaceId3: String = ""
    @State private var nameSpaceId4: String = ""
    @Namespace private var flipNamespace
    
    var body: some View {
        slidingView()
    }
    
    func slidingView() -> some View {
        HStack {
            
            disappearingComponent(
                nameSpaceId1,
                "Text 1", {
                    flipNamespaceHandler("id1", "", "", "")
                })
            disappearingComponent(
                nameSpaceId2,
                "Text 2", {
                    flipNamespaceHandler("", "id1", "", "")
                })
            disappearingComponent(
                nameSpaceId3,
                "Text 3", {
                    flipNamespaceHandler("", "", "id1", "")
                })
            disappearingComponent(
                nameSpaceId4,
                "Text 4", {
                    flipNamespaceHandler("", "", "", "id1")
                })
            
        }
        
        .frame(maxWidth: .infinity)
        .frame( height: 45)
    }
    
    func disappearingComponent(
        _ namespace: String,
        _ text: String,
        _ gestureHandler: @escaping () -> ()
    ) -> some View {
        ZStack {
            if namespace != "" {
                Rectangle()
                    .fill(.white)
                    .shadow(radius: 5)
                    
                    .matchedGeometryEffect(
                        id: namespace,
                        in: flipNamespace
                    )
            }
            Text(text)
                .foregroundColor(namespace != "" ? .black : .gray)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.spring()) {
                        gestureHandler()
                    }
                }
        }
    }
    
    func flipNamespaceHandler(
        _ nameSpace1: String,
        _ nameSpace2: String,
        _ nameSpace3: String,
        _ nameSpace4: String) {
        self.nameSpaceId1 = nameSpace1
        self.nameSpaceId2 = nameSpace2
        self.nameSpaceId3 = nameSpace3
        self.nameSpaceId4 = nameSpace4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
