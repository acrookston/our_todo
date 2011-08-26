require "rack/csrf"
configure do
  use Rack::Session::Cookie, :secret => "1j8xeIpapziHfLeBEkh9koJYAaLm6vfndCKjh2CEXkMyzcOYz8ElJXWgV7EEYENKT5DluqR5ciYd1h7U"
  use Rack::Csrf, :raise => true
end
