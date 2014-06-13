#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "mailman"

#Mailman.config.logger = Logger.new("log/mailman.log")
Mailman.config.poll_interval = 10
Mailman.config.pop3 = {
    server: 'pop.gmail.com', port: 995, ssl: true,
    username: "grupo05pi@gmail.com",
    password: "badjoras"
}

Mailman::Application.run do
  default do
    begin
      p "Found a new message"
      if message.multipart?
        the_message_html = message.html_part.body.decoded
        the_message_text = message.text_part.body.decoded
      else
        the_message_html = message.body.decoded
        the_message_text = message.body.decoded
      end
      puts '#############################PUTS de Teste 1 #############'
      puts message.from.first
      puts message.to.first
      puts message.subject
      puts the_message_html
      puts the_message_text
      puts '#############################PUTS de Teste 2 #############'
        # Message.create(:from => message.from.first, :to => message.to.first, :subject => message.subject, :html_body => the_message_html, :text_body => the_message_text)

        # map attachments with message object and save other stuff and do other processing or trigger other events..

    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("\n")
    end
  end
end