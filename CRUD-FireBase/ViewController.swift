//
//  ViewController.swift
//  CRUD-FireBase
//
//  Created by Mac16 on 15/12/20.
//

import UIKit
import Firebase


//https://firebase.google.com/docs/firestore/quickstart?authuser=0#swift
//https://firebase.google.com/docs/firestore/manage-data/add-data?authuser=0
//https://firebase.google.com/docs/firestore/query-data/queries?authuser=0#swift_1



class ViewController: UIViewController {
    
    @IBOutlet weak var resultadoText: UITextView!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var edadTextField: UITextField!
    @IBOutlet weak var generoSwitch: UISwitch!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //agregarUsuario()
        //añadirInfoUsuario(alumnoID: "huRu2cV3TOcllhMTcFqH")
       // borrarInfoUsuario(alumnoID: "huRu2cV3TOcllhMTcFqH")
        //buscaAlumno(campo: "nombre", valor: "Oscar")
        //leerUsuarios()
        
    }
    
    func mostrarAlerta(mensaje:String){
        let alert = UIAlertController(title: "Advertencia", message: mensaje, preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            //nada
        }
        alert.addAction(accionAceptar)
        present(alert, animated: true)
    }
    
    func limpiarTextFields(){
        nombreTextField.text = ""
        telefonoTextField.text = ""
        edadTextField.text = ""
    }
    
    
    @IBAction func agregarButton(_ sender: UIButton) {
        if nombreTextField.text != "" && telefonoTextField.text != "" && edadTextField.text != "" {
            var genero : Bool {if generoSwitch.isOn{return true}else{return false}}
            let edad = Int(edadTextField.text!)
            
            agregarUsuario(nombre: nombreTextField.text!, telefono: telefonoTextField.text!, edad: edad! , genero:genero)
            mostrarAlerta(mensaje: "Alumno añadido con éxito")
            limpiarTextFields()
        } else {
            mostrarAlerta(mensaje: "Llena todos los campos por favor")
        }
        
       
    }
    
    
    @IBAction func buscarButton(_ sender: UIButton) {
        //SI NO INGRESA UN NOMBRE, BUSCARÁ TODOS
        if nombreTextField.text == "" {
            leerUsuarios()
        } else {
            buscaAlumno(campo: "nombre", valor: nombreTextField.text!)
        }
    }
    
    @IBAction func actualizarButton(_ sender: UIButton) {
    }
    
    
    @IBAction func eliminarButton(_ sender: UIButton) {
    }
    
    
    
    func agregarUsuario (nombre:String, telefono:String, edad:Int, genero: Bool){
        // Agrega un nuevo alumno con un ID generado automaticamente
        var ref: DocumentReference? = nil
        
        ref = db.collection("datosAlumno").addDocument(data: [
            "nombre": nombre,
            "telefono": telefono,
            "edad": edad,
            "genero": genero
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
    }
    
    func leerUsuarios(){
        //LEE TODOS LOS USUARIOS
        db.collection("datosAlumno").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.resultadoText.text = ""
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let nombre = document.data()["nombre"]!
                    let telefono = document.data()["telefono"]!
                    let edad = document.data()["edad"]!
                    var genero : String {
                        if (document.data()["genero"] as! Bool){
                            return "Masculino"
                        } else {
                            return "Femenino"
                        }
                    }
                    self.resultadoText.text += "ID: \(document.documentID)\nNombre: \(nombre)\nTelefono: \(telefono)\nEdad: \(edad)\nGenero: \(genero)\n\n"
                    
                }
            }
        }
        
    }
    
    
    func buscaAlumno(campo : String , valor: Any){
        // BUSCA alumnos según el campo y el valor indicado
        db.collection("datosAlumno").whereField(campo, isEqualTo: valor).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.resultadoText.text = ""
                for document in querySnapshot!.documents{
                    print("\(document.documentID) => \(document.data())")
                    let nombre = document.data()["nombre"]!
                    let telefono = document.data()["telefono"]!
                    let edad = document.data()["edad"]!
                    var genero : String {
                        if (document.data()["genero"] as! Bool){
                            return "Masculino"
                        } else {
                            return "Femenino"
                        }
                    }
                    self.resultadoText.text += "ID: \(document.documentID)\nNombre: \(nombre)\nTelefono: \(telefono)\nEdad: \(edad)\nGenero: \(genero)\n\n"
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
