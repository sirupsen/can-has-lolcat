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

    def random_html(animal)
      # do they want a kitteh or a puppeh?
      if animal == :dog
        domain = "dogs."
      else
        domain = ""
      end

      # The site randomly returns a video based page at a
      # rate that anecdotally appears to be 15-20% of the
      # time. Detect those links from the title and go
      # back until we get a normal image page.
      html = ""
      begin
        html = open(PROTOCOL + domain + RANDOM).read
      end while(html.match(/<title>\s+(Video|VIDEO):/))

      html
    end

    def extract_image_url(animal, html)
      # is this a kitteh or a puppeh?
      if animal == :dog
        domain = "ihasahotdog"
      else
        domain = "icanhascheezburger"
      end

      regex = /"http:\/\/#{domain}\.files\.wordpress\.com\/[^"]+/

      m = html.match(regex)

      m.nil? ? nil : m[0][1..-1]
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
