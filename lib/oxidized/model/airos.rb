class Airos < Oxidized::Model
  # Ubiquiti AirOS circa 5.x
  
  prompt /^[^#]+# /
  
  cmd 'cat /etc/board.info' do |cfg|
    cfg.split("\n").map { |line| "# #{line}" }.join("\n") + "\n"
  end
  
  cmd 'sort /tmp/system.cfg'
  
  cmd :secret do |cfg|
    cfg.gsub! /^(users\.\d+\.password|snmp\.community)=.+/, "# \\1=<hidden>"
    cfg
  end

  cfg :ssh do
    exec true
  end
end
