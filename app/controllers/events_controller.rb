class EventsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate

    sse = SSE.new(response.stream, event: "message")

    sse.write({ message: 'Hi there' })

    sleep 2

    sse.write({ message: 'How are you?' })

    sleep 2

    sse.write({ message: 'I am fine' })
  ensure
    sse.close
  end
end
