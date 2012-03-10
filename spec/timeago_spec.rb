
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/rails-timeago/helper.rb'
require File.dirname(__FILE__) + '/support/stub.rb'

describe Rails::Timeago::Helper do
  before { @stub = TimeagoStub.new }

  it 'should create a time tag' do
    @stub.timeago_tag(Time.now).should =~ /<time.*>.*<\/time>/
  end

  it 'should have title attribute' do
    @stub.timeago_tag(Time.now).should =~ /<time.*title=".*".*>.*<\/time>/
  end

  it 'should have data-time-ago attribute' do
    @stub.timeago_tag(Time.now).should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it 'should not have data-time-ago attribute for times before limit' do
    @stub.timeago_tag(5.days.ago).should_not =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it 'should have data-time-ago attribute for times after given limit' do
    @stub.timeago_tag(5.days.ago, :limit => 6.days.ago).
      should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it 'should have not data-time-ago attribute for times before given limit' do
    @stub.timeago_tag(6.days.ago, :limit => 5.days.ago).
      should_not =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it 'should have data-time-ago attribute for times before limit if forced' do
    @stub.timeago_tag(6.days.ago, :force => true).
      should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it 'should have localized date as content' do
    time = 3.days.ago
    @stub.timeago_tag(time).should include(">#{I18n.l time.to_date}<")
  end

  it 'should have localized time as content date_only is false' do
    time = 3.days.ago
    @stub.timeago_tag(time, :date_only => false).should include(">#{I18n.l time}<")
  end

  it 'should have time ago in words as content if nojs is true' do
    time = 3.days.ago
    @stub.timeago_tag(time, :nojs => true).should =~ /<time.*>%time_ago_in_words%<\/time>/
  end

  it 'should pass format option to localize method' do
    time = 3.days.ago
    @stub.timeago_tag(time, :format => :short).
      should include(">#{I18n.l time.to_date, :format => :short}<")
  end

  it 'should pass html option to tag helper' do
    @stub.timeago_tag(Time.now, :myattr => 'abc').should =~ /<time.*myattr="abc".*>.*<\/time>/
  end

  it "should allow to set global options" do
    Rails::Timeago.default_options :format => :short, :limit => proc { 8.days.ago }
    time = 7.days.ago

    @stub.timeago_tag(time).
      should include(">#{I18n.l time.to_date, :format => :short}<")
    @stub.timeago_tag(time).
      should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end

  it "should allow to override global options" do
    Rails::Timeago.default_options :format => :short, :limit => proc { 8.days.ago }
    time = 7.days.ago

    @stub.timeago_tag(time, :format => :long).
      should include(">#{I18n.l time.to_date, :format => :long}<")
    @stub.timeago_tag(time, :limit => 4.days.ago).
      should_not =~ /<time.*data-time-ago=".*".*>.*<\/time>/
  end
end