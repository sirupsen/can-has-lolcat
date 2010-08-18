require 'open-uri'

module Lolcat
  RANDOM  = "http://icanhascheezburger.com/?random"
  LOLCAT = /"http:\/\/icanhascheezburger\.files\.wordpress\.com\/[^"]+/

  class << self
    def can_has(format=nil)
      kitty = Lolcat.get_direct_url_of(random_from_internetz)

      case format
      when :html
        "<img src='#{kitty}' alt='' />"
      when :bbcode
        "[img]#{kitty}[/img]"
      when :url
        kitty
      else
        kitty
      end
    end

    alias_method :can_haz, :can_has

    def get_direct_url_of(html)
      html.match(LOLCAT)[0][1..-1]
    end

    def random_from_internetz
      open(RANDOM).read
    end
  end
end
