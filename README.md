## Установка

Выполнить
```sh
git clone https://github.com/IvikGH/imager
cd imager/
gem build imager.gemspec
gem install ./imager-0.0.1.gem
```
## Использование

В **irb** консоли выполнить:
```ruby
2.4.0 :002 > require 'imager'
 => false
2.4.0 :003 > Imager.get_images
Enter the page link:
https://github.com/
 => ["https://assets-cdn.github.com/images/modules/site/home-illo-conversation.svg",
 ...
 "https://assets-cdn.github.com/images/modules/site/logos/walmart-logo.png"]
```
