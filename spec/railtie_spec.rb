require 'spec_helper'
require 'rails/commands/console'

describe PryRails::Railtie do
  it 'should start Pry instead of IRB' do
    mock(Pry).start
    Rails::Console.start(Rails.application)
    assert RR.verify
  end

  it 'should make the helpers available' do
    stub(Pry).start
    Rails::Console.start(Rails.application)
    RR.verify

    %w(app helper reload!).each do |helper|
      TOPLEVEL_BINDING.eval("respond_to?(:#{helper}, true)").must_equal true
    end
  end
end
