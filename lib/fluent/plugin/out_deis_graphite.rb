require 'fluent/output'
require 'metriks'
require 'metriks/reporter/graphite'
require 'metriks/reporter/logger'

module Fluent
  class SpheroOutput < Output
    Fluent::Plugin.register_output("sphero", self)

    @reporter = nil
    @logging_reporter = nil
    config_param :graphite_url, :string, :default => ''
    config_param :graphite_port, :integer, :default => 2003
    config_param :graphite_interval, :integer, :default => 10

    def initialize
      super
    end

    def start
      super
      puts "Starting reporter: #{@graphite_url}:#{@graphite_port}/#{@graphite_interval}"
      @reporter = Metriks::Reporter::Graphite.new @graphite_url, @graphite_port,:interval => @graphite_interval
      @reporter.start
    end

    def shutdown
      super
    end

    def configure(conf)
      super
    end

    def emit(tag, es, chain)
      es.each do |time,record|
        if record.key? "kubernetes"
          if record["kubernetes"]["container_name"] == "deis-router"
            split_message = record["log"].split(" - ")
            app = split_message[1].strip
            status_code = split_message[4].strip
            #bytes_sent = split_message[6].strip.to_f
            #response_time = split_message[12].strip.to_f
            #request_time = split_message[13].strip.to_f

            Metriks.meter("response_rates.#{record["kubernetes"]["pod_name"]}.#{app}.#{status_code}").mark
          end
         end
      end
      chain.next
    end
  end
end
