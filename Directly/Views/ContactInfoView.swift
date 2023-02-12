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
        case ContactInfoType.PHONE:
            icon = "phone.circle"
        case ContactInfoType.EMAIL:
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
            ContactInfoView(ContactInfo(type: ContactInfoType.EMAIL, value: "e@email.com"))
            ContactInfoView(ContactInfo(type: ContactInfoType.PHONE, value: "(123) 456-7890"))
        }
    }
}
