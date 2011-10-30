require 'open-uri'

module Lolcat
  PROTOCOL = "http://"
  RANDOM   = "icanhascheezburger.com/?random"

  class << self
    def can_has(format=:url, animal=:cat)

      lol = Lolcat.random_from_internetz(animal)

      case format
      when :html
        "<img src='#{lol}' alt='' />"
      when :bbcode
        "[img]#{lol}[/img]"
      else
        lol
      end
    end

    alias_method :can_haz, :can_has

    # Isolated for easy stubbing during testing
    def get_html(url)
      open(url).read
    end

    def random_html(animal)
      # do they want a kitteh or a puppeh?
      domain = (animal == :dog) ? "dogs." : ""

      # The site randomly returns a video based page at a
      # rate that anecdotally appears to be 15-20% of the
      # time. Detect those links from the title and go
      # back until we get a normal image page.
      html = ""
      begin
        html = get_html(PROTOCOL + domain + RANDOM)
      end while(html.match(/<title>\s+(Video|VIDEO):/))

      html
    end

    def extract_image_url(animal, html)
      # is this a kitteh or a puppeh?
      domain = (animal == :dog) ?  "ihasahotdog" : "icanhascheezburger"

      # Find the image URL in the html
      m = html.match(/"http:\/\/#{domain}\.files\.wordpress\.com\/[^"]+/)

      m ? m[0][1..-1] : nil
    end

    def random_from_internetz(animal)
      url = nil

      # We shouldn't ever get nil back from random_html with the
      # check for videos in place, but the check is kind of hacky
      # so as a extra precaution we'll check for nil here.
      begin
        url = extract_image_url(animal, random_html(animal))
      end while url.nil?

      url
    end
  end
end
