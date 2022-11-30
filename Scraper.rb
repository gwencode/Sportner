require "open-uri"
require "addressable"
require "nokogiri"

urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
html_filea = URI.open(urla).read
html_doca = Nokogiri::HTML(html_filea)

urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
html_fileb = URI.open(urlb).read
html_docb = Nokogiri::HTML(html_fileb)

spots_data = []
list_href = []
html_doca.search(".wanna-tabzonespot-item-title").each do |a|
  list_href << a.attribute("href").value
end
html_docb.search(".wanna-tabzonespot-item-title").each do |a|
  list_href << a.attribute("href").value
end
# list_href.delete_at(1)

list_href.each do |ref|
  begin
    url = "https://fr.wannasurf.com#{ref}"
    URI.open(url).read
  rescue
    next
  end

  # html_doc.search("#wanna-item-specific-2columns-left p").each do |element|
  #   puts element
  # end
  # p start = html_docc.search("#wanna-item-specific-2columns-left p").text.strip.index('Experience') + 10
  # p length = html_docc.search("#wanna-item-specific-2columns-left p").text.strip.index('Fréquence') - start
  # p string = html_docc.search("#wanna-item-specific-2columns-left p").text.strip[start, length]
end
