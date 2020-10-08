require 'httparty'

<<<<<<< HEAD

<<<<<<< HEAD
class SlackAPIError < Exception; end

class Recipient

    USER_LIST = 'https://slack.com/api/users.list'
    CHANNEL_LIST = 'https://slack.com/api/conversations.list'
=======
class SlackAPIError < StandardError; end

class Recipient

    CHANNEL_LIST = 'https://slack.com/api/conversations.list'
    USER_LIST = 'https://slack.com/api/users.list'
>>>>>>> b25fd29b9406bf01b3ed8a6ec91808e744bbaf54
    MESSAGE_LIST = 'https://slack.com/api/chat.postMessage'
=======
Dotenv.load

class Recipient

    USER_LIST = 'https://slack.com/api/conversations.list'
    CHANNEL_LIST = 'https://slack.com/api/users.list'
>>>>>>> parent of ff0817a... def send_message added

    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def send_message(message)
    end


    def self.get(url, params)
      response = HTTParty.get(url, query: params)

      if !response["ok"]
        raise SlackAPIError, "API call failed with reason #{response['error']}"
      end
      return response
    end



    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.list_all
      raise NotImplementedError, 'Implement me in a child class!'
    end

end
