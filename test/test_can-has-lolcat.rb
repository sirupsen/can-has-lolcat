require 'helper'
require 'rr'

class TestCanHasLolcat < Test::Unit::TestCase
  include RR::Adapters::TestUnit

  context "Lolcat" do
    context "#can_has" do
      LOLCAT = /http:\/\/icanhascheezburger\.files\.wordpress\.com\/.+/

      setup do
        stub(Lolcat).random_from_internetz do
          File.read(File.dirname(__FILE__) + "/fixtures/lolcat.html")
        end
      end

      should "without any arguments give clean `lolcat` url" do
        assert Lolcat.can_has =~ LOLCAT
      end

      should "with url as argument sgive clean url" do
        assert Lolcat.can_has(:url) =~ LOLCAT
      end

      should "with html as argument give HTML formatted `lolcat`" do
        assert Lolcat.can_has(:html) =~ /<img src='.+' alt='' \/>/
      end

      should "with bbcode as argument give bbcode formatted `lolcat`" do
        assert Lolcat.can_has(:bbcode) =~ /\[img\].+\[\/img\]/
      end
    end
  end
end
