//
//  Constants.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import Foundation

// R.Swift

enum K {
    
    enum ImageName {
        static let googleLogo = "GoogleLogo"
        static let appleLogo = "AppleLogo"
        static let musificationLogo = "Musification"
    }
    
    enum SystemImageName {
        static let addPhoto = "camera.circle"
        
        //container view
        static let emailTextContainerView = "envelope.open"
        static let passwordContainerView = "lock"
        static let fullNameContainerView = "person.fill"
        static let usernameContainerView = "person"
    }
    
    enum PlaceholderText {
        static let password = "Password"
        static let email = "Email"
        static let fullName = "Full Name"
        static let username = "Username"
    }
    
    enum AuthenticationScreensText {
        
        enum ButtonText {
            static let logIn = "Log In"
            static let signUp = "Sign Up"
            static let forgotPassword = "Get help signing in."
            static let logWithGoogle = "Log in with Google"
            static let logWithApple = "Log in with Apple"
            static let resetButton = "Send Reset Link"
        }
        
        enum LabelText {
            static let haveAccount = "Already have an account?"
            static let forgotPassword = "Forgot your password?"
            static let dontHaveAccount = "Don't have an account?"
        }
    }
}
