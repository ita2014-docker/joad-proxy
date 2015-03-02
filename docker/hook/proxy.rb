begin
  s = UNIXSocket.open("/var/run/docker.sock")
  s.write("GET /containers/json HTTP/1.0\r\n\r\n")

  until s.gets.chomp.empty?
  end

  Nginx.echo s.read
ensure
  s.close
end
