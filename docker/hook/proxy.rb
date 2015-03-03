DOCKER_SERVER_IP = ENV["DOCKER_SERVER_IP"] || "172.17.42.1"
PROXY_DOMAIN = ENV["PROXY_DOMAIN"] || "example.com"

hostname = Nginx::Var.new.http_host
app = hostname.split(".#{PROXY_DOMAIN}").first

begin
  s = UNIXSocket.open("/var/run/docker.sock")
  s.write("GET /containers/#{app}/json HTTP/1.0\r\n\r\n")

  until s.gets.chomp.empty?
  end

  json = JSON::parse(s.read)
ensure
  s.close
end

ports = json["NetworkSettings"]["Ports"]
host_port = nil
%w{ 80/tcp 8080/tcp 8000/tcp 3000/tcp }.each do |p|
  host_port = ports[p].first["HostPort"] if ports.keys.include?(p)
  break if host_port
end
"#{DOCKER_SERVER_IP}:#{host_port}" if host_port
