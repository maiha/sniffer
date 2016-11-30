module Sniffer::Config
  delegate str, str?, strs, int, ints, int?, bool, to: @config

  def device
    str("tcp/device")
  end
  
  def snaplen
    int("tcp/snaplen")
  end
  
  def timeout_ms
    int("tcp/timeout_ms")
  end
  
  def filter
    str?("tcp/filter") || ints("tcp/ports").map{|p| "(tcp port #{p})"}.join(" or ")
  end
  
  def input_type
    str("input/type")
  end
  
  def input_commands
    strs("input/commands")
  end
  
  def input_interval
    int("input/interval")
  end
  
  def output_format
    str("output/format")
  end
end
