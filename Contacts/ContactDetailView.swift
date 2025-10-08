//
//  ContactDetailView.swift
//  Contacts
//
//  Created by Alex on 2025-10-06.
//

import SwiftUI

struct ContactDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let contact:Contact
    @State private var headerHeight:CGFloat=300
    @State private var dragAccumulated:CGFloat=0
    @State private var scrollY:CGFloat=0
    // Collapsing progress: 0 at rest, 1 when scrolled up by 300 pts(relitive to headerHeight baseline
    private var collapseProgress:CGFloat{
        let y=max(0, headerHeight-scrollY)
        return min(1,y/300)
    }
    var body: some View {
        ZStack(alignment:.top){
            // Liquid gradient backgroud
            LinearGradient(gradient: Gradient(colors: [
                Color.red.opacity(0.9),
                Color.purple.opacity(0.95),
                Color.cyan.opacity(0.95),
                Color.mint.opacity(0.95),
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            // Scrollable content (name + action buttons +details
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:0){
                    // Name
                    VStack(spacing:8){
                        Text(contact.name)
                            .font(.system(size: 36,weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .scaleEffect( 1 - 2.5*collapseProgress<=0 ?0 : 1 - 2.5*collapseProgress)
                    
                    // Action Buttons
                    HStack(spacing:20){
                        ContactDetailActionButton(icon:"message.fill")
                        ContactDetailActionButton(icon:"phone.fill")
                        ContactDetailActionButton(icon:"video.fill")
                        ContactDetailActionButton(icon:"envelope.fill")
                    }
                    .scaleEffect( 1 - 2*collapseProgress<=0 ?0 : 1 - 2*collapseProgress)
                    .padding(.top,10)
                    
                   // Contact Info
                    VStack(spacing:0){
                        // Contact photo & Poster card
                        HStack(spacing:12){
                            ZStack{
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .frame(width:64,height:64)
                                Text(contact.initial)
                                    .font(.system(size: 24,weight: .bold))
                                    .foregroundStyle(.primary)
                            }
                            Text("Contact Photo & Poster")
                                .font(.system(size: 17,weight: .medium))
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14,weight: .semibold))
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal,20)
                        .padding(.vertical,16)
                        .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal,20)
                        .padding(.top,20)
                        // Contact details
                        VStack(spacing:0){
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                            ContactInfoRow(label:"mobile", value: contact.phoneNumber)
                        }
                    }
                    
                }
                .padding(.top, headerHeight)
            }
            // Track drag  to synthesize a "collapse distance"
            .simultaneousGesture(
                DragGesture()
                    .onChanged({ value in
                        let delta = -value.translation.height //up drag -> positive collapse
                        let current=max(0,min(180,dragAccumulated+delta))
                        let newScrollY=headerHeight-current
                        withAnimation {
                            scrollY=newScrollY
                        }
                    })
                    .onEnded({ value in
                        let delta = -value.translation.height //up drag -> positive collapse
                        let predicted = -value.predictedEndTranslation.height
                        let extra=max(0, predicted-delta)*0.2
                        let final=max(0, min(180, dragAccumulated+delta+extra))
                        withAnimation {
                            scrollY=headerHeight-final
                        }
                    })
            )
            
            // Overlay header layer : Top navigation bar + Avatar pinned
            VStack(spacing:0){
                // Top navigation bar(custom)
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width:44, height:44)
                            .background(.ultraThinMaterial,in:Circle())
                    }
                    Spacer()
                    Button (action: {}){
                        Text("Edit")
                            .font(.system(size: 17,weight: .medium))
                            .foregroundColor(.primary)
                            .frame(height:44)
                            .padding(.horizontal,20)
                            .background(.ultraThinMaterial,in:Capsule())
                    }

                }
                
            }
            
            // Avatar (collapsing avatar when scroll up)
            ZStack{
                // Main crystal glass circle
                Circle()
                    .fill(
                        LinearGradient(colors: [
                            Color.white.opacity(0.25),
                            Color.white.opacity(0.15),
                            Color.white.opacity(0.05),
                            Color.white.opacity(0.1),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    ).frame(width:300,height:300)
                    .overlay{
                        // Crystal border with multiple layers
                        Circle()
                            .stroke(
                                LinearGradient(colors: [
                                    Color.white.opacity(0.8),
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.1),
                                    Color.white.opacity(0.3),
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                ,lineWidth: 2
                            )
                        
                    }
                // Image of person
                
                Image(systemName: "person")
                    .font(.system(size: 200,weight: .regular,design: .rounded))
                    .foregroundColor(.white)
               
            }
            .scaleEffect( 1 - 2.5*collapseProgress<=0 ?0 : 1 - 2.5*collapseProgress)
        }
        // Initialize header height and baseline scroll position
        .onAppear {
            headerHeight = 300
            scrollY = headerHeight // baseline (no collapse)
            dragAccumulated = 0
        }
        .toolbar(.hidden,for:.navigationBar)
    }
}

struct ContactDetailActionButton:View{
    let icon:String
    var body: some View{
        Button(action:{}){
            Image(systemName: icon)
                .font(.system(size: 20,weight:.medium))
                .foregroundStyle(.white.opacity(0.9))
                .frame(width:56,height:56)
                .conditionalGlassEffect(.blue.opacity(0.5),in:RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct ContactInfoRow:View{
    let label:String
    let value:String
    var body: some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing:4 ){
                    
                    Text(label)
                        .font(.system(size: 17,weight: .regular))
                        .foregroundColor(.white)
                    if(!value.isEmpty){
                        Text(value)
                            .font(.system(size: 17,weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.vertical,20)
        }
    }
}

struct ConditionalGlassEffect: ViewModifier {
    var color: Color
    var shape: Shape
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            // Apply the glass effect when available (uses default style).
            content.glassEffect(.regular.tint(color),in: shape)
        } else {
            content
        }
    }
}

extension View {
    func conditionalGlassEffect(_ color: Color = .blue.opacity(0.5), in shape: some Shape = RoundedRectangle(cornerRadius: 16)) -> some View {
        modifier(ConditionalGlassEffect(color: color,shape: shape))
    }
}


#Preview {
    ContactDetailView(contact:Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue))
}
