# Mercury Parser
A tiny ruby wrapper for [Mercury's Web Parser](https://mercury.postlight.com/web-parser/)

[![Gem Version](https://badge.fury.io/rb/mercury_parser.png)](http://badge.fury.io/rb/mercury_parser)
[![Code Climate](https://codeclimate.com/github/moisesnarvaez/mercury_parser.png)](https://codeclimate.com/github/moisesnarvaez/mercury_parser)
[![Dependency Status](https://gemnasium.com/moisesnarvaez/mercury_parser.png)](https://gemnasium.com/moisesnarvaez/mercury_parser)
[![Build Status](https://travis-ci.org/moisesnarvaez/mercury_parser.png)](https://travis-ci.org/moisesnarvaez/mercury_parser)

## Installation
Add this line to your application's Gemfile:

    gem 'mercury_parser'

And then execute:

    bundle install

## Configuration

Set the Api Key:

```ruby
MercuryParser.api_key = MERCURY_API_KEY
```

Make sure to set `MERCURY_API_KEY` in your environement variables. You can get an API key by contacting Mercury's team directly, more information on their [web parser page](https://mercury.postlight.com/web-parser/).

Multiple tokens or multithreaded usage:

```ruby
client = MercuryParser::Client.new(api_key: MERCURY_API_KEY)
```

## Usage

### Parse

Parse a webpage and return its main content:

```ruby
article = MercuryParser.parse("https://trackchanges.postlight.com/building-awesome-cms-f034344d8ed")
=> #<MercuryParser::Article title="Building Awesome CMS", content="<div><div class=\"section-content\"><div class=\"section-inner sectionLayout--insetColumn\"><figure id=\"1b95\" class=\"graf graf--figure graf-after--h3\"><div class=\"aspectRatioPlaceholder is-locked\"><img class=\"graf-image\" src=\"https://d262ilb51hltx0.cloudfront.net/max/800/1*zo51eqdjJ_XSU0D8Vm8P9A.png\"></div></figure><p id=\"c21b\" class=\"graf graf--p graf-after--figure\"><a href=\"https://github.com/postlight/awesome-cms\" class=\"markup--anchor markup--p-anchor\">Awesome CMS</a> is&#x2026;an awesome list of awesome CMSes. It&#x2019;s on GitHub, so anyone can add to it via a pull request. Here are some notes on how and why it came to be.</p><p id=\"2a96\" class=\"graf graf--p graf-after--h3\">GitHub has a <a href=\"https://help.github.com/articles/search-syntax/\" class=\"markup--anchor markup--p-anchor\">set of powerful commands</a> for narrowing search results. In seeking out modern content management tools, I used queries like this:</p><p id=\"5c79\" class=\"graf graf--p graf-after--p\"><a href=\"https://github.com/search?o=desc&amp;q=cms+OR+%22content+management%22+OR+admin+pushed%3A%3E2016-01-01+stars%3A%3E50&amp;ref=searchresults&amp;s=stars&amp;type=Repositories&amp;utf8=&#x2713;\" class=\"markup--anchor markup--p-anchor\">cms OR &#x201C;content management&#x201D; OR admin pushed:&gt;2016&#x2013;01&#x2013;01 stars:&gt;50</a></p><p id=\"7d38\" class=\"graf graf--p graf-after--p\">Sorting by stars, I worked my way backwards. I was able to quickly spot relevant CMS projects. I also started to notice some trends.</p><ul class=\"postList\"><li id=\"8671\" class=\"graf graf--li graf-after--p\">Modern and popular content management systems are written in PHP, JavaScript, Python, and Ruby. There are also a few content management systems written in .NET (C#), but they are much less popular on GitHub.</li><li id=\"a406\" class=\"graf graf--li graf-after--li\">Headless content management systems are gaining popularity. Simply presenting the UI for users to edit content, and relying on the end user to create the user-facing site by ingesting the API. <a href=\"http://getdirectus.com/\" class=\"markup--anchor markup--li-anchor\">Directus</a> and <a href=\"https://www.cloudcms.com/\" class=\"markup--anchor markup--li-anchor\">Cloud CMS</a> are headless CMS options.</li><li id=\"e133\" class=\"graf graf--li graf-after--li\">Static content management systems don&#x2019;t host pages for you. Instead they help generate your CMS, using static files. <a href=\"https://github.com/netlify/netlify-cms\" class=\"markup--anchor markup--li-anchor\">Netlify CMS</a>, <a href=\"https://respondcms.com/\" class=\"markup--anchor markup--li-anchor\">Respond CMS</a>, and <a href=\"https://www.getlektor.com/\" class=\"markup--anchor markup--li-anchor\">Lektor</a> are a few of the options in the static CMS space.</li></ul><p id=\"3bfc\" class=\"graf graf--p graf-after--h3\">I knew the list of all popular content management systems would be huge. I didn&#x2019;t want to put that data into Markdown directly, as it would be difficult to maintain and to augment with extra data (stars on GitHub, last push date, tags, etc).</p><p id=\"4bcb\" class=\"graf graf--p graf-after--p\">Instead, I opted to store the data in <a href=\"https://github.com/toml-lang/toml\" class=\"markup--anchor markup--p-anchor\">TOML</a>, a human-friendly configuration file language. You can view all of the data that powers Awesome CMS in the <a href=\"https://github.com/postlight/awesome-cms/tree/97216ef432963d4dfb2238340e2ebf9a4127fb1e/data\" class=\"markup--anchor markup--p-anchor\">data folder</a>. Here&#x2019;s WordPress&#x2019; entry in that file:</p><pre id=\"4771\" class=\"graf graf--pre graf-after--p\">[[cms]]<br>name = &quot;WordPress&quot;<br>description = &quot;WordPress is a free and open-source content management system (CMS) based on PHP and MySQL.&quot;<br>url = &quot;https://wordpress.org&quot;<br>github_repo = &quot;WordPress/WordPress&quot;<br>awesome_repo = &quot;miziomon/awesome-wordpress&quot;<br>language = &quot;php&quot;</pre><p id=\"4703\" class=\"graf graf--p graf-after--pre\">I process this file using JavaScript in <a href=\"https://github.com/postlight/awesome-cms/blob/97216ef432963d4dfb2238340e2ebf9a4127fb1e/scripts/generateReadme.js\" class=\"markup--anchor markup--p-anchor\">generateReadme.js</a>. It handles processing the TOML, fetching information from GitHub, and generating the final README.md file using the <a href=\"https://github.com/postlight/awesome-cms/blob/master/README.md.hbs\" class=\"markup--anchor markup--p-anchor\">Handlebars template</a>. I&#x2019;m scraping GitHub for star counts because GitHub&#x2019;s API only allows for 60 requests an hour for authenticated users. We want to make it as easy as possible for anyone to contribute. Requiring users to generate a GitHub authentication token to generate the README wasn&#x2019;t an option.</p><p id=\"73aa\" class=\"graf graf--p graf-after--p\">By storing the data in TOML at generating the README.md using JavaScript, I&#x2019;ve essentially created an incredibly light-weight, GitHub backed, static CMS to power Awesome CMS.</p><figure id=\"7c3e\" class=\"graf graf--figure graf-after--p graf--last\"><div class=\"aspectRatioPlaceholder is-locked\"><img class=\"graf-image\" src=\"https://d262ilb51hltx0.cloudfront.net/max/800/1*Y69yr0JgwOaLzACB0ZXDGw.gif\"></div><figcaption class=\"imageCaption\">I heard you like content management systems</figcaption></figure></div></div></div>", author="Jeremy Mack", date_published="2016-10-03T12:48:58.385Z", lead_image_url="https://d262ilb51hltx0.cloudfront.net/max/1200/1*zo51eqdjJ_XSU0D8Vm8P9A.png", dek=nil, next_page_url=nil, url="https://trackchanges.postlight.com/building-awesome-cms-f034344d8ed", domain="trackchanges.postlight.com", excerpt="Awesome CMS is…an awesome list of awesome CMSes. It’s on GitHub, so anyone can add to it via a pull request.", word_count=397, direction="ltr", total_pages=1, rendered_pages=1>

article.title
article.content
article.author
article.date_published
article.lead_image_url
article.dek
article.next_page_url
article.url
article.domain
article.excerpt
article.word_count
article.direction
article.total_pages
article.rendered_pages
```

## Contributing

1. Fork it
2. [Create a topic branch](http://learn.github.com/p/branching.html)
3. Add specs for your unimplemented modifications
4. Run `bundle exec rspec`. If specs pass, return to step 3.
5. Implement your modifications
6. Run `bundle exec rspec`. If specs fail, return to step 5.
7. Commit your changes and push
8. [Submit a pull request](http://help.github.com/send-pull-requests/)

## Inspiration
Based on: [ReadabilityParserGem](https://github.com/phildionne/readability_parser)

## Author
[Moises Narvaez](http://www.moisesnarvaez.com)

## Copyright
Copyright (c) 2016 Moises Narvaez

## License
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
