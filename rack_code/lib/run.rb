require "erb"
# require "CodeBreaker"
require_relative "../../CodeBreaker/lib/CodeBreaker.rb"
# require_relative "breaker_handler"


class RequestHandler

  def self.call(env)
    new(env).response.finish
  end

  # def call env


  # end

  # @@games = []

  # def call(env)
  #   @request = Rack::Request.new(env)
  #   @game = @request.session[:game] ||= Codebreaker::Interface.new
  # end

  def initialize (env)
    @request = Rack::Request.new(env)
# puts "####################################"
# puts @request.session
    @request.session[:game] ||= CodeBreaker::Interface.new
    @game = @request.session[:game]
    # @@games << @game
    # puts @request.session[:game] == @game
    # puts @@games
    # @game = CodeBreaker::Interface.new
# puts "NEW GAME!"
# puts "####################################"
  end

  def response
    case @request.path
    when "/"
      Rack::Response.new(render("index.html.erb"))
    when "/new-game"
      # puts "NEW GAME"
      @game.restart_game do |message|
        Rack::Response.new(message, 200)
      end
    else
      # Rack::Response.new("Not Found", 404)
      # input = @request.path
      @game.process_input((@request.path)[1..-1]) do |resp|
        # puts resp
        if(resp == "")
          Rack::Response.new("No match", 200)
        else
          Rack::Response.new(resp, 200)
        end
        # Rack::Response.new(@game.object_id)
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