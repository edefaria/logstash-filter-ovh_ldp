# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This filter will remove field with some data.
class LogStash::Filters::Ovh_ldp < LogStash::Filters::Base
  #
  # filter {
  #   ovh_ldp {
  #     data => ">"
  #   }
  # }
  #
  config_name "ovh_ldp"

  # the data to filter
  config :data, :validate => :string, :default => ">"


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    fields = Array.new
     event.to_hash.each {|key,value|
      next if value.nil?
      value = event.get(key)
      if value.is_a?(Array)
        if value.uniq == [ @data ]
          event.remove(key)
          fields << key
        end
      elsif value == @data
        event.remove(key)
        fields << key
      end
      unless fields.nil?
        event.set("X-OVH-FILTER-FIELD", fields.to_s)
        @logger.debug? && @logger.debug("ovh_ldp: remove fields: #{fields}")
      end
    end
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Ovh_ldp
