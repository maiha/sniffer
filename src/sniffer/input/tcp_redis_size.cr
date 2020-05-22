class Sniffer::Input::TcpRedisSize
  record Message, time : Time, key : String, size : Int32, src : String

  @max : Message?
  @callback_at : Time

  def initialize(@commands : Array(String), @interval : Time::Span, @callback : Message ->)
    @callback_at = Pretty.now
    @input_regex = /\A\*3\r\n\$3\r\n(#{@commands.join("|")})\r\n\$\d+\r\n(.*?)\r\n\$(\d+)\r\n/i
  end

  def match?(str : String)
    str =~ @input_regex
  end
  
  def process(pkt)
    if pkt.tcp_data.to_s =~ @input_regex
      key  = $2
      size = $3.to_i

      if @max.nil? || @max.not_nil!.size < size
        time = pkt.packet_header.time
        @max = Message.new(time, key, size, pkt.src)
      end

      if @callback_at < Pretty.now
        @callback_at = Pretty.now + @interval
        @callback.call(@max.not_nil!)
        @max = nil
      end
    end
  end
end
