# Choose the interface
puts "\nChoose interface you wanna work on\n";
interface = STDIN.gets
interface.chop!

# Collect Possible IP addresses 
value = %x(nmap -sP 139.179.164.* |grep -G -o 139.179.164.*)
puts "Neighboor ip addresses:\n"
value = value.split("\n")
value.each_with_index.map do |k,i|
	puts "#{i} #{k}"
end
puts "\nchoose the one typing line number \n"

ip_no = STDIN.gets.to_i
target = value[ip_no];
puts "#{target}"

# Get the mac address of the ip selected 
mac = %x(arping #{target} -c 1 | grep -G -o '..:..:..:..:..:..')
puts "mac address: #{mac}"
system("ifconfig #{interface} down")
puts "\n"
puts "macchanger #{interface} -m #{mac}"
result  = system("macchanger #{interface} -m #{mac}")
system("ifconfig #{interface} up")
puts "Process has been finished with success : #{result}"
