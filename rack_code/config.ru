require "./lib/request_handler"

use Rack::Static, :urls => ["/lib/static"]
use Rack::Session::Cookie, :key => 'rack.session',
                           :secret => 'secret'

run RequestHandler