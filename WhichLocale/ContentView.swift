//
//  ContentView.swift
//  WhichLocale
//
//  Created by Fabrizio Duroni on 14/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device User Locale").font(.title2).bold()) {
                    LocaleSectionView(title: "Locale.preferredLanguages", languages: Locale.preferredLanguages, showCurrent: true)
                    LocaleSectionView(title: "UserDefaults AppleLanguages", languages: getAppleLanguagesArray(), showCurrent: true)
                }
                
                Section(header: Text("App Locale").font(.title2).bold()) {
                    LocaleSectionView(title: "Bundle.preferredLocalizations", languages: Bundle.main.preferredLocalizations, showCurrent: true)
                    LocaleSectionView(title: "Bundle.localizations", languages: Bundle.main.localizations, showCurrent: false)
                }
                
                Section {
                    Text("mobile_app.greetings")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Which Locale?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: openAppSettings) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
    }
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func getAppleLanguagesArray() -> [String] {
        if let appleLanguages = UserDefaults.standard.array(forKey: "AppleLanguages") as? [String] {
            return appleLanguages
        }
        return ["Not Found"]
    }
}

struct LocaleSectionView: View {
    let title: String
    let languages: [String]
    let showCurrent: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).bold()
            if showCurrent, let primary = languages.first {
                Text("Current: \(primary)")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            ForEach(languages, id: \.self) { language in
                Text(language)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
