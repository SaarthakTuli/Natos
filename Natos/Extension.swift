//
//  Extension.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import Foundation


extension Date {
    func convert() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
