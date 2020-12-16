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
        
        //agregarUsuario()
        //añadirInfoUsuario(alumnoID: "huRu2cV3TOcllhMTcFqH")
        borrarInfoUsuario(alumnoID: "huRu2cV3TOcllhMTcFqH")
        leerUsuarios()
        
    }
    
    func agregarUsuario (){
        // Add a new document with a generated ID
        // Agrega un nuevo alumno con un ID generado automaticamente
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
    
    func leerUsuarios(){
        db.collection("datosAlumno").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }
    
    func sobreescribeUsuario (alumnoID: String){
        // Add a new document in collection "datosAlumno"
        // Agrega o sobreescribe en la colección un alumno según un ID
        db.collection("datosAlumno").document(alumnoID).setData([
            "nombre": "Maricarmen Guadalupe",
            "telefono": "4432299095",
            "edad": 20,
            "genero": false
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func añadirInfoUsuario (alumnoID:String){
        //Añade campos adicionales a un alumno según el ID
        db.collection("datosAlumno").document(alumnoID).setData([ "noControl": "16121300" ], merge: true)
        { err in
            if let err = err {
                print("Error merging document: \(err)")
            } else {
                print("Document successfully merged!")
            }
        }}
    
    func editarUsuario (alumnoID:String){
        let alumnoEditable = db.collection("datosAlumno").document(alumnoID)
        
        //Actualiza el campo "nombre" del alumno dado según el ID
        alumnoEditable.updateData([
            "nombre": "Mari"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func borrarAlumno (alumnoID:String){
        // Borra un alumno de la colección según un ID
        db.collection("datosAlumno").document(alumnoID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func borrarInfoUsuario (alumnoID:String){
        db.collection("datosAlumno").document(alumnoID).updateData([
            "noControl": FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
