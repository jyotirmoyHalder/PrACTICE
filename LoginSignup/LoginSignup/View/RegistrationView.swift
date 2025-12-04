//
//  RegistrationView.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 3/12/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var confirmPasswordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @State private var isConfirmPasswordValid = true
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText) && validateConfirm(confirmPasswordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create Account")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.primaryBlue)
                    .padding(.bottom)
                    .padding(.top, 48)
                
                Text("Create an account so you can explore all the\n existing jobs")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 80)
                
                EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                
                PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword, validatePassword: Validator.validatePassword, errorText: "Your password is not valid.", placeholder: "Password")
                
                PasswordTextField(passwordText: $confirmPasswordText, isValidPassword: $isConfirmPasswordValid, validatePassword: validateConfirm, errorText: "Your password is not matching.", placeholder: "Confirm Password")
                    .padding(.top)
                Spacer()
                
                Button {
                    //action
                } label: {
                    Text("Sign up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.primaryBlue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .opacity(canProceed ? 1.0 : 0.5)
                .disabled(!canProceed)
                .padding(.top)
                
                Button {
                    //action
                } label: {
                    Text("Already have an account")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.customGray)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                
                BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
                Spacer()
            }
        }
    }
    
    func validateConfirm(_ password: String) -> Bool {
        passwordText == password
    }
}

#Preview {
    RegistrationView()
}
