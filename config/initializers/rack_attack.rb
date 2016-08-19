#  rack_attack.rb
#  https://github.com/xmartlabs/javascript-plugin

#  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )


# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Internal: Configuration class for Rack::Attack
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

class Rack::Attack
  ### Throttle Spammy Clients ###

  # Throttle all requests by IP (60rpm)
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle('req/ip', limit: 60, period: 60.seconds) do |req|
    req.ip unless req.path.start_with?('/assets', '/public')
  end

  # Throttle requests to POST /customer/subscribe by IP (20rpm)
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/subscribe_customer:#{req.ip}"
  throttle('req/subscribe_customer', limit: 20, period: 60.seconds) do |req|
    req.ip if req.path.start_with?(Rails.application.routes.url_helpers.customer_subscribe_path) && req.post?
  end

  ### Custom Throttle Response ###

  # Rack::Attack will return an HTTP 503 for throttled responses and will render
  # the 500.html apge
  self.throttled_response = lambda do |_env|
    view = ActionView::Base.new(ActionController::Base.view_paths, {})
    [
      503,  # status
      {},   # headers
      [view.render(file: 'public/500.html')] # body
    ]
  end
end

ActiveSupport::Notifications.subscribe('rack.attack') do |_name, _start, _finish, _request_id, req|
  # Notifies admins about this apparently attack
  puts "###############################################"
  puts "Attack detected to #{req.path}"
  puts "###############################################"
end