//
//  BLEManager.swift
//  bpm_necklace WatchKit Extension
//
//  Created by Steph on 2/17/21.
//
import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    struct Peripheral: Identifiable {
        let id: Int
        let name: String
        let rssi: Int
        let uuid: String
        let device: CBPeripheral
    }
    
    var myCentral: CBCentralManager!
    
    @Published var isSwitchedOn = false
    @Published var peripherals = [Peripheral]()
    @Published var connected = false
    @Published var number = 0
    @Published var name = ""
    
    override init() {
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = String(peripheral.name ?? "unknown")
        let uuid = String(describing: peripheral.identifier)
        let filtered = peripherals.filter{$0.uuid == uuid}
        if filtered.count == 0{
            if name != "unknown"{
                let new = Peripheral(id: peripherals.count, name: name, rssi: RSSI.intValue, uuid: uuid, device: peripheral)
                print("\(new.uuid) \(new.name)")
                peripherals.append(new)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected to \(peripheral.name ?? "unknown")")
        connected = true
        name = peripheral.name ?? "unknown"
        
        //Only look for services that matches transmit uuid
        peripheral.discoverServices([BLEService_UUID])
        
    }
    
    func startScanning() {
        print("startScanning")
        myCentral.scanForPeripherals(withServices: [BLEService_UUID], options: nil)
    }
    
    func stopScanning() {
        print("stopScanning")
        myCentral.stopScan()
    }
}
