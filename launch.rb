require './setup'

# Optional parameters :host, :port, otherwise defaults will be used (127.0.0.1:8085)
link = Kuby::Link.new(host: '765d7ed2.ngrok.com', port: 80)

# Connect to KSP

link.connect!
