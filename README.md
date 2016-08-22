# javascript-plugin
This is the source code example for the blog [Making a JS widget: a full-stack approach](https://blog.xmartlabs.com/2016/08/21/making-a-js-widget-a-full-stack-approach/)

# Content

This repo contains a [Ruby on Rails](http://rubyonrails.org/) 5.0 project with all the code related to the blog above. 

## Javasciprt plugin sources
The plugin source code. Which is composed of two files:

* An ERB template that is used to generate the javascript code [widget.js.erb](https://github.com/xmartlabs/javascript-plugin/blob/master/app/views/widget/widget.js.erb)
* Another ERB template that is used to generate the CSS code [_widget.css.erb](https://github.com/xmartlabs/javascript-plugin/blob/master/app/views/widget/_widget.css.erb)

And you can see an example web page that shows how the plugin is loaded here: [index.html](https://github.com/xmartlabs/javascript-plugin/blob/master/public/index.html).

## Rails backend

A rails backend that serves the plugin javascript and a simple endpoint which is called from the plugin simulating the service provided to the client web pages.

Additionally, the backend uses [rack-cors](https://github.com/cyu/rack-cors) to allow cross domain calls. This is needed in order to allow a client web page call our service from the plugin javascript.

A security layer was added by using [rack-attack](https://github.com/kickstarter/rack-attack)

# Usage

## Requirements

* Ruby 2.2+
* Rails 5.0+


## Running the server

First, ensure you have installed all the requirements listed in the previous section.
Then, run the following commands

```shell
cd <project-root-path>
bundle install
rails -s bind 0.0.0.0
```

After that, you can see the plugin test page in [http://localhost:3000/](http://localhost:3000/):

![widget-test-page](https://cloud.githubusercontent.com/assets/4791678/17797271/fb41a834-659d-11e6-9fca-7d2f470200db.gif)
