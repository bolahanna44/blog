# frozen_string_literal: true
class Authentication
  class AuthyError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  class << self
    def send_token(mobile, force_sms, email = 'mrdraper@email.com')
      authy_id = authy_id(mobile, email)
      response = Authy::API.request_sms(id: authy_id, force: force_sms)
      response.ok? ? authy_id : raise(AuthyError, response.errors.dig('message'))
    end

    def verify_token(authy_id, token)
      response = Authy::API.verify(id: authy_id, token: token)
      response.ok? || raise(AuthyError, response.errors.dig('message'))
    end

    private

    def authy_id(mobile, email)
      phone = Phonelib.parse(mobile)
      puts phone.national
      puts phone.country_code
      authy = Authy::API.register_user(email: email,
                                       cellphone: phone.national,
                                       country_code: phone.country_code)

      authy.ok? ? authy.id : raise(AuthyError, authy.errors.dig('message'))
    end
  end
end