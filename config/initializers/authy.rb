require 'authy'
Authy.api_key = Rails.application.credentials[:authy_key]
Authy.api_uri = 'https://api.authy.com'