require './setup'

# Optional parameters :host, :port, otherwise defaults will be used (127.0.0.1:8085)
link = Kuby::Link.new(host: '765d7ed2.ngrok.com', port: 80)

# Connect to KSP

if link.connect!
  puts "Hello, World. We are connected to our rocket!"
end

# Turn on SAS
link.toggle_sas

# Throttle up to full
link.throttle_full

# Turn on first stage
link.stage!

sleep 1

link.stage!

max_fuel = link.current_stage_max_resource('LiquidFuel')
puts "Max Fuel: " + max_fuel.to_s

current_altitude = 0
last_altitude = 0

loop do
  fuel = link.current_stage_resource('LiquidFuel')

  current_altitude = link.altitude

  delta_altitude = current_altitude - last_altitude

  if delta_altitude < 0 && current_altitude < 350
    link.abort
  end

  if fuel < 1
    link.stage!
  end

  puts "Current Fuel: " + fuel.to_s

  sleep 1

  last_altitude = current_altitude
end
