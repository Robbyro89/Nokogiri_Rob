require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require'pry'

#url pour rechercher une liste d'incubateurs
my_url = Nokogiri::HTML(open("http://blog.neocamino.com/liste-des-incubateurs-a-paris/"))

puts my_url.css('title').text.upcase
nom_incub = my_url.css("h2") #commande pour recolter tous les noms d'incubateurs
url_incub = my_url.css("h2 + p a") #commande pour récolter tous leurs url


table_name = [] 
	nom_incub.each do |nom| #boucle pour faire entrer tous les noms d'incubateurs dans un tableau
		table_name << nom.text[3..100]
	end

table_name = table_name[1..table_name.length-1] #pour retirer la première phrase qui était HS


table_url = []
	url_incub.each do |url|#boucle pour faire entrer tous les url d'incubateurs dans un tableau
		table_url << url['href']
	end
table_url = table_url.uniq #commande pour enlever les doublons du tableau car certains sites d'incubateurs etaient ecrits plusieus fois

table_url.insert(5, "http://www.agoranov.com/") #commande pour ajouter le site d'agoranov à la 5ème position du tableau car elle n'était pas sur le site


incubator_websites = Hash.new
big_table = []

for i in (0..table_name.length-1)
	incubator_websites[table_name[i]] = table_url[i]
	big_table << incubator_websites
	incubator_websites = {}
end

puts big_table