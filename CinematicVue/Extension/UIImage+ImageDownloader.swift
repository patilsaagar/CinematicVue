//
//  UIImage+ImageDownloader.swift
//  CinematicVue
//
//  Created by sagar patil on 16/03/2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: String, contentMode mode: ContentMode = .scaleAspectFill) {
        
        guard let url = URL(string: url) else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
