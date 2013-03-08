require 'spec_helper'

class TestClass
  include Validate

  attr_reader :string

  def initialize(string)
    @string = string
    
  end
end

describe Validate do

  context '#valid_input?' do
    it 'returns true if characters are alphanumeric or _ or -' do
      testclass = TestClass.new("hello")
      testclass.valid_input?(testclass.string).should be_true
    end

    it 'returns false if characters are special characters/symbols' do
      testclass = TestClass.new("hel@@lo")
      testclass.valid_input?(testclass.string).should be_false
    end
  end
end
