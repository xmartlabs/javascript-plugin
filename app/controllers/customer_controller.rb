#  customer_controller.rb
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

 # Public: controller in charge of handling customers
class CustomerController < ActionController::Base

  # POST /subscribe
  def subscribe
    return if invalid_client?

    # Register the new client schedule request
    render status: 200, json: {
      success: true
    }
  end

  private

  # Check required parameters for client validation.
  # Returns the client id passed in `params`
  def invalid_client?
    @client_id = params[:client_id]
    return false unless params[:client_id].blank?

    render status: 401, json: {
      success: false,
      error: { code: 1001, message: 'missing client id' }
    }
  end
end