class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
    def welcome_email
        @user = params[:user]
        email_with_name = %("#{@user.username}" <#{@user.email}>)
        @url  = 'http://192.168.40.60:3000/login'
        mail(to: email_with_name, subject: 'Welcome to Gathering of Writers')
    end

    def registration_confirmation(user)
        @user = user
        email_with_name = %("#{@user.username}" <#{@user.email}>)
        mail(:to => email_with_name, :subject => "Gathering of Writers: Registration Confirmation")
    end
end
