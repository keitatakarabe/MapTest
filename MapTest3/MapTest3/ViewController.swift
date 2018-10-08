//
//  ViewController.swift
//  MapTest3
//
//  Created by 財部圭太 on 2018/10/08.
//  Copyright © 2018年 財部圭太. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{
	
	var myLocationManager: CLLocationManager!
	@IBOutlet weak var latitudeLabel: UILabel!
	@IBOutlet weak var longitudeLabel: UILabel!
	
	var latitudeText:Double = 0
	var longitudeText:Double = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// このstatusで位置情報を使用できるか判定する。使用できないならロードをしない。
		let status = CLLocationManager.authorizationStatus()
		if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied{
			return
		}
		// CLLocationManagerを使えるようにする。（Delegateが関係している）
		myLocationManager = CLLocationManager()
		myLocationManager.delegate = self
		
		// 位置情報を利用していない時に起動すると位置情報を使ってもいいか聞く
		if status == CLAuthorizationStatus.notDetermined {
			myLocationManager.requestWhenInUseAuthorization()
		}
		
		// ユーザーが許可したか確認
		if !CLLocationManager.locationServicesEnabled() {
			return
		}
		
		//位置情報取得精度と更新頻度を設定(いずれもDoubleのメートル)
		myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
		myLocationManager.distanceFilter = kCLDistanceFilterNone
		myLocationManager.requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = manager.location {
			// Labelに緯度と経度を代入
			latitudeLabel.text = "緯度：\(location.coordinate.latitude)"
			longitudeLabel.text = "経度：\(location.coordinate.longitude)"
			// Double変数に緯度と経度を代入
			latitudeText = location.coordinate.latitude
			longitudeText = location.coordinate.longitude
			print(latitudeText)
			print(longitudeText)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		// 位置情報取得失敗時の動作
		print("error")
	}

}

