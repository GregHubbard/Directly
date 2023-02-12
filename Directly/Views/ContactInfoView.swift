//
//  ContactInfoView.swift
//  Directly
//
//  Created by Greg Hubbard on 2/12/23.
//

import SwiftUI

struct ContactInfoView: View {
    private let contactInfo: ContactInfo
    private let icon: String
    
    init(_ contactInfo: ContactInfo) {
        self.contactInfo = contactInfo
        switch contactInfo.type {
        case .phone:
            icon = "phone.circle"
        case .email:
            icon = "envelope.circle"
        }
    }
    var body: some View {
        HStack {
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.indigo)
            
            Text(contactInfo.value)
                .font(.caption)
        }
    }
}

struct ContactInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 5) {
            ContactInfoView(ContactInfo(type: .email, value: "e@email.com"))
            ContactInfoView(ContactInfo(type: .phone, value: "(123) 456-7890"))
        }
    }
}
