# newly

## Fetching breaking news from websites

## SYNOPSIS:

``` ruby
# Fecthing breaking news from some website
require 'newly'

# Fecthing breaking news from some website
my_feed = Newly::Feed.new(
                        container: '#ultimas-regiao div, #ultimas-regiao ul li',
                        href: 'a',
                        title: '.titulo',
                        subtitle: '.subtitulo',
                        image_source: 'img')

news = Newly::NewsCrawler.new(url: 'http://g1.globo.com/bahia/', feed: my_feed).fetch
news.each do |n|
  puts n.url # news href url
  puts n.title # news title
  puts n.subtitle # news subtitle
  puts n.image # news image src
end
```

## Contributing to newly

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


