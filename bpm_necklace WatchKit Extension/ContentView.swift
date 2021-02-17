//
//  ContentView.swift
//  bpm_necklace WatchKit Extension
//
//  Created by Steph on 2/15/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
        VStack {
            Text("LED Necklace")
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                    Spacer()
                    Text(String(peripheral.rssi))
                    
                }
            }.frame(height:40)
            
            // Status goes here
            if bleManager.isSwitchedOn {
                Text("Bluetooth is on")
                    .foregroundColor(.green)
                    .font(.system(size: 14))
                    .padding()
            }
            else {
                Text("Bluetooth is NOT on")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(10)
            }
            
            HStack {
                Button(action: {
                    self.bleManager.startScanning()
                }) {
                    Text("Start")
                }
                Button(action: {
                    self.bleManager.stopScanning()
                }) {
                    Text("Stop")
                }
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
