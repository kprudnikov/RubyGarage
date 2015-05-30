require "erb"
require_relative "breaker_handler"


class RequestHandler

  def self.call(env)
    new(env).response.finish
  end

  def initialize (env)
    @request = Rack::Request.new(env)
    @game = CodeBreaker::Interface.new
puts "####################################"
puts "NEW GAME!"
puts "####################################"
  end

  def response
    case @request.path
    when "/"
      Rack::Response.new(render("index.html.erb"))
    else
      # Rack::Response.new("Not Found", 404)
      # input = @request.path
      @game.process_input((@request.path)[1..-1]) do |resp|
        # puts response
        Rack::Response.new(resp, 200)
      end
    end
  end
  # def call(env)
  #   Rack::Response.new(render("index.html.erb"))
  # end

  def render(template)
    path = File.expand_path("./lib/views/#{template}")
    ERB.new(File.read(path)).result(binding)
  end

end