require "erb"

# require_relative "../CodeBreaker/lib/CodeBreaker"

# game = CodeBreaker::Game.new

# puts game

class RackTest

  def call(env)
    Rack::Response.new(render("index.html.erb"))
  end

  def render(template)
    path = File.expand_path("./lib/views/#{template}")
    ERB.new(File.read(path)).result(binding)
  end

end