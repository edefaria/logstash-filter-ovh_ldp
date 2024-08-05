# encoding: utf-8
require 'spec_helper'
require "logstash/filters/ovh_ldp"

describe LogStash::Filters::Example do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        ovh_ldp {
          data => ">"
        }
      }
    CONFIG
    end

  end
end
