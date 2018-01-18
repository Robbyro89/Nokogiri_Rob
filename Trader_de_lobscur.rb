require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#creation des tables qu'on utilisera plus tard dans le code
table_name = []
table_price = []
table = []
name_price_hash = Hash.new #creation du hash

url_crypto = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

puts url_crypto.css('title') #commande pour tester qui m'affiche le titre de la page html ci-dessus


#cette boucle cicble chacune des balises html <a> contenant les noms des monnaies et les rentre dans le tableau table_name
url_crypto.css("a.currency-name-container").each do |item|  
  table_name << item.text #faire ce tableau est la solution que j'ai trouve pour que les noms de monnaie soient pas colles les uns aux autres et soient exploitables
end 


#je fais le meme travail que ci-dessus mais sur les prix
url_crypto.css("a.price").each do |item|  
  table_price << item.text
end 

#mantenant que j'ai les noms et les prix sous formats exploitables je fais une boucle pour les assembler dans un hash puis les rentrer dans un tableau
for i in (0..table_name.length-1)
	name_price_hash[table_name[i]] = table_price[i] #je prends le premier nom et le premier prix de mes tableaux name et price et je les assemble ensemble dans un hash
	table << name_price_hash # je rentre mon hash dans un tableau
	name_price_hash = {} #je vide mon hash pour recommencer la boucle et le re-remplir avec une nouvelle paire
end


puts table