//
//  LoginView.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 3/12/25.
//

import SwiftUI

enum FocusedField {
    case email
    case password
}

struct LoginView: View {
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login here")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.primaryBlue)
                    .padding(.bottom)
                
                Text("Welcome back you've\n been missed!")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 80)
                
                EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                
                PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword, validatePassword: Validator.validatePassword, errorText: "Your password is not valid.", placeholder: "Password")
                
                HStack {
                    Spacer()
                    Button {
                        //action
                    } label: {
                        Text("Forgot your password?")
                            .foregroundStyle(.primaryBlue)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                    .padding(.vertical)
                }
                
                Button {
                    //action
                } label: {
                    Text("Sign in")
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
                
                Button {
                    //action
                } label: {
                    Text("Create new account")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.customGray)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                
                BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
            }
        }
    }
}


#Preview {
    LoginView()
}


struct BottomView: View {
    
    var googleAction: () -> Void
    var facebookAction: () -> Void
    var appleAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Or continue with")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primaryBlue)
            
            HStack {
                Button {
                    googleAction()
                } label: {
                    Image("google-logo")
                }
                .iconButtonStyle
                
                Button {
                    facebookAction()
                } label: {
                    Image("facebook-logo")
                }
                .iconButtonStyle
                
                Button {
                    appleAction()
                } label: {
                    Image("apple-logo")
                }
                .iconButtonStyle
            }
        }
    }
}

extension View {
    var iconButtonStyle: some View {
        self
            .padding()
            .background(.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct EmailTextField: View {
    @Binding var emailText: String
    @Binding var isValidEmail: Bool
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            TextField("Email", text: $emailText)
                .focused($focusedField, equals: .email)
                .padding()
                .background(.secondaryBlue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValidEmail ? .red : focusedField == .email ? .primaryBlue : .white, lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: emailText) { _, newValue in
                    isValidEmail = Validator.validateEmail(newValue)
                }
                .padding(.bottom, isValidEmail ? 16 : 0)
            if !isValidEmail {
                HStack {
                    Text("Your email is not valid")
                        .foregroundStyle(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
        }
    }
}

struct PasswordTextField: View {
    @Binding var passwordText: String
    @Binding var isValidPassword: Bool
    let validatePassword: (String) -> Bool
    let errorText: String
    let placeholder: String
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            SecureField(placeholder, text: $passwordText)
                .focused($focusedField, equals: .password)
                .padding()
                .background(.secondaryBlue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValidPassword ? .red : focusedField == .password ? .primaryBlue : .white, lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: passwordText) { _, newValue in
                    isValidPassword = validatePassword(newValue)
                }
            
            if !isValidPassword {
                HStack {
                    Text(errorText)
                        .foregroundStyle(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
        }
    }
}
