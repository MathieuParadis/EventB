class AdminMailer < ApplicationMailer
  default from: 'mathieu.thp@gmail.com'

  def admin_report_email(admin)
  #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
  @admin = admin
 
 #on définit une variable @url qu'on utilisera dans la view d’e-mail
  @url = 'http://monsite.fr/login'
  # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
  mail(to: @admin.email, subject: 'Bienvenue chez nous !')
  end
  
 end