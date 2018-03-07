//
//  Imagen.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: "https://php-josemedinaruiz97.c9users.io/img/\(link)") else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
