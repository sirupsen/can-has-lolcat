= can-has-lolcat

can haz random `lolcat`? Well of course you can:

    Lolcat.can_has
    => "http://icanhascheezburger.files.wordpress.com/2010/08/1c6fbea0-4735-49c5-8247-5f618b66c219.jpg"

For extra awesome, you can specify an output format:

    Lolcat.can_has(:html)
    => "<img src='http://icanhascheezburger.files.wordpress.com/2010/08/1c6fbea0-4735-49c5-8247-5f618b66c219.jpg' alt='' />"

    Lolcat.can_has(:bbcode)
    => "[img]http://icanhascheezburger.files.wordpress.com/2010/08/1c6fbea0-4735-49c5-8247-5f618b66c219.jpg[/img]"

    Lolcat.can_has(:url)
    => "http://icanhascheezburger.files.wordpress.com/2010/08/1c6fbea0-4735-49c5-8247-5f618b66c219.jpg"

Yes, `Lolcat.can_has(:url)` is exactly the same as `Lolcat.can_has` but more cat-chy!

Made for [Whyday 2010](http://whyday.org/). Because it's craaazy. I've implemented this in an admin interface somewhere, but sssh!

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Simon. See LICENSE for details.
