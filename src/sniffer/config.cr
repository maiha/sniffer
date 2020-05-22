module Sniffer::Config
  delegate str, str?, strs, i32, i32s, i32?, bool, to: @config

  def device
    str("tcp/device")
  end
  
  def snaplen
    i32("tcp/snaplen")
  end
  
  def timeout_ms
    i32("tcp/timeout_ms")
  end
  
  def filter
    str?("tcp/filter") || i32s("tcp/ports").map{|p| "(tcp port #{p})"}.join(" or ")
  end
  
  def input_type
    str("input/type")
  end
  
  def input_commands
    strs("input/commands")
  end
  
  def input_interval
    i32("input/interval")
  end
  
  def output_format
    str("output/format")
  end
end
