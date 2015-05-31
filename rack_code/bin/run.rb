require "erb"
require_relative "../lib/CodeBreaker"

class RequestHandler

  def self.call(env)
    new(env).response.finish
  end

  def initialize (env)
    @request = Rack::Request.new(env)
    @request.session[:game] ||= CodeBreaker::Interface.new
    @game = @request.session[:game]
  end

  def response
    case @request.path
    when "/"
      Rack::Response.new(render("index.html.erb"))
    when "/new-game"
      @game.restart_game do |message|
        Rack::Response.new(message, 200)
      end
    else
      @game.process_input((@request.path)[1..-1]) do |resp|
        if(resp == "")
          Rack::Response.new("No match", 200)
        else
          Rack::Response.new(resp, 200)
        end
      end
    end
  end

  def render(template)
    path = File.expand_path("./lib/views/#{template}")
    ERB.new(File.read(path)).result(binding)
  end

end