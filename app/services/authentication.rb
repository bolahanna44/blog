class Authentication
  class << self
    def send_token(mobile, email)
      response = Authy::API.request_sms(id: authy_id(mobile, email))

      if response.ok?
        # sms was sent
      else
        response.errors
        #sms failed to send
      end
    end

    def verify_token(authy_id, token)
      response = Authy::API.verify(id: authy_id, token: token)

      if response.ok?
        # token was valid, user can sign in
      else
        # token is invalid
      end
    end

    private

    def authy_id(mobile, email)
      authy = Authy::API.register_user(email: email, cellphone: mobile, country_code: "1")

      if authy.ok?
        authy.id # this will give you the user authy id to store it in your database
      else
        authy.errors # this will return an error hash
      end
    end
  end
end