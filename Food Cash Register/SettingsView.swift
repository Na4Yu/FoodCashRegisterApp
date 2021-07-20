//
//  SettingsUIView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

class Settings :ObservableObject{
    @Published var store : Int = UserDefaults.standard.integer(forKey: "StoreSetting")
    
    func saveStoreSetting(){
        UserDefaults.standard.set(store, forKey: "StoreSetting")
    }
}
let stores = ["餃子","焼き鳥","ドリンク","フランクフルト","ポップコーン"]
struct SettingsView: View {
    @StateObject var settings = Settings()
    
    var body: some View {
        Form{
            Section(header:Text("店舗設定"),footer:Text("この店舗情報に基づいてメニューが変更されます。")){
                HStack {
                    Text(stores[settings.store])
                    Spacer()
                    Picker(selection: $settings.store, label: Text("変更"), content: {
                        ForEach((0..<stores.count), id: \.self){ index in
                            Text(stores[index])
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .onChange(of: settings.store, perform: { value in
                    settings.saveStoreSetting()
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
