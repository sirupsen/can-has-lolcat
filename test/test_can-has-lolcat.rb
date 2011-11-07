require 'helper'
require 'rr'

class TestCanHasLolcat < Test::Unit::TestCase
  include RR::Adapters::TestUnit

  context "Lolcat" do
    context "#can_has" do
      LOLCAT_URL = "http://icanhascheezburger.com/?random"
      LOLDOG_URL = "http://dogs.icanhascheezburger.com/?random"

      LOLCAT_REGEX = /http:\/\/icanhascheezburger\.files\.wordpress\.com\/.+/
      LOLDOG_REGEX = /http:\/\/ihasahotdog\.files\.wordpress\.com\/.+/
      MAX_STRING_LENGTH = 200

      setup do
        stub(Lolcat).get_html(LOLCAT_URL) do
            File.read(File.dirname(__FILE__) + "/fixtures/lolcat.html")
        end

        stub(Lolcat).get_html(LOLDOG_URL) do
            File.read(File.dirname(__FILE__) + "/fixtures/loldog.html")
        end
      end

      should "without any arguments give clean `lolcat` url" do
        cat = Lolcat.can_has
        assert cat =~ LOLCAT_REGEX
        assert cat.length < MAX_STRING_LENGTH
      end

      should "with (url, dog) as arguments give clean `loldog` url" do
        assert Lolcat.can_has(:url, :dog) =~ LOLDOG_REGEX
      end

      should "with url as argument give clean url" do
        assert Lolcat.can_has(:url) =~ LOLCAT_REGEX
      end

      should "with html as argument give HTML formatted `lolcat`" do
        assert Lolcat.can_has(:html) =~ /<img src='.+' alt='' \/>/
      end

      should "with bbcode as argument give bbcode formatted `lolcat`" do
        assert Lolcat.can_has(:bbcode) =~ /\[img\].+\[\/img\]/
      end

      should "retry when video returned" do
        attempts = 0

        # This stub returns the video fixture the first time it's called
        # and the correct image file the second time.
        stub(Lolcat).get_html(LOLDOG_URL) do
          if 0 == attempts
            attempts += 1
            File.read(File.dirname(__FILE__) + "/fixtures/lolvideo.html")
          else
            File.read(File.dirname(__FILE__) + "/fixtures/loldog.html")
          end
        end

        assert Lolcat.can_has(:url, :dog) =~ LOLDOG_REGEX
      end

    end
  end
end
