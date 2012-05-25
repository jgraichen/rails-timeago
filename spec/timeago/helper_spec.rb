
require File.dirname(__FILE__) + '/../spec_helper'

describe Rails::Timeago::Helper do
  before { @stub = TimeagoStub.new }

  context "#timeago_tag" do
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

    it "should return default string if time is nil" do
      @stub.timeago_tag(nil).should == '-'
    end
  end

  context "#timeago_script_tag" do
    it "should not return anything if locale is 'en'" do
      I18n.locale = "en"
      @stub.timeago_script_tag.should == ""
    end

    it "should return javascript tag with locale file" do
      I18n.locale = "de"
      @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.de.js"></script>'
    end

    it "should return javascript tag with full locale file if available" do
      I18n.locale = "zh-CN"
      @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.zh-CN.js"></script>'
    end

    it "should return javascript tag with lang locale file if available" do
      I18n.locale = "nl-NL"
      @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.nl.js"></script>'
    end

    it "should return javascript tag with formatted locale file" do
      I18n.locale = "zh-cn"
      @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.zh-CN.js"></script>'
    end

    context "with global locale configuration" do
      before { Rails::Timeago.locales = [:de, :en, "zh-CN", "tlh", "nl"] }
      after  { Rails::Timeago.locales = [] }

      it "should include full locale if available" do
        I18n.locale = "zh-CN"
        @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.zh-CN.js"></script>'
      end

      it "should include lang locale if available" do
        I18n.locale = "nl-NL"
        @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.nl.js"></script>'
      end

      it "should include default locale for not specified locales" do
        I18n.locale = :ar
        I18n.default_locale = :de
        @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.de.js"></script>'

        I18n.default_locale = :en
      end

      it "should find added locales that does not have a locale file in gem" do
        I18n.locale = "tlh"
        @stub.timeago_script_tag.should == '<script src="locales/jquery.timeago.tlh.js"></script>'
    end
    end
  end
end
