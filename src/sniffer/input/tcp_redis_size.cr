class Input::TcpRedisSize
  record Request, time : Time, key : String, size : Int32, src : String

  @max : Request?
  @callback_at : Time

  def initialize(@commands : Array(String), @interval : Time::Span, @callback : Request ->)
    @callback_at = Time.now
    @input_regex = /\A\*3\r\n\$3\r\n(#{@commands.join("|")})\r\n\$\d+\r\n(.*?)\r\n\$(\d+)\r\n/i
  end

  def process(pkt)
    if pkt.tcp_data.to_s =~ @input_regex
      key  = $2
      size = $3.to_i

      if @max.nil? || @max.not_nil!.size < size
        time = pkt.packet_header.time
        @max = Request.new(time, key, size, pkt.src)
      end

      if @callback_at < Time.now
        @callback_at = Time.now + @interval
        @callback.call(@max.not_nil!)
        @max = nil
      end
    end
  end
end
