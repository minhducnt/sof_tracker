//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct ConfirmationSheet: View {
    @Binding var isConfirmationGiven: Bool
    @Binding var isOpen: Bool

    var title: LocalizedStringKey = "Are you sure?"
    var subTitle: LocalizedStringKey = "Are you really really sure that you want to go ahead with this action. It can have permanent consequences?"

    var body: some View {
        VStack {
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(.notoSansBold24)

            Text(subTitle)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(.notoSansMedium12)
                .padding()

            HStack {
                TextButton(
                    onClick: {
                        isOpen.toggle()
                    },
                    text: AppStrings.Cancel,
                    style: .outline,
                    color: .primarySof
                )
                TextButton(
                    onClick: {
                        isConfirmationGiven.toggle()
                        isOpen.toggle()
                    },
                    text: AppStrings.YesSure,
                    style: .filled,
                    color: .primarySof
                )
            }.padding(.bottom, 20)
        }.padding()
    }
}

#Preview {
    ConfirmationSheet(
        isConfirmationGiven: Binding.constant(false),
        isOpen: Binding.constant(true)
    )
}
