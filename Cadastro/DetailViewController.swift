//
//  DetailViewController.swift
//  Cadastro
//
//  Created by Paulinho on 04/08/19.
//  Copyright © 2019 Paulinho. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet var id: UILabel!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var preco: UILabel!
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var imagem: UILabel!
    @IBOutlet var descricao: UILabel!
    @IBOutlet var data: UILabel!
    @IBOutlet var pessoas: UILabel!
    @IBOutlet var cupons: UILabel!
    
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var textField: UILabel!
    
    @IBOutlet weak var bigText: UITextView!
    @IBAction func shareClicked(_ sender: Any) {
        
        let actionController =  UIActivityViewController(activityItems: [descricao.text!], applicationActivities: nil)
        present(actionController,animated: true,completion: nil)
    }
    
    
    @IBAction func postClicked(_ sender: Any) {
        let parameters = ["eventId": strid, "name":"","email":""]
        guard let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let httpBody  = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch{
                    print(error)
                }
            }
        }
    }
    
    
    var strid = ""
    var strdescricao = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        id.text = strid
        bigText.text = strdescricao
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
