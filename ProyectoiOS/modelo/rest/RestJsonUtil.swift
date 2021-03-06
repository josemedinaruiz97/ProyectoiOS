
import Foundation
class RestJsonUtil{
// tranformar diccionarios en json y viceversa
    static func dictToJson(data: [String:Any]) -> Data? {
        guard let json = try? JSONSerialization.data(withJSONObject: data as Any,
                                                     options: []) else {
                                                        return nil
        }
        return json
    }
    static func jsonToDict(data: Data) -> [String: Any]? {
        guard let diccionario = try? JSONSerialization.jsonObject(with: data,
                                                                  options: []) as? [String: Any] else {
                                                                    return nil
        }
        return diccionario
    }
    static func toBase64(cadena: String) -> String? {
        guard let data = cadena.data(using: .utf8) else {
            return nil
        }
        return Data(data).base64EncodedString()
    }
}
