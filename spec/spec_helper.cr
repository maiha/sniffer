require "spec"
require "../src/sniffer"

macro const(name)
  private def {{name.target}}
    {{name.value}}
  end
end
