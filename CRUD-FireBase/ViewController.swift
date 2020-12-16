//
//  ViewController.swift
//  CRUD-FireBase
//
//  Created by Mac16 on 15/12/20.
//

import UIKit
import Firebase




class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    func agregarUsuario (){
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        
        ref = db.collection("datosAlumno").addDocument(data: [
            "nombre": "Oscar",
            "telefono": "4431991750",
            "edad": 20,
            "genero": true
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
    }
}
