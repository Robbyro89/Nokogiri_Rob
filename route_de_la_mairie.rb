require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#methode pour recuperer l'adresse email d'une Mairie si on a son url
def get_the_email_of_a_townhal_from_its_webpage(url_mairie)
    page = Nokogiri::HTML(open(url_mairie))
    email = page.css("p.Style22")[11].text  #position de l'email trouvee grace a l'inspecteur d'element
    puts email
end
 
get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

#methode pour recuperer toutes les URL des Mairies du Val d'Oise
def get_all_the_urls_of_val_doise_townhalls()
    page2 = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/vienne.html"))
    adressePage = page2.css("a.lientxt")
    adressePage.each {|links| puts links["href"]}
end
 
get_all_the_urls_of_val_doise_townhalls()

#methode pour recuperer toutes les adresse email des Mairies du Val d'Oise
def get_all_the_emails_of_val_doise_townhalls()
    page3 = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/vienne.html"))
    get_all_the_emails_of_val_doise_townhalls = page3.css("a.lientxt")
    page_Email_ville = []  #Crée un array vide, l'objectif est d'y ranger les adresses mail de toutes les villes
    get_all_the_emails_of_val_doise_townhalls.each {|links| page_Email_ville.push "http://annuaire-des-mairies.com/"+links["href"]}
    page_Email_ville.each {|page|
                        page = Nokogiri::HTML(open(page))
                        #emailformat = /[@]/
                        get_the_email_of_a_townhal_from_its_webpage = page.css("p.Style22")[11].text
                        #Faux: get_the_email_of_a_townhal_from_its_webpage = page.css("p.Style22")[11].text #.select{|i| i.text =~ emailformat}  
                        puts get_the_email_of_a_townhal_from_its_webpage
                        }
                       
end        
 
get_all_the_emails_of_val_doise_townhalls()  
 
setup_spreadsheet = get_all_the_emails_of_val_doise_townhalls()