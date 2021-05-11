def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")


def parse_dns(dns_raw)
  dns_records = { 
    :type => [], 
    :source => [],
    :destination => [] 
  }
  # the map! function was iterate the dns_raw and split and store the return value in dns_raw
  dns_raw.map!{ | dns | dns.strip.split(", ")
  }.filter!{ | dns | # filter fun is used to filter when 1st index is "A" or CNAME 
      dns.each.with_index{ | record, index |
        dns_records[dns_records.keys[index]].push(record)
      } if (dns[0] == "A" || dns[0] == "CNAME")
  }
  return dns_records
end


def resolve(dns_records , lookup_chain , domain)
  dns_records[:destination].each.with_index { |dns , index|
    if(dns_records[:type][index] == "A" && dns_records[:source][index] == domain)
      return lookup_chain.push(dns)
    elsif(dns_records[:source][index] == domain)
      return resolve(dns_records, lookup_chain.push(dns), dns)
    end
  }
  print "Error: record not found for "
  return lookup_chain
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")