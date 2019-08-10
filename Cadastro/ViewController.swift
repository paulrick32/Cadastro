//
//  ViewController.swift
//  Cadastro
//
//  Created by Paulinho on 04/08/19.
//  Copyright © 2019 Paulinho. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import MapKit


struct jsonstruct:Decodable{
    let title:String
    let id:String
    let description:String
    let image:String
}




class ViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource{
    
    @IBOutlet var tableview: UITableView!
    
    var arrdata = [jsonstruct]()
    
    let images = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5")]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
    }
    func getdata(){
        let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                if error == nil{
                self.arrdata = try JSONDecoder().decode([jsonstruct].self, from: data!)
                    
                    for mainarr in self.arrdata{
                        print(mainarr.title)
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                        
                    }
                }
            }
            catch{
                print("Erro ao pegar o JSON")
            }
            
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrdata.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableview.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblTitle.text = "\(arrdata[indexPath.row].title)"
       
        cell.imageCell.image = images[indexPath.row]
        
        self.tableview.contentInset = UIEdgeInsets(top: -80, left: 0, bottom: 0, right: 0 )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        detail.strid = arrdata[indexPath.row].id
        detail.strdescricao = arrdata[indexPath.row].description
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
}

