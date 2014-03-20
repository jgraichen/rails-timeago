
require File.dirname(__FILE__) + '/../spec_helper'

describe Rails::Timeago::Helper do
  before { @stub = TimeagoStub.new }
  after  { Rails::Timeago.reset_default_options }
  let(:time) { Time.now }

  context "#timeago_tag" do
    it 'should create a time tag' do
      @stub.timeago_tag(time).should =~ /<time.*>.*<\/time>/
    end

    it 'should have title attribute' do
      @stub.timeago_tag(time).should =~ /<time.*title=".*".*>.*<\/time>/
    end

    it 'should have human readable datetime as title attribute' do
      @stub.timeago_tag(time).should include("title=\"#{I18n.l time}\"")
    end

    it 'should have human readable datetime as title attribute with given format' do
      @stub.timeago_tag(time, :format => :short).should include("title=\"#{I18n.l time, :format => :short}\"")
    end

    it 'should have human readable datetime as title attribute with given format' do
      @stub.timeago_tag(time, :format => proc { |time, options| :long }).should include("title=\"#{I18n.l time, :format => :long}\"")
    end

    it 'should have human readable datetime as title attribute with global format' do
      Rails::Timeago.default_options :format => :short
      @stub.timeago_tag(time).should include("title=\"#{I18n.l time, :format => :short}\"")
    end

    it 'should have no title attribute if title is set to false globally' do
      Rails::Timeago.default_options :title => false
      @stub.timeago_tag(time).should_not =~ /<time.*title=".*".*>.*<\/time>/
    end

    it 'should have no title attribute if title is set to nil globally' do
      Rails::Timeago.default_options :title => nil
      @stub.timeago_tag(time).should_not =~ /<time.*title=".*".*>.*<\/time>/
    end

    it 'should have title attribute with proc value globally' do
      Rails::Timeago.default_options :title => proc { |time, options| options[:format] }
      @stub.timeago_tag(time, :format => :short).should =~ /<time.*title="short".*>.*<\/time>/
    end

    it 'should have title attribute with proc value locally' do
      @stub.timeago_tag(time, :format => :long,
        :title => proc { |time, options| options[:format] }).should =~ /<time.*title="long".*>.*<\/time>/
    end

    it 'should have format attribute with proc value locally' do
      @stub.timeago_tag(time,
        :format => proc { |time, options| :long }).should include(">#{I18n.l time.to_date, :format => :long}<")
    end

    it 'should have data-time-ago attribute' do
      @stub.timeago_tag(time).should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
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

    it 'should have data-time-ago attribute for times before given limit if limit is in the future' do
      @stub.timeago_tag(5.days.from_now, :limit => 6.days.from_now).
        should =~ /<time.*data-time-ago=".*".*>.*<\/time>/
    end

    it 'should have not data-time-ago attribute for times in the past if limit is in the future' do
      @stub.timeago_tag(1.days.ago, :limit => 5.days.from_now).
        should_not =~ /<time.*data-time-ago=".*".*>.*<\/time>/
    end

    it 'should have not data-time-ago attribute for times after given limit if limit is in the future' do
      @stub.timeago_tag(6.days.from_now, :limit => 5.days.from_now).
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

    it 'should have localized time as content if date_only is false' do
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
      @stub.timeago_tag(time, :myattr => 'abc').should =~ /<time.*myattr="abc".*>.*<\/time>/
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

    it "should return default string if time is nil" do
      @stub.timeago_tag(nil).should == '-'
    end

    it 'should respect limit option also in nojs tag content' do
      time = 6.days.ago

      @stub.timeago_tag(time, :nojs => true, :limit => 5.days.ago).
          should_not =~ /<time.*data-time-ago=".*".*>.*<\/time>/
      @stub.timeago_tag(time, :nojs => true, :limit => 5.days.ago).
          should include(">#{I18n.l time.to_date}<")
    end
  end

  context "#timeago_script_tag" do
    it "should return a javascript snippet to set jQuery timeago locale" do
      I18n.locale = "en"
      @stub.timeago_script_tag.should == '<script>jQuery.timeago.settings.lang="en";</script>'
    end
  end
end
