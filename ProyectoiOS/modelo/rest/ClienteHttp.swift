import Foundation

class ClienteHttp {
    // URL de nuestra API
    let urlApi: String = "https://php-josemedinaruiz97.c9users.io/iospanaderia/"
    let respuesta: OnHttpResponse
    var urlPeticion: URLRequest
    
    // En la clasa POSO métodos que tranforman json en objetos y viceversa
    
    // Si el String no es una URL no crea la instancia
    // _ no son obligatorios
    // target - accion a ejecutar (urlApi + target)
    // responseObject - objeto a través del cual se pasa el resultado que se obtiene
    // method - GET, POST, PUT, DELETE
    // en data le pasas un diccionario con los datos que se quieren pasar en el body (los datos de json), any puede ser cualquier valor
    init?(target: String, authorization: String, responseObject: OnHttpResponse,
          _ method: String = "GET", _ data : [CardBakery] = Array()) {
        
        guard let url = URL(string: self.urlApi + target) else {
            return nil
        }
        print(url)
        self.respuesta = responseObject
        self.urlPeticion = URLRequest(url: url)
        self.urlPeticion.httpMethod = method
        self.urlPeticion.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.urlPeticion.addValue(authorization, forHTTPHeaderField: "Authorization")
        print("hola")
        if method != "GET" && data.count > 0 {
            print("hola1")
            guard let json = try? JSONEncoder().encode(data) else {
                return nil
            }
            print(json)
            print("hola2")
            self.urlPeticion.httpBody = json
        }
        
        
    }
    
    // crear el objeto y lanzar la petición
    // doInBackground
    func request() {
        // Iniciar el símbolo de red
        print("hola3")
        let sesion = URLSession(configuration: URLSessionConfiguration.default)
        let task = sesion.dataTask(with: self.urlPeticion,
                                   completionHandler: self.callBack)
        task.resume()
    }
    
    // callBack es el onPostExecute
    private func callBack(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        // Conexión asíncrona a la hebra principal
        DispatchQueue.main.async {
            // Finalizar el símbolo de red
            guard error == nil else {
                self.respuesta.onErrorReceivingData(message: "error")
                return
            }
            guard let datos = data else {
                self.respuesta.onErrorReceivingData(message: "error datos")
                return
            }
            self.respuesta.onDataReceived(data: datos)
        }
    }
}
