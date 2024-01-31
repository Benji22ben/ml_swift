//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by MARQUES BALULA Benjamin on 10/01/2024.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
    
    func getEmoji() -> String {
        switch(self) {
        case .positive:
            return "😃"
        case .negative:
            return "😡"
        case .neutral:
            return "😑"
        case .mixed:
            return "🤓"
        @unknown default:
            return "Inconnu"
        }
        
    }
    
    func getColor() -> Color {
        switch(self) {
        case .positive:
            return Color.green
        case .negative:
            return Color.red
        case .mixed:
            return Color.yellow
        case .neutral:
            return Color.gray
        @unknown default :
            return Color.black
        }
    }
}



struct ContentView: View {
    @State var modelInput: String = ""
    @State var modelOutput: String = ""
    @State var result: Sentiment = .positive
    
    func classify() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try SentimentAnalysis(configuration: .init())
            let prediction = try model.prediction(text: modelInput)
            modelOutput = prediction.label
            
            result = Sentiment(rawValue: modelOutput) ?? .positive
            // A vous de travailler la suite
        } catch {
            modelOutput = "Something went wrong"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("IA du FUTUR")
            VStack (alignment: .leading, spacing: 30) {
                Text("Entrez une phrase l'IA va deviner votre sentiment")
                    .foregroundStyle(.white)
                TextEditor(text: $modelInput)
                    .background(Color.white)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                Button(action: classify, label: {
                    Text("Deviner le sentiment").foregroundColor(.purple)
                }).padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(.white)
                    .cornerRadius(18)
            }.padding()
                .background(Color.purple)
                .cornerRadius(18)
            VStack (alignment: .center, spacing: 10) {
                Text(result.getEmoji())
                Text(result.rawValue).foregroundStyle(.white)
            }.padding()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .center)
                .background(result.getColor())
                .cornerRadius(18)
        }.padding()
    }
}

#Preview {
    ContentView()
}
